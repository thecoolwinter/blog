struct RobotsTxtJob: Job {
    var title: String  { "Create Robots.txt" }
    var handler: () throws -> Void = {
        let contents = """
        User-agent: *
        Allow: /
        
        Sitemap: https://khanwinter.com/sitemap.txt
        """
        try contents.write(toFile: outDir.appending(path: "robots.txt").path(), atomically: true, encoding: .utf8)
    }
}
