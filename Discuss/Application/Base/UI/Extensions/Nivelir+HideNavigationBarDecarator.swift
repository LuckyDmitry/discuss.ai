#if canImport(UIKit)
import UIKit
import Nivelir

/// Wraps `Screen` with a container of type `UIViewController` in the navigation controller as root.
public struct WithHiddenStackDecorator<
    Container: UIViewController,
    Output: UINavigationController
>: ScreenDecorator {

    public var payload: Any? {
        nil
    }

    public var description: String {
        "StackContainerDecorator"
    }

    public init() { }

    public func build<Wrapped: Screen>(
        screen: Wrapped,
        navigator: ScreenNavigator
    ) -> Output where Wrapped.Container == Container {
        let output = Output(rootViewController: screen.build(navigator: navigator))
        output.setNavigationBarHidden(true, animated: false)
        return output
    }
}

extension Screen where Container: UIViewController {

    /// Wraps the screen container in a navigation controller with the specified class type.
    /// - Parameter type: `UINavigationController` class type.
    /// - Returns: New `Screen` with new container of class type `UINavigationController`.
    public func withHiddenNavigationBarStackContainer<Output: UINavigationController>(
        of type: Output.Type
    ) -> AnyScreen<Output> {
        decorated(by: WithHiddenStackDecorator<Container, Output>())
    }

    /// Wraps the screen container in a navigation controller.
    /// - Returns: New `Screen` with new container of class `UINavigationController`.
    public func withHiddenNavigationBarStackContainer() -> AnyStackScreen {
        withHiddenNavigationBarStackContainer(of: UINavigationController.self)
    }
}
#endif
