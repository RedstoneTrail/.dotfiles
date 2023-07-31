oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\mt.omp.json" | Invoke-Expression

$env:FZF_DEFAULT_COMMAND = "rg --files"
$env:FZF_DEFAULT_OPTS = "
    --preview-window 'right,50%'
    --layout=reverse
    --preview 'bat --style=numbers --color=always {}'
"

New-Alias -Name vim -Value nvim

function just {
	cmd /c just --shell powershell.exe --shell-arg -c $args
}

$workspaces=@("E:/Alan","E:/Alan/Rust","E:/Alan/Web Dev",[Environment]::GetFolderPath("Desktop"))

function FindWorkspace {
	cd E:\Alan
	Get-ChildItem -Attributes Directory -Path $workspaces | % { $_.FullName } | fzf --no-preview | % { cd $_ }
}

Set-PSReadlineKeyHandler -Chord Ctrl+f,Ctrl+w -ScriptBlock { 
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("FindWorkspace")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

function fzf-db {	
	rg --files | rg .*\.db | fzf --preview "sqlite3 {} .tables" | % { sqlite3 $_ }
}

Set-PSReadlineKeyHandler -Chord 'Ctrl+a,"' -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("wt -w 0 split-pane -V")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord 'Ctrl+a,%' -ScriptBlock { 
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("wt -w 0 split-pane --horizontal")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord "Ctrl+a,h","Ctrl+a,LeftArrow" -ScriptBlock { 
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("wt -w 0 move-focus left")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord "Ctrl+a,j","Ctrl+a,DownArrow" -ScriptBlock { 
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("wt -w 0 move-focus down")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord "Ctrl+a,k","Ctrl+a,UpArrow" -ScriptBlock { 
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("wt -w 0 move-focus up")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord "Ctrl+a,l","Ctrl+a,RightArrow" -ScriptBlock { 
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("wt -w 2 move-focus right")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Invoke-Expression -Command $(gh completion -s powershell | Out-String)
Invoke-Expression -Command $(rustup completions powershell | Out-String)
# not currently supported
# Invoke-Expression -Command $(rustup completions powershell cargo | Out-String)
