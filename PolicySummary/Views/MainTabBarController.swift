
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabs()
        setupTabBarAppearance()
        updateNavigationBarTitle(for: selectedIndex)
    }

    private func setupTabs() {
        let storyboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)

        let homeVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.homeViewController)
        homeVC.tabBarItem = UITabBarItem(
            title: Constants.Text.dashboard,
            image: UIImage(named: Constants.Icons.homeTab)?.withRenderingMode(.alwaysTemplate),
            tag: 0
        )

        let policiesVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.myPoliciesViewController)
        policiesVC.tabBarItem = UITabBarItem(
            title: Constants.Text.myPolicy,
            image: UIImage(named: Constants.Icons.policiesTab)?.withRenderingMode(.alwaysTemplate),
            tag: 1
        )

        let claimsVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.claimsViewController)
        claimsVC.tabBarItem = UITabBarItem(
            title: Constants.Text.myClaim,
            image: UIImage(named: Constants.Icons.claimTab)?.withRenderingMode(.alwaysTemplate),
            tag: 2
        )

        let profileVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.profileViewController)
        profileVC.tabBarItem = UITabBarItem(
            title: Constants.Text.profile,
            image: UIImage(named: Constants.Icons.ProfileTab)?.withRenderingMode(.alwaysTemplate),
            tag: 3
        )
        viewControllers = [homeVC, policiesVC, claimsVC, profileVC]
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.darkBlue

        tabBar.tintColor = Theme.pureWhite
        tabBar.unselectedItemTintColor = Theme.pureWhite.withAlphaComponent(0.6)
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    private func updateNavigationBarTitle(for index: Int) {
        let titles = [Constants.Text.dashboard, Constants.Text.myPolicy, Constants.Text.myClaim, Constants.Text.profile]
        self.navigationItem.title = titles[safe: index] ?? ""
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigationBarTitle(for: selectedIndex)
    }
}

