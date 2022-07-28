//
//  SearchResultsViewController.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet private(set) weak var totalUsersLabel: UILabel!
    @IBOutlet private(set) weak var resultsTableView: UITableView!
    
    let username : String
    var viewModel = ResultsViewModel()
    
    init(username : String) {
        self.username = username
        viewModel.requestUsers(username)
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewApperance()
        setupTableView()
        viewModel.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension ResultsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        let data = viewModel.listOfUser[indexPath.row]
        cell.configure(cell:data)
        
        let lastResults = viewModel.listOfUser.count - 1
        if lastResults == indexPath.row {
            viewModel.nextPageUser(username)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

//MARK: - UITableViewDelegate
extension ResultsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

//MARK: - ResultsViewModelDelegate
extension ResultsViewController : ResultsViewModelDelegate {
    func didReceiveUsers() {
        DispatchQueue.main.async { [weak self] in
            self?.totalUsersLabel.text = self?.viewModel.totalNumberOfUsers()
            self?.resultsTableView.reloadData()
        }
    }
    
    func showFailureAlert(_ message: String) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.viewModel.resetListOfUsers()
            self?.viewModel.requestUsers(self?.username ?? "")
        }
        
        let alert = createSimpleAlert(message: message, actions: [cancelAction,retryAction])
        self.present(alert, animated: true)
    }
}

//MARK: - Private
private extension ResultsViewController {
    func setupTableView() {
        resultsTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        
        resultsTableView.backgroundColor = AppTheme.lightGrey
    }
    
    func setupViewApperance() {
        title = "Search Results"
        navigationController?.navigationBar.tintColor = AppTheme.primaryGreen
    }
}
