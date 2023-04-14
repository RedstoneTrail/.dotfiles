oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\mt.omp.json" | Invoke-Expression

$env:FZF_DEFAULT_COMMAND = "rg --files"
$env:FZF_DEFAULT_OPTS = "
    --preview-window 'right,50%'
    --layout=reverse
    --preview 'bat --style=numbers --color=always {}'
"

New-Alias -Name vim -Value nvim

$workspaces=@("E:/Alan","E:/Alan/Rust","E:/Alan/Web Dev",[Environment]::GetFolderPath("Desktop"))

function FindWorkspace {
	cd E:\Alan
	Get-ChildItem -Attributes Directory -Path $workspaces | % { $_.FullName } | fzf --no-preview | % { vim $_ }
}

Set-PSReadlineKeyHandler -Chord "Ctrl+f,Ctrl+w" -ScriptBlock { 
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("FindWorkspace")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()

}

Invoke-Expression -Command $(gh completion -s powershell | Out-String)
Invoke-Expression -Command $(rustup completions powershell | Out-String)
# not currently supported
# Invoke-Expression -Command $(rustup completions powershell cargo | Out-String)
