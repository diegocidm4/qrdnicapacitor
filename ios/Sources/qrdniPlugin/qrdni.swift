import Foundation

@objc public class qrdni: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
