
import Foundation
import SwiftUI
import Combine


public struct TrackedToggle: TrackedField, View {

    var isOn: Binding<Bool>? = nil
    var titleKey: LocalizedStringKey? = nil
    
    var id: String?
    var trackContent: Bool
    var cc: CrossClassify
    
    @State var _isEditing: Bool = false
    
//    @FocusState private var isFocused: Bool
    @State var metadata = Metadata()
    
    
    public init(_ titleKey: LocalizedStringKey, isOn: Binding<Bool>, id: String, trackContent: Bool, cc: CrossClassify) {
        self.titleKey = titleKey
        self.isOn = isOn
        
        self.trackContent = trackContent
        self.id = id
        self.cc = cc
    }

    public var body: some View {
        
        return Toggle<Text>(
            titleKey!,
            isOn: isOn!.onChange({_ in metadata.editingChanged()})
        )
        .onAppear(perform: {Util.updateField(cc: cc, field: self)})
    }

    var content: String {get {return String(isOn!.wrappedValue)}}
    var fieldType: String? {get { return "switch" }}
    
    var timeSpentEditing: TimeInterval? = nil
}
