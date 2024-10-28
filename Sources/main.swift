import Foundation

guard CommandLine.arguments.count == 2 else {
    fatalError("Invalid Argument Count")
}

private let rootDir = URL(fileURLWithPath: CommandLine.arguments[1])
private let postsDir = rootDir.appending(path: Constants.postsDir)
private let outDir = rootDir.appending(path: Constants.outDir)

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
        BlogPostJob()
    ]

    let params = JobParams(rootDir: rootDir, postsDir: postsDir, outDir: outDir)

    for (idx, job) in jobs.enumerated() {
        print("Step \(idx): \(job.title)")
        try job.handler(params)
    }

    print("Finished! 🎉")
} catch {
    fatalError(error.localizedDescription)
}
