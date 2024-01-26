
import Foundation
import SwiftUI
import EventKitUI

//Logic for add Events on the Apple Calendar
struct EventEditViewController: UIViewControllerRepresentable{
    @Environment(\.dismiss) var dismiss
    @Binding var event: EKEvent?
    let eventStore: EKEventStore
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        
        controller.eventStore = eventStore
        controller.event = event
        controller.editViewDelegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {return Coordinator(self)}
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        var parent: EventEditViewController
        init(_ controller: EventEditViewController){
            self.parent = controller
        }
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.dismiss()
        }
    }
}
