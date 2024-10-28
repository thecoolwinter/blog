protocol Job {
    var title: String { get }
    var handler: (JobParams) throws -> Void { get }
}
