import Foundation
import UIKit

class TrackedUITextField: UITextField, UITextFieldDelegate, TrackedField { //TODO: do other field types
    
    @IBInspectable var id: String?
    @IBInspectable var includeContent: String? //TODO: do change to bool or nil var
    
    var metadata = Metadata(trackFocus: true, trackDelete: true)
    
//    var initialContent: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if value(forKey: "id") == nil {
            fatalError("TrackedField's \"id\" must be provided")
        }
        
        metadata._textLen = (text ?? "").count
        
        addTarget(self, action: #selector(closeKeyboard), for: .editingDidEndOnExit)
        
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    @objc func editingDidBegin() { metadata.editingDidBegin() }
    @objc func editingDidEnd() { metadata.editingDidEnd() }
    @objc func editingChanged() { metadata.editingChanged(newTextLen: content.count) }
    
    @objc func closeKeyboard() -> Bool {
        let didResign = resignFirstResponder()
        return didResign
    }

    override func becomeFirstResponder() -> Bool {
        metadata.editingDidBegin()
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        metadata.editingDidEnd()
        return super.resignFirstResponder()
    }
    
    var content: String {get {return text ?? "" }}
    var trackContent: Bool {get { return includeContent != nil}}
    var fieldType: String? {get { return "text" }}
}
