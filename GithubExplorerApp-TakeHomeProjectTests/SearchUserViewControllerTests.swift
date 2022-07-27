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
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.cancelButton, "cancelButton")
        XCTAssertNotNil(sut.loginTextField, "loginTextField")
        XCTAssertNotNil(sut.submitButton, "submitButton")
        XCTAssertNotNil(sut.introImageView, "introImageView")
    }

}

let test_to_covered =
"""
1. Actions
2. Textfield Delegate
3. ViewModelDelegate
"""
