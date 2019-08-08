//
//  Networking.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import Foundation
import Alamofire

struct Networking {
    
    static func request<T: Decodable>(from endPoint: EndPointType,
                                      completion: @escaping (Result<T, Error>)->Void) {
        
        let request = AF.request(endPoint.getAbsoluteURL(), method: endPoint.httpMethod, parameters: endPoint.parameters, encoding: endPoint.parameterEncoding, headers: nil, interceptor: nil)
        Logger.log(request, eventType: .information)
        request.validate()
        
        let completion: (DataResponse<T>)->Void = { dataResponse in
            completion(dataResponse.result)
        }
        let response = request.responseDecodable(completionHandler: completion)
        Logger.log(response, eventType: .information)
    }
    
    
    static func request<T: Decodable>(from endPoint: EndPointType,
                                      completion: @escaping (DataResponse<T>)->Void) {
        
        let request = AF.request(endPoint.getAbsoluteURL(), method: endPoint.httpMethod, parameters: endPoint.parameters, encoding: endPoint.parameterEncoding, headers: nil, interceptor: nil)
        Logger.log(request, eventType: .information)
        request.validate()

        let response = request.responseDecodable(completionHandler: completion)
        Logger.log(response, eventType: .information)
    }
    
}
