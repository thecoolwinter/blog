protocol Job {
    var title: String { get }
    var handler: () throws -> Void { get }
}
