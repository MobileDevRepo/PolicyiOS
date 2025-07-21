
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var vwTotalPolicies: UIView!
    @IBOutlet weak var vwClaimedPolicies: UIView!
    @IBOutlet weak var lblTotalPolicyCount: UILabel!

    private let viewModel = PoliciesViewModel()
    var tapGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData()
    }

    func setupUI() {
        vwTotalPolicies.applyCardStyle(cornerRadius: 10)
        vwClaimedPolicies.applyCardStyle(cornerRadius: 10)

        // Assign to external property
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(vwTotalPoliciesTapped))
        vwTotalPolicies.isUserInteractionEnabled = true
        if let tapGesture = tapGesture {
            vwTotalPolicies.addGestureRecognizer(tapGesture)
        }
    }

    func setupData() {
        viewModel.loadInitialPolicies()
        lblTotalPolicyCount.text = "\(viewModel.totalCount)"
    }

    @objc private func vwTotalPoliciesTapped() {
        tabBarController?.selectedIndex = 1
    }
}
