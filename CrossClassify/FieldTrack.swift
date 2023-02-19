
import Foundation
import SwiftUI


struct FieldTrack {
    internal init(trackedField: TrackedField? = nil) {
//    internal init(id: String? = nil, trackContent: Bool, trackedField: TrackedField? = nil) {
//        self._id = id
//        self._trackContent = trackContent
        self.trackedField = trackedField
    }
    
//    let _id: String?
//    let _trackContent: Bool
    
    let trackedField: TrackedField?

//    var timeSpentEditing: TimeInterval = 0
//    var timeSpentBeforeEditing: TimeInterval = 0
    
//    var numChanges: Int = 0
//    var numFocus: Int = 0
//    var numDeletes: Int = 0
//    var numCursor: Int = 0
    
//    var changeSinceLastFocus: Bool = false
//    var initialContent: String?
    
    internal var id: String { get { return trackedField?.id ?? "unknown"}}
    internal var trackContent: Bool { get { return trackedField?.trackContent ?? false }}
    internal var content: String? { get { return trackedField?.content }}
    internal var timeSpentEditing: TimeInterval? { get { return trackedField?.metadata.timeSpentEditing}}
    internal var timeSpentBeforeEditing: TimeInterval? { get { return trackedField?.metadata.timeSpentBeforeEditing}}
    internal var firstChangeAt: TimeInterval? { get { return trackedField?.metadata.firstChangeAt}}
    internal var latestChangeAt: TimeInterval? { get { return trackedField?.metadata.latestChangeAt}}
    internal var numChanges: Int? { get { return trackedField?.metadata.numChanges}}
    internal var numFocus: Int? { get { return trackedField?.metadata.numFocus}}
    internal var numDeletes: Int? { get { return trackedField?.metadata.numDeletes}}
    internal var numCursor: Int? { get { return trackedField?.metadata.numCursor}}
    internal var fieldType: String { get { return trackedField?.fieldType ?? "" }}
    
    
//    internal var isEditing: Bool {
//        get {
//            return trackedField?.getIsEditing() ?? false
//        }
//    }
    
}
