
import Foundation

struct Policy: Codable {
    let policyName: String
    let policyNumber: Int
    let policyStatus: String
    let nextPremiumDue: String
    let startDate: String
    let maturityDate: String
    let sumAssured: Int
    let premiumFrequency: String
    let lastPremiumPaid: String
    let nextPremiumAmount: Int

    enum CodingKeys: String, CodingKey {
        case policyName = "Policy Name"
        case policyNumber = "Policy Number"
        case policyStatus = "Policy Status"
        case nextPremiumDue = "Next Premium Due"
        case startDate = "Start Date"
        case maturityDate = "Maturity Date"
        case sumAssured = "Sum Assured"
        case premiumFrequency = "Premium Frequency"
        case lastPremiumPaid = "Last Premium Paid"
        case nextPremiumAmount = "Next Premium Amount"
    }
}
