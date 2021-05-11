
import Foundation
import CareKit
import CareKitStore
import UIKit

/// In order to save values, UIKit classes should conform to this protocol and become a delegate.
protocol MoodDelegate: AnyObject {

    /// Save the value to CareKit store.
    func save(_ value: String)
    
    /// Dismisses the screen.
    func dismiss()
}

/// Simple Class for logging values.
class MoodValue: ObservableObject {
    @Published var value = ""
    var delegate: MoodDelegate?

    /// Save the value to CareKit store.
    func save() {
        delegate?.save(value)
    }

    /// Cancels the selection and ignores the value.
    func cancel() {
        delegate?.dismiss()
    }
}
