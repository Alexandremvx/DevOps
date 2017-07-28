
function check-ms17010 {
#reffer https://support.microsoft.com/en-us/help/4023262/how-to-verify-that-ms17-010-is-installed
Param([Parameter(Mandatory=$true,Position=0)][String[]]$computer,[Parameter(Position=1)]$Cred)
	$kblist = "KB4012212,KB4012215,KB4012218,KB4015549,KB4015552,KB4019263,KB4019264,KB4012213,KB4012216,KB4012219,KB4015550,KB4015553,KB4019213,KB4019215,KB4019265,KB4022722,KB4022168,KB4019217,KB4022717,KB4022720,KB4012598,KB4018466,KB4025341" -split ","
	$Par= @{}
	if ($cred) {$Par.credential = $cred}
	$computer | % {
	    Remove-Variable kb -ea 0
		#Get-WmiObject -Class "win32_quickfixengineering" -Computername $_  @Par | where {$_.HotfixID -eq "KB4019264" }
        $kb = Get-WmiObject -Class "win32_quickfixengineering" -Computername $_  @Par | where {$_.HotfixID -in $kbList }

        $_ | select @{N="Server";E={$_}},@{N="OK";E={if($kb){"yes"}else{"no"}}},@{N="HotFix";E={$kb.HotFixID}},@{N="QuemInstalou";E={$kb.InstalledBy}}



	}
}


