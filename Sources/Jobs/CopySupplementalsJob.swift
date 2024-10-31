import Foundation

struct CopySupplementalsJob: Job {
    var title: String { "Copying Supplemental Post Files" }
    var handler: () throws -> Void = {
        var count = 0
        for file in JobHelpers.getAllFiles(in: postsDir)
        where file.pathExtension != "md" && !file.hasDirectoryPath {
            try FileManager.default.copyItem(at: file, to: outDir.appending(path: file.relativePath))
            count += 1
        }
        print(" - Copied \(count) files")
    }
}
