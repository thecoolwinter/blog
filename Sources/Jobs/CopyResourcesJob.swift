import Foundation

struct CopyResourcesJob: Job {
    var title: String { "Copy Resources To Output Dir" }
    var handler: (JobParams) throws -> Void = { params in
        try createOutDir(params)

        let outDir = params.outDir.appending(path: "resources")

        if !FileManager.default.fileExists(atPath: outDir.path()) {
            try FileManager.default.createDirectory(atPath: outDir.path(), withIntermediateDirectories: true)
        }

        for origFile in getAllFiles(in: params.rootDir.appending(path: Constants.resourcesDir)) {
            try FileManager.default.copyItem(at: origFile, to: outDir.appending(path: origFile.relativePath))
        }
    }
}
