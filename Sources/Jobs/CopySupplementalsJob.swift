import Foundation

struct CopySupplementalsJob: Job {
    var title: String { "Copying Supplemental Post Files" }
    var handler: () throws -> Void = {
        var count = 0
        for file in JobHelpers.getAllFiles(in: postsDir)
        where file.pathExtension != "md" && !file.hasDirectoryPath {
            let destination = outDir.appending(path: file.relativePath)
            if !FileManager.default.fileExists(atPath: destination.deletingLastPathComponent().path()) {
                try FileManager.default.createDirectory(
                    at: destination.deletingLastPathComponent(),
                    withIntermediateDirectories: true
                )
            }
            try FileManager.default.copyItem(at: file, to: destination)
            count += 1
        }
        print(" - Copied \(count) files")
    }
}
