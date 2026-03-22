$ErrorActionPreference = "Stop"

$image = "django-template-e2e"
$container = "django-template-e2e-container"

try {
  docker build -f docker/build.Dockerfile -t $image .
  docker run -d --name $container -p 28080:8000 $image | Out-Null
  Start-Sleep -Seconds 3

  Invoke-WebRequest -UseBasicParsing http://127.0.0.1:28080/docs | Out-Null
  Invoke-WebRequest -UseBasicParsing http://127.0.0.1:28080/v1/customer | Out-Null

  $login = Invoke-WebRequest -UseBasicParsing http://127.0.0.1:28080/v1/auth/login
  $headerToken = $login.Headers["X-JWT-Token"]
  if (-not $headerToken) { throw "X-JWT-Token header was not returned" }

  $token = ($login.Content | ConvertFrom-Json).token
  if (-not $token) { throw "JWT token not found in response body" }

  Invoke-WebRequest -UseBasicParsing -Headers @{ Authorization = "Bearer $token" } http://127.0.0.1:28080/v1/private | Out-Null
}
finally {
  docker rm -f $container | Out-Null
}
