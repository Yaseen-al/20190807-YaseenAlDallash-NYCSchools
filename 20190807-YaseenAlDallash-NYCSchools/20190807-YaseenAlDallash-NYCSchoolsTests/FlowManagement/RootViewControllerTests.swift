//
//  RootViewControllerTests.swift
//  20190807-YaseenAlDallash-NYCSchoolsTests
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import XCTest

@testable import _0190807_YaseenAlDallash_NYCSchools

class RootViewControllerTests: XCTestCase {
    
    var rootViewController: RootViewController?

    override func setUp() {
        super.setUp()
        self.rootViewController = AppDelegate.shared.rootViewController
        rootViewController?.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
        rootViewController = nil
    }
    
    func testRootVC() {
        XCTAssertNotNil(rootViewController)
        XCTAssertGreaterThan(rootViewController?.children.count ?? 0, 0, "Test Failed due to improper current `rootViewController`'s controller setup")
    }
    
    func testControllerRouting() {
        // Given
        let exp = expectation(description: "dispatching")
        let testController = UIViewController()
        testController.view.tag = 2
        
        // When
        rootViewController?.route(to: testController){ [weak exp] in
            exp?.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        // Then
        XCTAssertEqual(rootViewController?.children.first?.view.tag ?? 0, testController.view.tag)
    }
    
}
