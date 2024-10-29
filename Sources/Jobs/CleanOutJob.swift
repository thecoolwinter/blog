import Foundation

struct CleanOutJob: Job {
    var title: String { "Clean Output Folder" }
    var handler: (JobParams) throws -> Void = { params in
        try FileManager.default.removeItem(at: params.outDir)
        try JobHelpers.createOutDir(params.outDir)
    }
}
