import Foundation
import UIKit

class TrackedUISwitch: UISwitch, TrackedField {
    
    @IBInspectable var id: String?
    @IBInspectable var includeContent: String?
    
    var metadata = Metadata()

    override func awakeFromNib() {
        super.awakeFromNib()
        if value(forKey: "id") == nil {
            fatalError("TrackedField's \"id\" must be provided")
        }
        addTarget(self, action: #selector(editingChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func editingChanged(mySwitch: UISwitch) {metadata.editingChanged()}
    
    var content: String {get {return String(isOn)}}
    var trackContent: Bool {get { return includeContent != nil}}
    var fieldType: String? {get { return "switch" }}
}
