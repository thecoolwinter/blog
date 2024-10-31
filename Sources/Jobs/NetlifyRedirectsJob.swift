struct NetlifyRedirectsJob: Job {
    var title: String  { "Create Netlify Redirects File" }
    var handler: () throws -> Void = {
        let contents = """
        /* https://khanwinter.com/ 301!
        """
        try contents.write(toFile: outDir.appending(path: "_redirects").path(), atomically: true, encoding: .utf8)
    }
}
