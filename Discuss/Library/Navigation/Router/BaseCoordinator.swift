@MainActor
protocol ICoordinator: AnyObject {
  func start()
}

class BaseCoordinator: ICoordinator {
  
  var childCoordinators: [ICoordinator] = []
  
  func start() {
    fatalError("Should be implemented by subclasses")
  }
  
  // add only unique object
  func addDependency(_ coordinator: ICoordinator) {
    guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
    childCoordinators.append(coordinator)
  }
  
  func removeDependency(_ coordinator: ICoordinator?) {
    guard
      childCoordinators.isEmpty == false,
      let coordinator = coordinator
      else { return }
    
    // Clear child-coordinators recursively
    if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
        coordinator.childCoordinators
            .filter({ $0 !== coordinator })
            .forEach({ coordinator.removeDependency($0) })
    }
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
        childCoordinators.remove(at: index)
        break
    }
  }
}
