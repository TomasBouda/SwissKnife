function Get-PublicIP {
	(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
}