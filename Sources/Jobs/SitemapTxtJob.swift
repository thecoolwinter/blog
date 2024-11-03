struct SitemapTxtJob: Job {
    var title: String { "Create Sitemap.txt" }
    var handler: () throws -> Void = {
        let sites: [String] = [
            "",
            "about"
        ] + JobHelpers.getAllPosts(postsDir: postsDir).map({
            $0.url.deletingLastPathComponent().path()
        })

        let contents = sites.map({ "https://khanwinter.com/" + $0 }).joined(separator: "\n")
        try contents.write(toFile: outDir.appending(path: "sitemap.txt").path(), atomically: true, encoding: .utf8)
    }
}
