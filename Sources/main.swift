import Foundation

guard CommandLine.arguments.count == 2 else {
    fatalError("Invalid Argument Count")
}

let rootDir = URL(fileURLWithPath: CommandLine.arguments[1])
let postsDir = rootDir.appending(path: Constants.postsDir)
let outDir = rootDir.appending(path: Constants.outDir)

struct JobParams {
    let rootDir: URL
    let postsDir: URL
    let outDir: URL
}

do {
    let jobs: [any Job] = [
        CleanOutJob(),
        CopyResourcesJob(),
        HomePageJob(),
        AboutPageJob(),
        NotFoundPageJob(),
        BlogPostJob(),
        CopySupplementalsJob(),
        SitemapTxtJob(),
        RobotsTxtJob(),
        MinifyJob()
    ]

    for (idx, job) in jobs.enumerated() {
        print("Step \(idx): \(job.title)")
        try job.handler()
    }

    print("Finished! 🎉")
} catch {
    fatalError(error.localizedDescription)
}
