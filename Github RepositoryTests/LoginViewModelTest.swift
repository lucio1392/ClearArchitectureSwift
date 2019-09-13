//
//  LoginViewModelTest.swift
//  Github RepositoryTests
//
//  Created by Macbook on 9/12/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxBlocking
import RxTest

@testable import PhotoSDK

final class LoginNavigatorMockup: LoginNavigation {
    
    func toLoginURL() {}
    
    func toLogin() {}
    
}

class LoginViewModelTest: XCTestCase {

    var loginViewModel: LoginViewModel!
    var authenticationUsecaseMockup: AuthenticationUseCaseMockup!
    var loginNavigatorMockup: LoginNavigatorMockup!
    private var authenCode: PublishSubject<String>!
    private var loginViewModelInput: LoginViewModel.Input!
    private var loginViewModelOutput: LoginViewModel.Output!
    private var inputTapLogin: PublishSubject<Void>!
    private var disposedBag: DisposeBag!
    private var testSchedule: TestScheduler!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testSchedule = TestScheduler(initialClock: 0)
        disposedBag = DisposeBag()
        authenticationUsecaseMockup = AuthenticationUseCaseMockup()
        loginNavigatorMockup = LoginNavigatorMockup()
        authenCode = PublishSubject<String>()
        
        loginViewModel = LoginViewModel(authenticationUsecaseMockup,
                                        loginNavigator: loginNavigatorMockup,
                                        authenCode: authenCode)
        
        inputTapLogin = PublishSubject<Void>()
        loginViewModelInput = LoginViewModel.Input(onLogin: inputTapLogin.asDriver(onErrorJustReturn: ()))
        loginViewModelOutput = loginViewModel.transform(input: loginViewModelInput)
    }
    
    
    func test_login_output() throws {
        
        let authenCodeObsever = testSchedule.createObserver(AccessToken.self)
        
        loginViewModelOutput
            .authenResult
            .bind(to: authenCodeObsever)
            .disposed(by: disposedBag)
        
        testSchedule
            .createColdObservable([.next(10, "Code")])
            .bind(to: authenCode)
            .disposed(by: disposedBag)
        
        testSchedule.start()

        guard let requestAccessToken = try authenticationUsecaseMockup.accessToken(code: "Code").toBlocking().first() else { return }

        XCTAssertEqual(authenCodeObsever.events, [.next(10, requestAccessToken)])
    }
    
    func test_login_input() throws {
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
