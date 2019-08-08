//
//  HighSchoolDirectoryEndPoint.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import Foundation
import Alamofire

enum HighSchoolDirectoryEndPoint {
    case fetchAllHighSchools
}

extension HighSchoolDirectoryEndPoint: EndPoint {
    var absoluteURI: URL {
        var url = baseURL
        if let safePath = path {
            url.appendPathComponent(safePath)
        }
        return url
    }
    
    
    var baseURL: URL {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
            fatalError()
        }
        return url
    }
    
    var path: String? {
        return nil
    }
    
    var key: String? {
        return nil
    }
    
    var token: String? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    var serviceName: String {
        switch self {
        case .fetchAllHighSchools:
            return "Service Name: -- fetchAllHighSchools"
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchAllHighSchools:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .fetchAllHighSchools:
            return JSONEncoding.default
        }
    }
}
