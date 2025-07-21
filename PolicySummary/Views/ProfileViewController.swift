
import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var vwPrivacyPolicy: UIView!
    @IBOutlet weak var vwTerms: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        vwPrivacyPolicy.applyCardStyle(cornerRadius: 5)
        vwTerms.applyCardStyle(cornerRadius: 5)
    }
}
