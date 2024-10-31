import Foundation

enum JobHelpers {
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

    static func getAllPosts(postsDir: URL) -> [(post: BlogPostContents, url: URL)] {
        return getAllFiles(in: postsDir)
            .filter({ $0.pathExtension == "md" })
            .map { path in
                (try! BlogPostContents(path: path.absoluteURL.path(percentEncoded: false)), path)
            }
    }

    static func createOutDir(_ outDir: URL) throws {
        if !FileManager.default.fileExists(atPath: outDir.path()) {
            try FileManager.default.createDirectory(atPath: outDir.path(), withIntermediateDirectories: true)
        }
    }
}
