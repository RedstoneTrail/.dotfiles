import * as vscode from "vscode"
import {
  ExtensionContext,
  Task,
  ShellExecution,
  TaskRevealKind,
  TaskPanelKind,
  TaskScope,
  workspace,
  commands,
  window,
} from "vscode"
import * as os from "node:os"
import * as path from "node:path"
import * as fs from "node:fs"

const tmpdir = os.tmpdir()
const pathListPath = path.resolve(tmpdir, `vscode-fzf-pathlist.tmp`)
const selectedPath = path.resolve(tmpdir, `vscode-fzf-selected.tmp`)

function cleanup(): void {
  if (fs.existsSync(pathListPath)) fs.rmSync(pathListPath)
  if (fs.existsSync(selectedPath)) fs.rmSync(selectedPath)
}

export function activate(context: ExtensionContext) {
  const glob: string = vscode.workspace.getConfiguration("fzf").get("glob")!
  const maxFiles: number = vscode.workspace
    .getConfiguration("fzf")
    .get("max-files")!

  const disposable = commands.registerCommand("fzf.run", async () => {
    const files = await workspace.findFiles(glob, undefined, maxFiles)

    const pathList = files
      .map((file, index) => `${index}: ${workspace.asRelativePath(file)}`)
      .join("\n")

    fs.writeFileSync(pathListPath, pathList, "utf-8")

    const task = new Task(
      { type: "shell" },
      TaskScope.Workspace,
      "fzf find file",
      "fzf",
      new ShellExecution(
        `cmd /c 'set FZF_DEFAULT_COMMAND= && set FZF_DEFAULT_OPTS= && fzf --no-preview < ${pathListPath} > ${selectedPath}'`
      )
    )
    task.presentationOptions = {
      reveal: TaskRevealKind.Always,
      focus: true,
      panel: TaskPanelKind.Dedicated,
      showReuseMessage: false,
      clear: true,
    }
    task.isBackground = true

    const execution = await vscode.tasks.executeTask(task)
    vscode.tasks.onDidEndTaskProcess(async (endedExecution) => {
      if (endedExecution.execution != execution) return
      if (!fs.existsSync(selectedPath)) return

      const result = fs.readFileSync(selectedPath, "utf-8").split(":")[0]
      workspace.openTextDocument(files[+result]).then((doc) => {
        window.showTextDocument(doc)
      })
      console.log("fzf: changed file")
    })
  })

  context.subscriptions.push(disposable)
}

export function deactivate() {
  cleanup()
}
