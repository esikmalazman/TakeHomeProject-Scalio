@testable import GithubExplorerApp_TakeHomeProject
import XCTest

final class SearchUserViewControllerTests: XCTestCase {
    
    var sut : SearchUserViewController!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: .main)
        sut = sb.instantiateViewController(identifier: "\(SearchUserViewController.self)")
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
}
