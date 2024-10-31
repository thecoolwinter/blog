struct SitemapTxtJob: Job {
    var title: String { "Create Sitemap.txt" }
    var handler: () throws -> Void = {
        let sites: [String] = [
            "index.html",
            "about.html"
        ] + JobHelpers.getAllPosts(postsDir: postsDir).map({ $0.url.deletingPathExtension().appendingPathExtension("html").path() })
        let contents = sites.map({ "https://khanwinter.com/" + $0 }).joined(separator: "\n")
        try contents.write(toFile: outDir.appending(path: "sitemap.txt").path(), atomically: true, encoding: .utf8)
    }
}
