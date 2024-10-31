import Foundation

struct CleanOutJob: Job {
    var title: String { "Clean Output Folder" }
    var handler: () throws -> Void = {
        if FileManager.default.fileExists(atPath: outDir.path()) {
            try FileManager.default.removeItem(at: outDir)
            try JobHelpers.createOutDir(outDir)
        }
    }
}
