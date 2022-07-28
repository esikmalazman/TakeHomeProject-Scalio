@testable import GithubExplorerApp_TakeHomeProject
import XCTest
import ViewControllerPresentationSpy
final class ResultsViewControllerTests: XCTestCase {
    
    var sut : ResultsViewController!
    var viewModel : ResultsViewModel!
    var mockLoginService : MockLoginService!
    var alertVerifier : AlertVerifier!
    
    override func setUp() {
        super.setUp()
        sut = ResultsViewController(username: "DUMMY")
        
        viewModel = ResultsViewModel()
        sut.viewModel = viewModel
     
        mockLoginService = MockLoginService()
        viewModel.loginService = mockLoginService
        
        alertVerifier = AlertVerifier()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        alertVerifier = nil
        mockLoginService = nil
        viewModel = nil
        sut = nil
        super.tearDown()
    }
    
    //MARK: - Outlets
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.totalUsersLabel, "totalUsersLabel")
        XCTAssertNotNil(sut.resultsTableView, "resultsTableView")
    }
    
    
}


let thingsToTest =
"""
1. Outlets ✅
2. Datasource
3. ViewModel Delegate
"""
