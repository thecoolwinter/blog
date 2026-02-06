import Foundation

struct BlogPostJob: Job {
    var title: String { "Write Posts To Disk" }
    var handler = {
        for post in JobHelpers.getAllPosts(postsDir: postsDir) {
            let outURL = outDir.appending(path: post.path.relativePath).deletingPathExtension().appendingPathExtension("html")
            print(" - Writing Post:", outURL.relativePath)
            let html = HTMLRenderer.render {
                BlogPost(post: post)
            }
            if !FileManager.default.fileExists(atPath: outURL.deletingLastPathComponent().path()) {
                try FileManager.default.createDirectory(at: outURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            }
            try html.write(to: outURL, atomically: true, encoding: .utf8)
        }
    }
}
