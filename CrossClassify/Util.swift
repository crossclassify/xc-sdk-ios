import Foundation
import SwiftUI

struct Util {
    static func updateField(cc: CrossClassify, field: TrackedField) {
        cc.formInteractionTracker.formTrack?.fields[field.id!] = FieldTrack(trackedField: field)
    }
    
//    static func editingChanged(_ timeSpentEditing: State<Double>, _ timeSpentBeforeEditing: inout State<Double>?, _ latestEditingStartedAt: State<Double>?, _ isChangedSinceLastEditing: inout State<Bool>, _ numChanges: inout State<Int>, _ firstChangeAt: inout State<Double>?, _ latestChangeAt: inout State<Double>?)  {
//        let currentTimestamp = NSDate().timeIntervalSince1970
//        if timeSpentBeforeEditing == nil && latestEditingStartedAt != nil {
//            timeSpentBeforeEditing =  timeSpentEditing + (currentTimestamp - latestEditingStartedAt!)
//        }
//        if !isChangedSinceLastEditing {
//            if numChanges == 0 {
//                firstChangeAt = currentTimestamp
//            }
//            numChanges += 1
//            latestChangeAt = currentTimestamp
//            isChangedSinceLastEditing = true
//        }
//    }
}
