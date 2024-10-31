import Foundation

struct CopyResourcesJob: Job {
    var title: String { "Copy Resources To Output Dir" }
    var handler: () throws -> Void = {
        let outDir = outDir.appending(path: "resources")

        if !FileManager.default.fileExists(atPath: outDir.path()) {
            try FileManager.default.createDirectory(atPath: outDir.path(), withIntermediateDirectories: true)
        }

        for origFile in JobHelpers.getAllFiles(in: rootDir.appending(path: Constants.resourcesDir)) {
            try FileManager.default.copyItem(at: origFile, to: outDir.appending(path: origFile.relativePath))
        }
    }
}
