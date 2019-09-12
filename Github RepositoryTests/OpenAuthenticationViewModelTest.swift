//
//  Github_RepositoryTests.swift
//  Github RepositoryTests
//
//  Created by Macbook on 9/11/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxBlocking
import RxTest

@testable import Github_Repository

final class AuthenticationUseCaseMockup: AuthenticationUseCase {
    
    var oauthRedirect: Observable<URLRequest> {
        return .just(URLRequest(url: URL(string: "https://google.com")!))
    }
    
    func accessToken(code: String) -> Observable<AccessToken> {
        let accessToken = AccessToken(accessToken: "accessToken", tokenType: "tokenType", scope: "scope", createdAt: 100000)
        return .just(accessToken)
    }
    
    func openAuthen(param: String, resultUrl: URL) -> Observable<String> {
        return .just("code")
    }
    
}

final class AuthenticationNavigatorMockup: OpenAuthenticationNavigation {
    
    func toOpenAuthentication() {
        
    }
    
    func toLogin() {
        
    }
    
    
}

class OpenAuthenticationViewModelTest: XCTestCase {
    
    var openAuthenticationViewModel: OpenAuthenticationViewModel!
    var authenticationUsecaseMock: AuthenticationUseCaseMockup!
    var authenticationNavigationMock: AuthenticationNavigatorMockup!
    var authenCode: PublishSubject<String>!
    var viewModelOutput: OpenAuthenticationViewModel.Output!
    var viewModelInput: OpenAuthenticationViewModel.Input!
    let disposeBag = DisposeBag()
    let url = URL(string: "https://www.google.com/")!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        authenticationUsecaseMock = AuthenticationUseCaseMockup()
        authenticationNavigationMock = AuthenticationNavigatorMockup()
        authenCode = PublishSubject<String>()
        openAuthenticationViewModel = OpenAuthenticationViewModel(authenticationUsecaseMock,
                                                                  navigator: authenticationNavigationMock,
                                                                  authenCode: authenCode)
        
        viewModelInput = OpenAuthenticationViewModel.Input(authenUrl: .just(url))
        
        viewModelOutput = openAuthenticationViewModel.transform(input: viewModelInput)
        
    }
    
    func test_open_authentication_output() throws {
        
        let outputExpresstion = try viewModelOutput.oauthRedirectURLRequest.toBlocking().first()
        
        XCTAssertEqual(outputExpresstion?.url?.absoluteString, "https://google.com")
    }
    
    func test_open_authentication_input() throws {
        let inputAuthenUrl = try viewModelInput.authenUrl.toBlocking().first()
        
        XCTAssertEqual(inputAuthenUrl?.absoluteString, "https://www.google.com/")
        
        let authenCode = try viewModelInput
            .authenUrl
            .flatMap {
                self.authenticationUsecaseMock.openAuthen(param: "code", resultUrl: $0)
            }
            .toBlocking()
            .first()
        
        XCTAssertEqual(authenCode, "code")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
