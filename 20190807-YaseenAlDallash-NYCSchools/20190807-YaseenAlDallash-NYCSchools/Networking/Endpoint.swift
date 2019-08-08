//
//  Endpoint.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import Foundation
import Alamofire


protocol EndPointType {
    /// The base URL for your endPoint.
    var baseURL: URL { get }
    /// Any additional path to your endpoint
    var path: String { get }
    /// Any key required in endpoint if exists
    var key: String? { get set}
    /// Any token required in endpoint if exists
    var token: String? { get set}
    /// The service name for each specific path in your endpoint
    var serviceName: String { get }
    /// Header params for your endpoint
    var parameters: [String: Any]? { get }
    /// Endpoint `HTTPMethod`
    var httpMethod : HTTPMethod { get }
    /// A type used to define how a set of parameters are applied to a `URLRequest`.
    var parameterEncoding: ParameterEncoding { get }
    /// Get absolute url that will be used directly for your endpoint
    func getAbsoluteURL() -> URL
}
