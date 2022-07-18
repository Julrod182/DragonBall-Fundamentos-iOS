//
//  LocalDataModel.swift
//  DragonBallApp-JDRRTests
//
//  Created by Julio Rodriguez Reategui on 17/07/22.
//

import XCTest
@testable import DragonBallApp_JDRR

class LocalDataModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        LocalDataModel.deleteToken()
    }

    func testSaveToken() throws {
        //Given
        let storedToken = "TestToken"
        
        //When
        LocalDataModel.save(token: storedToken)
        
        //Then
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertEqual(retrievedToken, storedToken, "retrieved token doesn't match stored token")
    }
    
    func testGetTokenWhenNotTokenSaved() throws {
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertNil(retrievedToken, "There should be no saved token")
    }
    
    func testDeleteToken() throws {
        //Given
        let storedToken = "TestToken"
        LocalDataModel.save(token: storedToken)
        //When
        LocalDataModel.deleteToken()
        
        //Then
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertNil(retrievedToken, "There should be no saved token")
    }

}