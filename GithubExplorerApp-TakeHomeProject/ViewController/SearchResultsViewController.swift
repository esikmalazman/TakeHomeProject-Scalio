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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Results"
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
    }
}

extension SearchResultsViewController : UICollectionViewDelegate {}

extension SearchResultsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        <#code#>
//    }
}

extension SearchResultsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        #warning("make it dynamic")
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}



#warning("""
1. Assign outlets and configure basic collection view ✅
2. Create custom collection view cell and layout size of cell
3. Refactor to MVVM and Implement pagination
4. Add alert show if emtpy login (nice to have)
5. Show empty state (nice to have)
""")
