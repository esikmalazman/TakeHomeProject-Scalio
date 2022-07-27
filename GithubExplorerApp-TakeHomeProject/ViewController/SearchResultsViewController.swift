//
//  SearchResultsViewController.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import UIKit

class SearchResultsViewController: UIViewController {

    @IBOutlet private(set) weak var totalUsersLabel: UILabel!
    @IBOutlet private(set) weak var resultsTableView: UITableView!
    
    let username : String
    let viewModel = SearchResultViewModel()
    
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
        title = "Search Results"
        resultsTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        viewModel.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension SearchResultsViewController : UITableViewDataSource {
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
    
}

//MARK: - UITableViewDelegate
extension SearchResultsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SearchResultsViewController : SearchViewModelDelegate {
    func didReceiveUsers() {
        print("Total Users : \(viewModel.listOfUser.count)")
        DispatchQueue.main.async {
            self.totalUsersLabel.text = self.viewModel.totalNumberOfUsers()
            self.resultsTableView.reloadData()
        }
    }
    
    func showFailureAlert(_ message: String) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.viewModel.resetListOfUsers()
        self.viewModel.requestUsers(self.username)
        }
        
        presentSimpleAlert( message: message, actions: [cancelAction,retryAction])
                            
    }
}

#warning("""
1. Show empty state (nice to have)
2. Add pull to refresh (nice to have)
""")
