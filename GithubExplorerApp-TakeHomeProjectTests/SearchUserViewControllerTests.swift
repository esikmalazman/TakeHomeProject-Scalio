@testable import GithubExplorerApp_TakeHomeProject
import XCTest
import ViewControllerPresentationSpy

final class SearchUserViewControllerTests: XCTestCase {
    
    var sut : SearchUserViewController!
    var viewModel: SearchViewModel!
    var alertVerifier : AlertVerifier!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: .main)
        sut = sb.instantiateViewController(identifier: "\(SearchUserViewController.self)")
        viewModel = SearchViewModel()
        sut.viewModel = viewModel
        alertVerifier = AlertVerifier()
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
        alertVerifier = nil
        sut = nil
        super.tearDown()
    }
    
    //MARK: - Outlets Test
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.cancelButton, "cancelButton")
        XCTAssertNotNil(sut.loginTextField, "loginTextField")
        XCTAssertNotNil(sut.submitButton, "submitButton")
        XCTAssertNotNil(sut.introImageView, "introImageView")
    }
    
    //MARK: - Actions Test
    
    func test_tappingCancel_shouldDeactivateLoginTextField() {
        putFocusOn(sut.loginTextField)
        XCTAssertTrue(sut.loginTextField.isFirstResponder, "precondition - loginTextfield active")
        
        tap(sut.cancelButton)
        
        XCTAssertFalse(sut.loginTextField.isFirstResponder)
    }
    
    func test_tappingCancel_shouldClearText() {
        putFocusOn(sut.loginTextField)
        sut.loginTextField.text = "DUMMY"
        
        tap(sut.cancelButton)
        
        XCTAssertEqual(sut.loginTextField.text?.isEmpty, true)
    }
    
    func test_tappingSubmit_withEmptyText_shouldDisplayEmptyAlert() {
        sut.loginTextField.text = ""
        
        tap(sut.submitButton)
        
        verifyPresentedAlert(message: "Please enter words in Login")
    }
    
    func test_tappingSubmit_withSpaceWithoutEarlyCharactersInBeginning_shouldDisplayEmptyAlert() {
        sut.loginTextField.text = " "
        
        tap(sut.submitButton)
        
        verifyPresentedAlert(message: "Please enter words in Login")
    }
    
    func test_tappingSubmit_withEmptyText_andTapOkInEmptyAlert_shouldActiveLoginTextfield() throws {
        putViewInWindow(sut)
        sut.loginTextField.text = ""
        XCTAssertFalse(sut.loginTextField.isFirstResponder, "precondition - loginTextfield not active")
        
        tap(sut.submitButton)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertTrue(sut.loginTextField.isFirstResponder)
    }
    
    func test_tappingSubmit_withSpaceWithoutEarlyCharactersInBeginning_andTapOkInEmptyAler_shouldActiveLoginTextfield() throws {
        putViewInWindow(sut)
        sut.loginTextField.text = " "
        XCTAssertFalse(sut.loginTextField.isFirstResponder, "precondition - loginTextfield not active")
        
        tap(sut.submitButton)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertTrue(sut.loginTextField.isFirstResponder)
    }
    
    func test_tappingSubmit_withDummyText_shouldPushToResultsVC() {
        /// Embed SUT into NavigationController
        let navController = UINavigationController(rootViewController: sut)
        XCTAssertNotNil(sut.navigationController, "precondition - SUT have NavigationController")
        sut.loginTextField.text = "DUMMY"
        
        tap(sut.submitButton)
        executeRunLoop()
        
        let pushedVC = navController.viewControllers.last
        XCTAssertTrue(pushedVC is ResultsViewController, "Expected ResultsVC but was \(String(describing: pushedVC.self))")
        XCTAssertEqual(navController.viewControllers.count, 2, "VC in Navigation Controller  Stack expected to have 2 but was :\(navController.viewControllers.count)")
    }
    
    func test_tappingSubmit_withDummyText_shouldPassDummyTextToUsernameInResultsVC() {
        let navController = UINavigationController(rootViewController: sut)
        XCTAssertNotNil(sut.navigationController, "precondition - SUT have NavigationController")
        sut.loginTextField.text = "DUMMY"
        
        tap(sut.submitButton)
        executeRunLoop()
        
        guard let resultVC = navController.viewControllers.last as? ResultsViewController else {
            XCTFail("Expected ResultsVC but was \(String(describing: navController.viewControllers.last))")
            return
        }
        
        XCTAssertEqual(resultVC.username, "DUMMY")
    }
    
    //MARK: - UITextFieldDelegate
    
    func test_textFieldDelegate_shouldBeConnected() {
        XCTAssertNotNil(sut.loginTextField.delegate)
    }

    func test_textFieldShouldReturn_withEmptyText_shouldDisplayAlert() {
        sut.loginTextField.text = ""

        let isTextfieldReturn = sut.loginTextField.delegate?.textFieldShouldReturn?(sut.loginTextField)

        verifyPresentedAlert(message: "Please enter words in Login")
        XCTAssertEqual(isTextfieldReturn, true, "Expected to Return but was \(String(describing: isTextfieldReturn))")
    }
    
    func test_textFieldShouldReturn_withSpaceWithoutEarlyCharactersInBeginning_shouldDisplayAlert() {
        sut.loginTextField.text = " "

        let isTextfieldReturn = shouldReturn(sut.loginTextField)

        verifyPresentedAlert(message: "Please enter words in Login")
        XCTAssertEqual(isTextfieldReturn, true, "Expected to Return but was \(String(describing: isTextfieldReturn))")
    }
    
    func test_textFieldShouldReturn_withEmptyText_andTapOkInEmptyAlert_shouldActiveLoginTextfield() throws {
        putViewInWindow(sut)
        sut.loginTextField.text = ""
        XCTAssertFalse(sut.loginTextField.isFirstResponder, "precondition - loginTextfield not active")
        
        shouldReturn(sut.loginTextField)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertTrue(sut.loginTextField.isFirstResponder)
    }
    
    func test_textFieldShouldReturn_withSpaceWithoutEarlyCharactersInBeginning_andTapOkInEmptyAlert_shouldActiveLoginTextfield() throws {
        putViewInWindow(sut)
        sut.loginTextField.text = ""
        XCTAssertFalse(sut.loginTextField.isFirstResponder, "precondition - loginTextfield not active")
        
        shouldReturn(sut.loginTextField)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertTrue(sut.loginTextField.isFirstResponder)
    }
    
    func test_textFieldShouldReturn_withDummyText_shouldPushToResultVC() {
        let navController = UINavigationController(rootViewController: sut)
        XCTAssertNotNil(sut.navigationController, "precondition - SUT have NavigationController")
        sut.loginTextField.text = "DUMMY"
        
        shouldReturn(sut.loginTextField)
        executeRunLoop()
        
        let pushedVC = navController.viewControllers.last
        XCTAssertTrue(pushedVC is ResultsViewController, "Expected ResultsVC but was \(String(describing: pushedVC.self))")
        XCTAssertEqual(navController.viewControllers.count, 2, "VC in Navigation Controller  Stack expected to have 2 but was :\(navController.viewControllers.count)")
    }
    
    func test_textFieldShouldReturn_withDummyText_shouldPassDummyTextToUsernameInResultsVC() {
        let navController = UINavigationController(rootViewController: sut)
        XCTAssertNotNil(sut.navigationController, "precondition - SUT have NavigationController")
        sut.loginTextField.text = "DUMMY"
        
        shouldReturn(sut.loginTextField)
        executeRunLoop()
        
        guard let pushedVC = navController.viewControllers.last as? ResultsViewController else {
            XCTFail("Expected ResultsVC but was \(String(describing: navController.viewControllers.last))")
            return
        }
        
        XCTAssertEqual(pushedVC.username, "DUMMY")
    }
    
    //MARK: - SearchUserViewModelDelegate
    
    func test_viewModelDelegate_shouldBeConnected() {
        XCTAssertNotNil(sut.viewModel.delegate)
    }
    
    func test_showEmptyAlert_withEmptyText_shouldDisplayEmptyAlert() {
        sut.loginTextField.text = ""
        
        showEmptyAlert(viewModel)
        
        verifyPresentedAlert(message: "Please enter words in Login")
        XCTAssertEqual(alertVerifier.presentedCount, 1, "Expected alertPresentedCount is 1 but was \(alertVerifier.presentedCount)")
    }
    
    func test_showEmptyAlert_withEmptyText_andTapOkInEmptyAlert_shouldActiveLoginTextfield() throws {
        putViewInWindow(sut)
        sut.loginTextField.text = ""
        XCTAssertFalse(sut.loginTextField.isFirstResponder, "precondition - loginTextfield not active")
        
        showEmptyAlert(viewModel)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertTrue(sut.loginTextField.isFirstResponder)
    }
    
    func test_beginSearchUsername_withDummyText_shouldPushToResultVC() {
        let navController = UINavigationController(rootViewController: sut)
        XCTAssertNotNil(sut.navigationController, "precondition - SUT have NavigationController")
        
        beginSearchUsername(viewModel, username: "DUMMY")
        executeRunLoop()
        
        let pushedVC = navController.viewControllers.last
        XCTAssertTrue(pushedVC is ResultsViewController,"Expected ResultsVC but was \(String(describing: pushedVC.self))")
        XCTAssertEqual(navController.viewControllers.count, 2, "VC in Navigation Controller  Stack expected to have 2 but was :\(navController.viewControllers.count)")
    }

    func test_beginSearchUsername_withDummyTest_shouldPassDummyTextToUsernameInResultVC() {
        let navController = UINavigationController(rootViewController: sut)
        XCTAssertNotNil(sut.navigationController, "precondition - SUT have NavigationController")
        
        beginSearchUsername(viewModel, username: "DUMMY")
        executeRunLoop()
        
        guard let pushedVC = navController.viewControllers.last as? ResultsViewController else {
            XCTFail("Expected ResultsVC but was \(String(describing: navController.viewControllers.last))")
            return
        }
        XCTAssertEqual(pushedVC.username, "DUMMY")
    }
}

//MARK: - Utilities Helper
private extension SearchUserViewControllerTests {
    func putFocusOn(_ textfield : UITextField) {
        putViewInWindow(sut)
        textfield.becomeFirstResponder()
    }
    
    func verifyPresentedAlert(message : String, file : StaticString = #file, line : UInt = #line) {
        alertVerifier.verify(title: "",
                             message: message,
                             animated: true, actions: [.default("OK")],
                             preferredStyle: .alert,
                             presentingViewController: sut,
                             file: file,
                             line: line)
    }
}
//MARK: - ViewModel Delegate Helper
private extension SearchUserViewControllerTests {
    func showEmptyAlert(_ viewModel : SearchViewModel) {
        viewModel.delegate?.showEmptyAlert(viewModel)
    }
    
    func beginSearchUsername(_ viewModel : SearchViewModel, username : String) {
        viewModel.delegate?.beginSearchUsername(viewModel, username: username)
    }
}
