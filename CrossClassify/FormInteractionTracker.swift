import Foundation
import UIKit
import SwiftUI

public class FormInteractionTracker {
    
    var matomoTracker: MatomoTracker
    var formTrack: FormTrack? = nil
    
    var senderTimer: Timer? = nil
    
    internal init(_ matomoTracker: MatomoTracker) {
        self.matomoTracker = matomoTracker
    }
    
    internal func track(formName: String, view: UIView?, pageviewId: String){
        let formTrack = FormTrack(formName, in: pageviewId, father: self)
        if view != nil {
            formTrack.retrieveFields(in: view!)
        }
        startSending()
        self.formTrack = formTrack
    }
    
    internal func stopTrack() {
        stopSending()
        formTrack = nil
    }
    
    internal func startSending(){
        senderTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [self] (timer) in
            print("run every 5 seconds... ")
            sendForm(false)
        }
    }
    
    internal func stopSending(){
        senderTimer?.invalidate()
    }
    
    public func sendForm(_ submit: Bool? = true) {
        
        if formTrack == nil {
            return
        }
        
        var items: [FormField] = []
        for (name, field) in formTrack!.fields {
            items.append(FormField(fa_fn: name,
                                   fa_cn: (field.trackContent ? field.content : nil),
                                   fa_fts: field.timeSpentEditing != nil ? Int(field.timeSpentEditing!) : nil,
                                   fa_fht: field.timeSpentBeforeEditing != nil ? Int(field.timeSpentBeforeEditing!) : nil,
                                   fa_fb: field.timeSpentEditing == 0,
                                   fa_fch: field.numChanges,
                                   fa_ff: field.numFocus,
                                   fa_fd: field.numDeletes,
                                   fa_cu: field.numCursor,
                                   fa_ft: field.fieldType, // web-sdk: n = ["password", "text", "url", "tel", "email", "search", "", null] or ios: UITextContentType
                                   fa_fs: field.content?.count))
        }
        if submit! && formTrack!.timeToFirstSubmit == 0 {
            formTrack!.timeToFirstSubmit = formTrack!.timeSpentInForm
        }
        matomoTracker.trackForm(items: items,
                                     fa_vid: formTrack!.formviewId,
                                     pv_id: formTrack!.pageviewId,
                                     fa_name: formTrack!.formName,
                                     fa_id: formTrack!.formName,
                                     fa_su: (submit! ? 1 : 0),
                                     fa_ef: formTrack!.firstEditedFieldId,
                                     fa_lf: formTrack!.lastEditedFieldId,
                                     fa_ts: Int(formTrack!.timeSpentInForm),
                                     fa_ht: formTrack!.timeSpentBeforeEditing != nil ? Int(formTrack!.timeSpentBeforeEditing!) : nil,
                                     fa_st: formTrack!.isStarted ? 1 : 0,
                                     fa_tts: Int(formTrack!.timeToFirstSubmit))
        matomoTracker.dispatch()
        print("\(formTrack?.toString() ?? "formTrack is nil")")
    }
}
