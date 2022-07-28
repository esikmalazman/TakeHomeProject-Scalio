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
    
    
    //MARK: - UITableViewDataSource
    func test_tableDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.resultsTableView.dataSource, "dataSource")
        XCTAssertNotNil(sut.resultsTableView.delegate, "delegate")
    }
    
    func test_numberOfRows_withSuccessRequestLogin_shouldBe3() {
        mockLoginService.successMakeRequest = true
        
        viewModel.requestUsers(sut.username)
        
        let numberOfRows = numberOfRowsInSection(sut.resultsTableView)
        XCTAssertEqual(numberOfRows, 3)
    }
    
    func test_numberOfRows_withFailureRequestLogin_shouldBe0() {
        mockLoginService.successMakeRequest = false
        
        viewModel.requestUsers(sut.username)
        
        let numberOfRows = numberOfRowsInSection(sut.resultsTableView)
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_cellForRowAt_shouldSetUserTableViewCellAsTableCell() {
        mockLoginService.successMakeRequest = true
        
        viewModel.requestUsers(sut.username)
        
        let cell = cellForRowAt(sut.resultsTableView, row: 0) as? UserTableViewCell
        XCTAssertNotNil(cell, "Expected UserTableViewCell but was : \(String(describing: cell.self))")
    }
    
    func test_cellForRowAt_withRow0_shouldSetUsernameLabelToAbu() {
        mockLoginService.successMakeRequest = true
        
        viewModel.requestUsers(sut.username)
        
        let cell = cellForRowAt(sut.resultsTableView, row: 0) as? UserTableViewCell
        XCTAssertEqual(cell?.usernameLabel.text, "Abu")
    }
    
    func test_cellForRowAt_withRow3_shouldSetUsernameLabelToFakeCompany() {
        mockLoginService.successMakeRequest = true
        
        viewModel.requestUsers(sut.username)
        
        let cell = cellForRowAt(sut.resultsTableView, row: 2) as? UserTableViewCell
        XCTAssertEqual(cell?.usernameLabel.text, "FakeCompany")
    }
    
    //MARK: - Initializer
    func test_injectUsername_duringLoadViewController_shouldCallRequestUsers1() {
        
        viewModel.requestUsers(sut.username)
        
        XCTAssertEqual(mockLoginService.requestLoginCallCount, 1)
    }
    
    func test_injectUsername_withSuccessRequestLogin_shouldHave0PresentedAlert() {
        setupSuccesRequestLogin()
        
        XCTAssertEqual(alertVerifier.presentedCount, 0)
    }
    
    func test_injectUsername_withFailureRequestLogin_shouldPresentErrorAlert() {
        mockLoginService.apiErrorType = .invalidData
        setupFailureRequestLogin()
        
        verifyPresentedErrorAlert("The data received from server is invalid, please try again")
    }
}

private extension ResultsViewControllerTests {
    func verifyPresentedErrorAlert(_ message : String) {
        alertVerifier.verify(title: "",
                             message: message,
                             animated: true,
                             actions: [.destructive("Cancel"), .default("Retry")],
                             preferredStyle: .alert,
                             presentingViewController: sut)
    }
}

private extension ResultsViewControllerTests {
    func setupSuccesRequestLogin() {
        mockLoginService.successMakeRequest = true
        viewModel.requestUsers(sut.username)
    }
    
    func setupFailureRequestLogin() {
        mockLoginService.successMakeRequest = false
        viewModel.requestUsers(sut.username)
    }
}


let thingsToTest =
"""
1. Outlets ✅
2. Datasource ✅
3. Initializer
4. ViewModel Delegate
"""


