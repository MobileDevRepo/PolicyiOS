import UIKit

class PoliciesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tblPolicy: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var searchPolicyBar: UISearchBar!
    
    // MARK: - Properties
    private let viewModel = PoliciesViewModel()
    private var expandedRows: Set<Int> = []
    private var isLoadingMore = false
    private var isSearching = false
    private var filteredPolicies: [Policy] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingView.shared.start()
        setupTableView()
        setupSearchBar()
        loadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Timing.policyLoadingDuration) {
            LoadingView.shared.stop()
        }
    }
    
    // MARK: - Setup
    private func setupTableView() {
        tblPolicy.estimatedRowHeight = 150
        tblPolicy.rowHeight = UITableView.automaticDimension
    }
    
    private func setupSearchBar() {
        configureSearchBehavior()
        applySearchBarStyle()
    }
    
    private func configureSearchBehavior() {
        searchPolicyBar.delegate = self
        searchPolicyBar.searchTextField.delegate = self
        searchPolicyBar.placeholder = Constants.Text.searchPlaceholder
        searchPolicyBar.returnKeyType = .done
        searchPolicyBar.showsCancelButton = false
    }
    
    private func applySearchBarStyle() {
        searchPolicyBar.searchTextField.backgroundColor = Theme.pureWhite
        searchPolicyBar.applyCardStyle(cornerRadius: 3, borderColor: Theme.darkGray)
    }
    
    // MARK: - Data
    private func loadData() {
        viewModel.loadInitialPolicies()
        tblPolicy.reloadData()
        updateNoDataLabel()
    }
    
    private func updateNoDataLabel() {
        let isEmpty = isSearching ? filteredPolicies.isEmpty : viewModel.count == 0
        tblPolicy.isHidden = isEmpty
        lblNoData.isHidden = !isEmpty
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension PoliciesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isSearching ? filteredPolicies.count : viewModel.count
        tblPolicy.isHidden = count == 0
        lblNoData.isHidden = count != 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.policyTableCell, for: indexPath) as? tblPolicyCell else {
            return UITableViewCell()
        }
        
        let policy = isSearching ? filteredPolicies[indexPath.row] : viewModel.policy(at: indexPath.row)
        let isExpanded = expandedRows.contains(policy.policyNumber)
        cell.configure(with: policy, expanded: isExpanded)
        
        cell.readMoreTapped = { [weak self] in
            guard let self = self else { return }
            if self.expandedRows.contains(policy.policyNumber) {
                self.expandedRows.remove(policy.policyNumber)
            } else {
                self.expandedRows.insert(policy.policyNumber)
            }
            
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !isSearching else { return }
        
        let lastIndex = viewModel.count - 1
        if indexPath.row == lastIndex && !isLoadingMore {
            isLoadingMore = true
            LoadingView.shared.start()
            
            viewModel.loadNextBatch { [weak self] success in
                guard let self = self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    LoadingView.shared.stop()
                    self.isLoadingMore = false
                    if success {
                        self.tblPolicy.reloadData()
                        self.updateNoDataLabel()
                    }
                }
            }
        }
    }
}

// MARK: - UISearchBarDelegate & UITextFieldDelegate
extension PoliciesViewController: UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if trimmed.isEmpty {
            isSearching = false
            filteredPolicies.removeAll()
        } else {
            isSearching = true
            filteredPolicies = viewModel.policies.filter {
                $0.policyName.lowercased().contains(trimmed) ||
                "\($0.policyNumber)".contains(trimmed)
            }
        }
        
        tblPolicy.reloadData()
        updateNoDataLabel()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchPolicyBar.text = ""
        isSearching = false
        filteredPolicies.removeAll()
        tblPolicy.reloadData()
        updateNoDataLabel()
        searchPolicyBar.resignFirstResponder()
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
