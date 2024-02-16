Write-Host "Starting sync" -ForegroundColor Green
Write-Host "Copying Astrovim config" -ForegroundColor Green
$FileName = "astrovimconfig"
if (Test-Path $FileName) {
   Write-Host "Deleting file" -ForegroundColor Red
   Remove-Item $FileName -verbose
}
Copy-Item -Path $env:LOCALAPPDATA\nvim\lua\user -Destination astrovimconfig -Recurse
Write-Host "Done Copying Astrovim config" -ForegroundColor Green

Write-Host "Copying Wezterm config" -ForegroundColor Green
Copy-Item -Path $env:USERPROFILE\.wezterm.lua -Destination .
Write-Host "Done Wezterm config" -ForegroundColor Green

