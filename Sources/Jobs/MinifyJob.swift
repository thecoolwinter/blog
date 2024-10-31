import Foundation

struct MinifyJob: Job {
    var title: String { "Minify Assets" }
    var handler: () throws -> Void = {
        let taskShell = Process()
        var envShell = ProcessInfo.processInfo.environment
        taskShell.launchPath = "/bin/zsh"
        taskShell.arguments = ["-c","eval $(/usr/libexec/path_helper -s) ; echo $PATH"]
        let pipeShell = Pipe()
        taskShell.standardOutput = pipeShell
        taskShell.standardError = pipeShell
        taskShell.launch()
        taskShell.waitUntilExit()
        let dataShell = try pipeShell.fileHandleForReading.readToEnd()!
        var outputShell: String = String(decoding: dataShell, as: UTF8.self)
        outputShell = outputShell.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)

        let process = Process()
        process.environment = ProcessInfo.processInfo.environment
        process.environment?["PATH"] = (process.environment?["PATH"] ?? "") + ":" + outputShell
        process.arguments = [
            "-c",
            "cd \(rootDir.path(percentEncoded: false))/Scripts && ./minify.sh ../.html"
        ]
        process.executableURL = URL(fileURLWithPath: "/bin/zsh")
        try process.run()
        process.waitUntilExit()
    }
}
