//
//  NetworkModelTest.swift
//  DragonBallApp-JDRRTests
//
//  Created by Julio Rodriguez Reategui on 17/07/22.
//

import XCTest
@testable import DragonBallApp_JDRR

class NetworkModelTest: XCTestCase {
    
    private var sut: NetworkModel!

    override func setUpWithError() throws {
        sut = NetworkModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginSuccess() throws {
        let expectation = expectation(description: "Login Succes")
        var retrievedToken: String?
        var error: NetworkError?
        
        sut.login(user: "juan.guidi@globant.com", password: "123456") { token, networkError in
            retrievedToken = token
            error = networkError
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(retrievedToken, "Should have received a token")
        XCTAssertNil(error, "There should be no error")
        
    }
    
    func testLoginFail() throws {
        let expectation = expectation(description: "Login Fail")
        var retrievedToken: String?
        var error: NetworkError?
        
        sut.login(user: "juan.guidi@globant", password: "123456") { token, networkError in
            retrievedToken = token
            error = networkError
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNil(retrievedToken, "Should have not received a token")
        XCTAssertNotNil(error, "There should be an error")
        
    }

}
