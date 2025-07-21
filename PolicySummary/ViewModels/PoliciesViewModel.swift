
import Foundation

class PoliciesViewModel {
    private(set) var policies: [Policy] = []
    private var allPolicies: [Policy] = []

    private let batchSize = 10
    private var currentIndex = 0

    func loadInitialPolicies() {
        guard let url = Bundle.main.url(forResource: "policies", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Policy].self, from: data)
            self.allPolicies = decoded
            self.policies = Array(decoded.prefix(batchSize))
            self.currentIndex = policies.count
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    func loadNextBatch(completion: @escaping (Bool) -> Void) {
        guard currentIndex < allPolicies.count else {
            completion(false)
            return
        }

        let nextIndex = min(currentIndex + batchSize, allPolicies.count)
        let nextBatch = allPolicies[currentIndex..<nextIndex]
        policies.append(contentsOf: nextBatch)
        currentIndex = nextIndex
        completion(true)
    }

    func policy(at index: Int) -> Policy {
        return policies[index]
    }

    var count: Int {
        return policies.count
    }
    
    var totalCount: Int {
        return allPolicies.count
    }
}
