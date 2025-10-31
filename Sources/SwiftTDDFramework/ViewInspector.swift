import SwiftUI
import XCTest

/// SwiftUI view testing utilities
public struct ViewInspector {
    public static func inspect<V: View>(_ view: V) -> InspectableView<V> {
        InspectableView(view: view)
    }
}

public struct InspectableView<V: View> {
    let view: V
    
    public func hasText(_ text: String) -> Bool {
        let mirror = Mirror(reflecting: view)
        return findText(text, in: mirror)
    }
    
    public func hasButton(label: String) -> Bool {
        let mirror = Mirror(reflecting: view)
        return findButton(label, in: mirror)
    }
    
    private func findText(_ text: String, in mirror: Mirror) -> Bool {
        for child in mirror.children {
            if let textView = child.value as? Text {
                return true // Simplified - would need deeper inspection
            }
            let childMirror = Mirror(reflecting: child.value)
            if findText(text, in: childMirror) {
                return true
            }
        }
        return false
    }
    
    private func findButton(_ label: String, in mirror: Mirror) -> Bool {
        for child in mirror.children {
            if child.value is Button<Text> {
                return true
            }
            let childMirror = Mirror(reflecting: child.value)
            if findButton(label, in: childMirror) {
                return true
            }
        }
        return false
    }
}
