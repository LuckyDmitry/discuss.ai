import UIKit

final class HomeTabBarItem: UITabBarItem {

    init(title: String, image: UIImage, tag: Int) {
        super.init()

        self.title = title
        self.image = image
        self.tag = tag

//        titlePositionAdjustment = UIOffset(
//            horizontal: 0,
//            vertical: 5
//        )

        imageInsets = UIEdgeInsets(
            top: 5,
            left: 0,
            bottom: 1,
            right: 0
        )

//        badgeColor = Colors.important

        setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: 12, weight: .medium),
                .kern: NSNumber(value: -0.24)
            ],
            for: .normal
        )
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITabBarItem {
  
  static let home = HomeTabBarItem(
    title: "Home",
    image: Asset.TabBar.main.image,
    tag: 1
  )
  
  static let chat = HomeTabBarItem(
    title: "Cards",
    image: Asset.TabBar.chat.image,
    tag: 1
  )
  
  static let profile = HomeTabBarItem(
    title: "Profile",
    image: Asset.TabBar.profile.image,
    tag: 2
  )
}
