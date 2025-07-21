
import UIKit

class tblPolicyCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var viewMain: UIView!

    @IBOutlet weak var lblPolicyName: UILabel!
    @IBOutlet weak var lblPolicyNumber: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblValidTill: UILabel!
    @IBOutlet weak var lblNextPremiumDue: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblMaturityDate: UILabel!
    @IBOutlet weak var lblSumAssured: UILabel!
    @IBOutlet weak var lblLastPremium: UILabel!
    @IBOutlet weak var lblNextAmount: UILabel!
    @IBOutlet weak var vwReadMore: UIView!
    @IBOutlet weak var vwReadMoreHconst: NSLayoutConstraint!

    var readMoreTapped: (() -> Void)?

    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vwReadMoreHconst.constant = 0
        vwReadMore.isHidden = true
        self.viewMain?.addShadowView(width: 0.25, height: 0.25, Opacidade: 0.25, maskToBounds: false, radius: 4)
        self.viewMain?.layer.cornerRadius = 8
        self.viewMain?.layer.borderColor = Theme.lightGray.cgColor
        self.viewMain?.layer.borderWidth = 0.1
        btnReadMore.addTarget(self, action: #selector(toggleExpansion), for: .touchUpInside)
    }

    func configure(with policy: Policy, expanded: Bool) {
        lblPolicyName.text = policy.policyName
        lblPolicyNumber.text = "Policy No: \(policy.policyNumber)"
        lblStatus.text = policy.policyStatus
        lblValidTill.text = "\(policy.nextPremiumDue)"
        lblNextPremiumDue.text = "Next Premium Due: \(policy.nextPremiumDue)"
        lblStartDate.text = "Start Date: \(policy.startDate)"
        lblMaturityDate.text = "Maturity Date: \(policy.maturityDate)"
        lblSumAssured.text = "₹\(policy.sumAssured)"
        lblLastPremium.text = "Last Premium Paid: \(policy.lastPremiumPaid)"
        lblNextAmount.text = "₹\(policy.nextPremiumAmount)"

        let isLapsed = lblStatus.text == "Lapsed"
        lblStatus.textColor = isLapsed ? Theme.customRed : Theme.customGreen
        imgStatus.image = UIImage(named: isLapsed ? Constants.Icons.lapsedIcon : Constants.Icons.activeIcon)

        vwReadMore.isHidden = !expanded
        vwReadMoreHconst.constant = expanded ? 110 : 0

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        btnReadMore.imageView?.transform = expanded ? CGAffineTransform(rotationAngle: .pi) : .identity
        CATransaction.commit()

        layoutIfNeeded()
    }

    @objc private func toggleExpansion() {
        UIView.animate(withDuration: Constants.Timing.animationDuration) {
            let isExpanded = self.vwReadMore.isHidden
            let angle: CGFloat = isExpanded ? .pi : 0
            self.btnReadMore.imageView?.transform = CGAffineTransform(rotationAngle: angle)
        }
        readMoreTapped?()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        vwReadMore.isHidden = true
        vwReadMoreHconst.constant = 0

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        btnReadMore.imageView?.transform = .identity
        CATransaction.commit()
    }
}
