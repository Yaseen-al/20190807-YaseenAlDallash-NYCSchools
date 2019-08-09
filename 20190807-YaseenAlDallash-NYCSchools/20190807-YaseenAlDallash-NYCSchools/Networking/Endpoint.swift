//
//  Endpoint.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import Foundation
import Alamofire


protocol EndPoint {
    /// The base URL for your endPoint.
    var baseURL: URL { get }
    /// Any additional path to your endpoint
    /// Absolute URI that will be used directly for your endpoint
    var absoluteURI: URL { get }
    var path: String? { get }
    /// The service name for each specific path in your endpoint
    var serviceName: String { get }
    /// Header params for your endpoint
    var parameters: [String: Any]? { get }
    /// Endpoint `HTTPMethod`
    var httpMethod : HTTPMethod { get }
    /// A type used to define how a set of parameters are applied to a `URLRequest`.
    var parameterEncoding: ParameterEncoding { get }

}

extension EndPoint {
}
