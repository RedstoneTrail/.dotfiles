import * as vscode from "vscode"

export function activate(context: vscode.ExtensionContext) {
  let disposable = vscode.commands.registerCommand("fzf.run", () => {
    let files = vscode.workspace.textDocuments
    let fileNameData = files
      .map(
        (file, index) => `${index} ${file.fileName.replaceAll(/["'\$]/gms, "")}`
      )
      .join("\0")

    let task = new vscode.Task(
      { type: "shell" },
      vscode.TaskScope.Workspace,
      "fzf find file",
      "fzf",
      new vscode.ShellExecution(
        `\\"${fileNameData}\\" | fzf --no-preview --read0`
      )
    )
    task.presentationOptions = {
      reveal: vscode.TaskRevealKind.Always,
      focus: true,
      panel: vscode.TaskPanelKind.Dedicated,
      showReuseMessage: false,
      clear: true,
    }
    task.isBackground = true

    vscode.tasks.executeTask(task).then((result) => {
      console.log(result)
      disposable.dispose(task)
    })
    // vscode.workspace.openTextDocument()
  })

  context.subscriptions.push(disposable)
}

export function deactivate() {}
