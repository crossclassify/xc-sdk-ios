import Foundation
import SwiftUI

struct Util {
    static func updateField(cc: CrossClassify, field: TrackedField) {
        cc.formInteractionTracker.formTrack?.fields[field.id!] = FieldTrack(trackedField: field)
    }
}
