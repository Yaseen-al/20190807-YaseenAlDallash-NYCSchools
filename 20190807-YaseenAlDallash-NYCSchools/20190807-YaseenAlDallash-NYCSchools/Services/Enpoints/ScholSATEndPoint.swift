//
//  ScholSATEndPoint.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import Foundation
import Alamofire

enum ScholSATEndPoint {
    case retrieveByDbn(dbn: String)
    case retrieveBySchool(schoolName: String)
}

extension ScholSATEndPoint: EndPoint {
    var baseURL: URL {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {
            fatalError()
        }
        return url
    }
    
    var absoluteURI: URL {
        var urlComp = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        switch self {
        case .retrieveByDbn(let dbn):
            urlComp?.queryItems = [URLQueryItem(name: "dbn", value: dbn)]
        case .retrieveBySchool(let schoolName):
            urlComp?.queryItems = [URLQueryItem(name: "school_name", value: schoolName)]
        }
        guard let urlWithQuery = urlComp?.url else {
            return baseURL
        }
        return urlWithQuery
    }
    
    var path: String? {
        return nil
    }
    
    var serviceName: String {
            return "Service Name: -- retrievingSchoolSAT"
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
