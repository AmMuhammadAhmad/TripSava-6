//
//  Protocols.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 06/07/2023.
//

import UIKit

///APIResult...
enum APIResult<T> {
    case success(T)
    case failure(String)
    
    var value: T? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
}

///APIBaseResult...
enum APIBaseResult<String> {
    case success(String)
    case failure(String)
    
    var value: String? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
}

 

///BaseResponse...
struct BaseResponse: Codable {
    
    let status: String?
    enum CodingKeys: String, CodingKey { case status = "status" }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

typealias userCredentials = (email: String, password: String)
