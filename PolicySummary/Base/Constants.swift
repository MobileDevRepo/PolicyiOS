
import UIKit

struct Constants {

    struct Text {
        static let dashboard = "Dashboard"
        static let myPolicy = "My Policies"
        static let myClaim = "My Claim"
        static let profile = "Profile"
        static let searchPlaceholder = "Search by Name or Policy no..."
    }

    struct Icons {
        static let homeTab = "ic_tab_home"
        static let policiesTab = "ic_tab_policy"
        static let claimTab = "ic_tab_claim"
        static let ProfileTab = "ic_tab_user"
        static let lapsedIcon = "ic_lapsed"
        static let activeIcon = "ic_active_policy"

    }

    struct Timing {
        static let splashDelay: TimeInterval = 1.5
        static let policyLoadingDuration: TimeInterval = 1.0
        static let animationDuration: TimeInterval = 0.3
    }
    
    struct Storyboard {
        static let main = "Main"
    }
    
    struct StoryboardID {
        static let homeViewController = "HomeViewController"
        static let myPoliciesViewController = "PoliciesViewController"
        static let claimsViewController = "ClaimsViewController"
        static let profileViewController = "ProfileViewController"
    }

    struct CellID {
        static let policyTableCell = "tblPolicyCell"
    }
}
