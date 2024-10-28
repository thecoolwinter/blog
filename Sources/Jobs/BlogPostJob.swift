import Foundation

extension Job {
    static func getAllFiles(in path: URL) -> [URL] {
        guard let enumerator = FileManager.default.enumerator(
            at: path,
            includingPropertiesForKeys: [.isRegularFileKey],
            options: [.skipsHiddenFiles, .skipsPackageDescendants, .producesRelativePathURLs]
        ) else {
            fatalError("failed to create enumerator")
        }
        return enumerator.allObjects.compactMap({ $0 as? URL })
    }

    static func getAllPosts(_ params: JobParams) -> [URL] {
        return getAllFiles(in: params.postsDir).filter({ $0.pathExtension == "md" })
    }

    static func createOutDir(_ params: JobParams) throws {
        if !FileManager.default.fileExists(atPath: params.outDir.path()) {
            try FileManager.default.createDirectory(atPath: params.outDir.path(), withIntermediateDirectories: true)
        }
    }
}

struct BlogPostJob: Job {
    var title: String { "Write Posts To Disk" }
    var handler = { (params: JobParams) in
        try createOutDir(params)

        for path in getAllPosts(params) {
            let outURL = params.outDir.appending(path: path.relativePath).deletingPathExtension().appendingPathExtension("html")
            print(" - Writing Post:", outURL.relativePath)
            let html = HTMLRenderer.render {
                BlogPost(path: path.absoluteURL.path(percentEncoded: false))
            }
            if !FileManager.default.fileExists(atPath: outURL.deletingLastPathComponent().path()) {
                try FileManager.default.createDirectory(at: outURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            }
            try html.write(to: outURL, atomically: true, encoding: .utf8)
        }
    }
}
