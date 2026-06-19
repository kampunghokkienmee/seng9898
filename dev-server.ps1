param(
  [string]$Root = (Get-Location).Path,
  [int]$Port = 4173
)

Add-Type -AssemblyName System.Web

$rootFull = [System.IO.Path]::GetFullPath($Root)
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Parse("127.0.0.1"), $Port)
$listener.Start()

Write-Host "POS preview: http://127.0.0.1:$Port/"

function Get-ContentType {
  param([string]$Path)

  $ext = [System.IO.Path]::GetExtension($Path).ToLowerInvariant()
  switch ($ext) {
    ".html" { "text/html; charset=utf-8" }
    ".css" { "text/css; charset=utf-8" }
    ".js" { "application/javascript; charset=utf-8" }
    ".json" { "application/json; charset=utf-8" }
    ".png" { "image/png" }
    ".jpg" { "image/jpeg" }
    ".jpeg" { "image/jpeg" }
    ".svg" { "image/svg+xml" }
    default { "application/octet-stream" }
  }
}

try {
  while ($true) {
    $client = $listener.AcceptTcpClient()
    try {
      $stream = $client.GetStream()
      $reader = [System.IO.StreamReader]::new($stream, [Text.Encoding]::ASCII, $false, 1024, $true)
      $requestLine = $reader.ReadLine()

      while ($reader.Peek() -gt -1) {
        $line = $reader.ReadLine()
        if ([string]::IsNullOrEmpty($line)) { break }
      }

      $path = "index.html"
      if ($requestLine -match "^[A-Z]+\s+([^\s]+)") {
        $urlPath = $matches[1].Split("?")[0].TrimStart("/")
        $decodedPath = [System.Web.HttpUtility]::UrlDecode($urlPath)
        if (-not [string]::IsNullOrWhiteSpace($decodedPath)) {
          $path = $decodedPath
        }
      }

      $full = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($rootFull, $path))
      $allowed = $full.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)

      if (-not $allowed -or -not [System.IO.File]::Exists($full)) {
        $status = "404 Not Found"
        $contentType = "text/plain; charset=utf-8"
        $bytes = [Text.Encoding]::UTF8.GetBytes("Not found")
      } else {
        $status = "200 OK"
        $contentType = Get-ContentType $full
        $bytes = [System.IO.File]::ReadAllBytes($full)
      }

      $header = "HTTP/1.1 $status`r`nContent-Type: $contentType`r`nContent-Length: $($bytes.Length)`r`nConnection: close`r`n`r`n"
      $headerBytes = [Text.Encoding]::ASCII.GetBytes($header)
      $stream.Write($headerBytes, 0, $headerBytes.Length)
      $stream.Write($bytes, 0, $bytes.Length)
    } finally {
      $client.Close()
    }
  }
} finally {
  $listener.Stop()
}
