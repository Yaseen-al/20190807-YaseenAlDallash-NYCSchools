//
//  Networking.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import Foundation
import Alamofire


enum NetworingErros{
    case invalidURL
}

struct Networking {
    
    static func request<T: Decodable>(from endPoint: EndPoint,
                                      completion: @escaping (Result<T, Error>)->Void) {
        
        let request = AF.request(endPoint.absoluteURI, method: endPoint.httpMethod,
                                 parameters: endPoint.parameters,
                                 encoding: endPoint.parameterEncoding,
                                 headers: nil, interceptor: nil)
        
        Logger.logServiceInfo(serviceName: endPoint.serviceName,
                              url: endPoint.absoluteURI,
                              params: endPoint.parameters ?? [:])
        
        let completion: (DataResponse<T>)->Void = { dataResponse in
            completion(dataResponse.result)
        }
        let response = request.responseDecodable(completionHandler: completion)
        Logger.log(response, eventType: .information)
    }
    
    
    static func request<T: Decodable>(from endPoint: EndPoint,
                                      completion: @escaping (DataResponse<T>)->Void) {
        
        let request = AF.request(endPoint.absoluteURI,
                                 method: endPoint.httpMethod,
                                 parameters: endPoint.parameters,
                                 encoding: endPoint.parameterEncoding,
                                 headers: nil, interceptor: nil)
        
        Logger.logServiceInfo(serviceName: endPoint.serviceName, url: endPoint.absoluteURI, params: endPoint.parameters ?? [:])

        let response = request.responseDecodable(completionHandler: completion)
        Logger.log(response, eventType: .information)
    }
    
    static func requestDef<T: Decodable>(from endPoint: EndPoint, completion: @escaping((Result<T, Error>)->Void) ) {
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: endPoint.absoluteURI) { (data, response, error) in
            guard let safeData = data else {
                Logger.log("No Data avialable", eventType: .error)
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: safeData)
                completion(Result.success(response))
            } catch let error {
                completion(Result.failure(error))
            }
        }.resume()
    }
}
