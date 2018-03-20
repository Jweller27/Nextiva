
$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://dm.nextiva.com/dms/bc/pc/Nextiva_App.bc-uc.win-22.1.0.280.exe' # download url, HTTPS preferred
$url64      = 'https://dm.nextiva.com/dms/bc/pc/Nextiva_App.bc-uc.win-22.1.0.280.exe' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' #only one of these: exe, msi, msu
  url           = $url
  url64bit      = $url64
  #file         = $fileLocation

  softwareName  = 'Nextiva*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = 'D061609C0DBE3FC1D9F6CAE8EC206568'
  checksumType  = 'MD5' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = 'D061609C0DBE3FC1D9F6CAE8EC206568'
  checksumType64= 'MD5' #default is checksumType

  # MSI
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)

}

Install-ChocolateyPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-package
