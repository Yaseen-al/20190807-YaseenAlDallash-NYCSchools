//
//  HighSchoolDirectoryEndPointTests.swift
//  20190807-YaseenAlDallash-NYCSchoolsTests
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import XCTest
import Alamofire
@testable import _0190807_YaseenAlDallash_NYCSchools

class HighSchoolDirectoryEndPointTests: XCTestCase {
    
    var endPoint = HighSchoolDirectoryEndPoint.fetchAllHighSchools
    var schools: [HighSchoolModel]?
    
    func testEndPoint() {
        XCTAssertFalse(endPoint.baseURL.absoluteString.isEmpty)
        XCTAssertEqual(endPoint.httpMethod, .get)
        XCTAssertFalse(endPoint.absoluteURI.absoluteString.isEmpty)
    }
    
    func testFetchingSchools() {
        // Given
        let exp = expectation(description: "fetchingSchools")
        // When
        Networking.request(from: endPoint) {[weak self] (response: DataResponse<[HighSchoolModel]>) in
            switch response.result {
            case .success(let schools):
                self?.schools = schools
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [exp], timeout: 5.0)
        // Then
        XCTAssertNotNil(schools)
    }
}
