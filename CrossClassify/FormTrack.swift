import Foundation
import UIKit
import SwiftUI


internal class FormTrack {
    internal init(_ formName: String, in pageviewId: String, father: FormInteractionTracker) {
        self.formName = formName
        self.pageviewId = pageviewId
        self.father = father
    }
    
    let formviewId = CrossClassify.randomString(length: 6)
    let pageviewId: String
    let father: FormInteractionTracker
    var formName: String
    var fields: [String: FieldTrack] = [:]
    
    var _formviewAt: TimeInterval = NSDate().timeIntervalSince1970
    var timeToFirstSubmit: TimeInterval = 0.0
    
//    private static var trackingTimer: Timer?
    
    func retrieveFields(in view: UIView) {
        
        for subview in view.subviews {
            if let field = subview as? TrackedField {
                fields[field.id!] = FieldTrack(trackedField: field)
            } else if let button = subview as? TrackedUIButton {
                button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            } else {
                retrieveFields(in: subview)
            }
        }
    }
    
    @objc func pressed() {
        father.sendForm() //TODO: do place it to right class
    }
    
    
    var firstEditedFieldId: String? {
        get {
            var firstId: String? = nil
            var firstIdChangedAt = Double.infinity
            for (id, field) in fields {
                if field.firstChangeAt != nil {
                    if field.firstChangeAt! < firstIdChangedAt {
                        firstIdChangedAt = field.firstChangeAt!
                        firstId = id
                    }
                }
                
            }
            return firstId
        }
    }
    var lastEditedFieldId: String? {
        var latestId: String? = nil
        var latestIdChangedAt = 0.0
        for (id, field) in fields {
            if field.latestChangeAt != nil {
                if field.latestChangeAt! > latestIdChangedAt {
                    latestIdChangedAt = field.latestChangeAt!
                    latestId = id
                }
            }
        }
        return latestId
    }
    var timeSpentInForm: TimeInterval {
        get {
            return NSDate().timeIntervalSince1970 - _formviewAt
        }
    }
    var timeSpentBeforeEditing: TimeInterval? {
        get {
            var firstChangeAt: TimeInterval = Double.infinity
            for (_, field) in fields {
                if field.firstChangeAt != nil {
                    if field.firstChangeAt! < firstChangeAt {
                        firstChangeAt = field.firstChangeAt!
                    }
                }
            }
            if firstChangeAt == Double.infinity {
                return nil
                
            }
            return firstChangeAt - _formviewAt
        }
    }
    
    var isStarted: Bool {
        get {
            return timeSpentBeforeEditing != nil
        }
    }
    
    
//    func startTracking() {
//        let UNIT: Double = 0.1
//        trackingTimer = Timer.scheduledTimer(withTimeInterval: UNIT, repeats: true) { [self, UNIT] (trackingTimer) in
//            var sumNumChanges: Int = 0
//            for (name, field) in fields {
//                if field.isEditing {
//
//                    sumNumChanges += field.numChanges
//
//                    if field.numChanges == 0 {
//                        fields[name]?.timeSpentBeforeEditing += UNIT
//                    }
//                    fields[name]?.timeSpentEditing += UNIT
//
//                    if lastEditedFieldId != field.id {
//                        fields[name]?.numFocus += 1
//                        fields[name]?.changeSinceLastFocus = false
//                        fields[name]?.initialContent = field.content!
//                    }
//
//                    if !field.changeSinceLastFocus && field.content != field.initialContent {
//                        fields[name]?.numChanges += 1
//                        fields[name]?.changeSinceLastFocus = true
//                    }
//
//
//                    if firstEditedFieldId == nil {
//                        firstEditedFieldId = field.id
//                    }
//                    lastEditedFieldId = field.id
//
//                }
//            }
//            if sumNumChanges == 0 {
//                timeSpentBeforeEditing += UNIT
//            }
//            timeSpentInForm += UNIT
//        }
//    }
    
//    internal func stopTracking() {
//        trackingTimer?.invalidate()
//    }
    
    internal func toString() -> String {
        var string = "Form ID: \(formviewId)\n"
        string += "Form Name: \(formName)\n"
        string += "Total time spent in form: \(timeSpentInForm)\n"
        string += "Time spent before first change: \(timeSpentBeforeEditing != nil ? String(timeSpentBeforeEditing!) : "N/A")\n"
        string += "Time to first submission: \(timeToFirstSubmit)\n"
        string += "First edited field ID: \(firstEditedFieldId ?? "N/A")\n"
        string += "Last edited field ID: \(lastEditedFieldId ?? "N/A")\n"
        string += "Fields:\n"
        for field in fields.values {
            string += "  - ID: \(field.id)\n"
            string += "    track content: \(field.trackContent)\n"
            string += "    content: \(field.content ?? "")\n"
            string += "    Total focused time:\(field.timeSpentEditing != nil ? String(field.timeSpentEditing!) : "N/A")\n"
            string += "    Focused time before first change: \(field.timeSpentBeforeEditing != nil ? String(field.timeSpentBeforeEditing!) : "N/A")\n"
//            string += "    Currently editing: \(field.isEditing)\n"
            string += "    Number of changes: \(field.numChanges != nil ? String(field.numChanges!) : "N/A")\n"
            string += "    Number of focuses: \(field.numFocus != nil ? String(field.numFocus!) : "N/A")\n"
            string += "    Number of deletes: \(field.numDeletes != nil ? String(field.numDeletes!) : "N/A")\n"
//            string += "    Number of cursors: \(field.numCursor)\n"
        }
        string += "-------------------------\n"
        return string
    }
    
}
