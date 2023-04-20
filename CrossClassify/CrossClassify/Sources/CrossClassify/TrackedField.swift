protocol TrackedField {
    var id: String? { get }
    var content: String { get }
    var trackContent: Bool { get }
    var metadata: Metadata { get }
    var fieldType: String? { get }
}
