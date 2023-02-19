
import Foundation
import SwiftUI
import Combine


public struct TrackedPicker<SelectionValue, Content>: TrackedField, View where SelectionValue : Hashable, Content : View {

    
    var selection: Binding<SelectionValue>? = nil
    var titleKey: LocalizedStringKey? = nil
    var _content: Content? = nil
    
    var id: String?
    var trackContent: Bool
    var cc: CrossClassify
    
//    @FocusState private var isFocused: Bool
    @State var metadata = Metadata()
//    @State var metadata = Metadata(trackFocus: true)
    
    public init(_ titleKey: LocalizedStringKey, selection: Binding<SelectionValue>, id: String, trackContent: Bool, cc: CrossClassify, @ViewBuilder content: () -> Content) {
        self.titleKey = titleKey
        self.selection = selection
        self._content = content()
        
        self.id = id
        self.trackContent = trackContent
        self.cc = cc
    }

    public var body: some View {
        
        return Picker<Text, SelectionValue, Content>(
            titleKey!,
            selection: selection!.onChange({_ in metadata.editingChanged()}), content: {_content!}
        )
        .onAppear(perform: {Util.updateField(cc: cc, field: self)})
//        .focused($isFocused)
//        .onChange(of: isFocused) { changed in if changed { metadata.editingDidBegin() } else { metadata.editingDidEnd() }} // TODO: find focus trigger
    }
    var content: String {get {return selection?.wrappedValue as? String ?? ""}} //always nil, TODO: Do convert SelectionValue to string
    var fieldType: String? {get { return "select" }}
}
