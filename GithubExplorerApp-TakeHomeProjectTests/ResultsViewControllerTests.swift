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
    
    func test_injectUsername_withFailureRequestLogin_andTappingRetry_shouldCallRequestUsers2() throws {
        setupFailureRequestLogin()
        
        try alertVerifier.executeAction(forButton: "Retry")
        
        XCTAssertEqual(mockLoginService.requestLoginCallCount, 2)
    }
    
    func test_injectUsername_withFailureRequestLogin_andTappingRetry_shouldEmptyListOfUsers() throws {
        setupFailureRequestLogin()
        
        try alertVerifier.executeAction(forButton: "Retry")
        
        XCTAssertEqual(viewModel.listOfUser.isEmpty, true)
    }
    
    func test_injectUsername_withFailureRequestLogin_andTappingRetry_shouldResetPageTo1() throws {
        setupFailureRequestLogin()
        
        try alertVerifier.executeAction(forButton: "Retry")
        
        XCTAssertEqual(viewModel.page, 1)
    }
    
    func test_injectUsername_withFailureRequestLogin_andTappingCancel_shouldPopVC() throws {
        let mockNavControler = MockNavigationControllers(rootViewController: sut)
        setupFailureRequestLogin()
        
        try alertVerifier.executeAction(forButton: "Cancel")
        executeRunLoop()
        
        XCTAssertEqual(mockNavControler.isBeingPop, true)
    }
    
    //MARK: - ResultsViewModelDelegate
    
    func test_viewModelDelegate_shouldBeConnected() {
        XCTAssertNotNil(sut.viewModel.delegate)
    }
    
    func test_didReceiveUsers_withSuccessRequestLogin_shouldSetTotalUsersLabelTo3() {
        setupSuccesRequestLogin()
        let receiveUserExpectation = expectation(description: "users received")
        
        didReceiveUsers(sut.viewModel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            receiveUserExpectation.fulfill()
        }

        wait(for: [receiveUserExpectation], timeout: 0.1)
        XCTAssertEqual(sut.totalUsersLabel.text, "3 Results found")
    }
    
    func test_didReceiveUsers_withFailureRequestLogin_shouldSetTotalUsersLabelTo3() {
        setupFailureRequestLogin()
        let receiveUserExpectation = expectation(description: "users received")
        
        sut.didReceiveUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            receiveUserExpectation.fulfill()
        }

        wait(for: [receiveUserExpectation], timeout: 0.1)
        XCTAssertEqual(sut.totalUsersLabel.text, "0 Results found")
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

extension ResultsViewControllerTests {
    func didReceiveUsers(_ viewModel : ResultsViewModel) {
        viewModel.delegate?.didReceiveUsers()
    }
    
    func showFailureAlert(_ viewModel  : ResultsViewModel, message :String) {
        viewModel.delegate?.showFailureAlert(message)
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
3. Initializer ✅
4. ViewModel Delegate
"""


