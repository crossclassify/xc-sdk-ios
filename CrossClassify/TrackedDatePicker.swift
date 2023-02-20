
import Foundation
import SwiftUI
import Combine


public struct TrackedDatePicker: TrackedField, View {

    var selection: Binding<Date>? = nil
    var titleKey: LocalizedStringKey? = nil
    var displayedComponents: DatePicker<Text>.Components
    
    var id: String?
    var trackContent: Bool
    var cc: CrossClassify
    
//    @FocusState private var isFocused: Bool
    @State var metadata = Metadata()
//    @State var metadata = Metadata(trackFocus: true)
    
    
    public init(_ titleKey: LocalizedStringKey, selection: Binding<Date>, displayedComponents: DatePicker<Text>.Components , id: String, trackContent: Bool, cc: CrossClassify) {
        self.titleKey = titleKey
        self.selection = selection
        self.displayedComponents = displayedComponents
        
        self.trackContent = trackContent
        self.id = id
        self.cc = cc
    }

    public var body: some View {
        
        return DatePicker<Text>(
            titleKey!,
            selection: selection!.onChange({_ in metadata.editingChanged()}), displayedComponents: displayedComponents
        )
        .onAppear(perform: {Util.updateField(cc: cc, field: self)})
//            .focused($isFocused).onChange(of: isFocused) { changed in if changed { editingDidBegin() } else { editingDidEnd() }} //TODO: find focus trigger
    }
    
    var content: String {get {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd HH:mm:ss"
        return dateFormatter.string(from: selection!.wrappedValue) ?? ""}}
    var fieldType: String? {get { return "date" }}
}
