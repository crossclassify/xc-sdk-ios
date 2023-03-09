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
    var hasTrackedButton = false
    
    var _formviewAt: TimeInterval = NSDate().timeIntervalSince1970
    var timeToFirstSubmit: TimeInterval = 0.0
    
    func retrieveFields(in view: UIView) {
        for subview in view.subviews {
            if let field = subview as? TrackedField {
                fields[field.id!] = FieldTrack(trackedField: field)
            } else if let button = subview as? TrackedUIButton {
                hasTrackedButton = true
                button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            } else {
                retrieveFields(in: subview)
            }
        }
    }
    
    func validateForm() {
        var hasEmailField = false
        for field in fields {
            if field.value.id.contains("email") {
                if(!field.value.trackContent) {
                    CrossClassify.logger.error("trackContent must be True in email field. (Form ID: \(self.formviewId))")
                }
                hasEmailField = true
            }
        }
        if(formName.contains("login") || formName.contains("signup")) {
            if !hasEmailField {
                CrossClassify.logger.error("Email field not found in login/signup form. (Form ID: \(self.formviewId))")
            }
        }
        if !hasTrackedButton {
            CrossClassify.logger.log("No submit button (TrackedUIButton) found in the form. (Form ID: \(self.formviewId))", with: (formName.contains("login") || formName.contains("signup")) ? LogLevel.error : LogLevel.warning)
        }
    }
    
    @objc func pressed() {
        father.sendForm()
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
