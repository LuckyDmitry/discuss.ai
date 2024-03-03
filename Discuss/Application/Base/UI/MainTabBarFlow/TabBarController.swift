import UIKit

final class MainTabController: UITabBarController, UITabBarControllerDelegate, MainTabView {
  
  var onHomeFlowSelect: ((UINavigationController) -> ())?
  var onProfileFlowSelect: ((UINavigationController) -> ())?
  
  private var flows: [((UINavigationController) -> Void)?] {
    [
      onHomeFlowSelect,
      onProfileFlowSelect
    ]
  }
  
  private let images = [
    Asset.TabBar.main.image,
    Asset.TabBar.profile.image
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = images
      .map { image in
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(
          title: "",
          image: image.withTintColor(Colors.TextAndIcons.white),
          selectedImage: image.withTintColor(Colors.TextAndIcons.accent)
        )
        return navigationController
      }
    
    delegate = self
  }
  
  func start() {
    guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
    flows.first?.map { $0(controller) }
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
    flows[selectedIndex]?(controller)
  }
}
