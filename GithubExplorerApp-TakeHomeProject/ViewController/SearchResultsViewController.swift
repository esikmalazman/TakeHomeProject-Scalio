//
//  SearchResultsViewController.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import UIKit

class SearchResultsViewController: UIViewController {

    @IBOutlet private(set) weak var totalUsersLabel: UILabel!
    @IBOutlet private(set) weak var resultsCollectionView: UICollectionView!
    
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
        resultsCollectionView.register(UserCollectionViewCell.nib(), forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        viewModel.delegate = self
    }
}

extension SearchResultsViewController : UICollectionViewDelegate {}

extension SearchResultsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = view.bounds.width / 2.2
        let height : CGFloat = 180
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

extension SearchResultsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listOfUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.identifier, for: indexPath) as! UserCollectionViewCell

        cell.userImageView.downloadImage(fromURLString: viewModel.userAvatarUrl(at: indexPath.row) ?? "")
        cell.loginNameLabel.text = "Rock"
        cell.userTypeLabel.text = "User"
        
        let lastUsers = viewModel.listOfUser.count - 1
        
        if lastUsers == indexPath.row {
            viewModel.nextPageUser(username)
        }
        
        return cell
    }
}

extension SearchResultsViewController : SearchViewModelDelegate {
    func didReceiveUsers() {
        print("Total Users : \(viewModel.listOfUser.count)")
        DispatchQueue.main.async {
            self.resultsCollectionView.reloadData()
        }
    }
}



#warning("""
1. Assign outlets and configure basic collection view ✅
2. Create custom collection view cell and layout size of cell ✅
3. Refactor to MVVM and Implement pagination ✅
4. Add alert show if emtpy login (nice to have)
5. Show empty state (nice to have)
""")
