import UIKit

protocol MainTabView: Presentable, AnyObject {
  var onHomeFlowSelect: ((UINavigationController) -> ())? { get set }
  var onProfileFlowSelect: ((UINavigationController) -> ())? { get set }
  
  func start()
}
