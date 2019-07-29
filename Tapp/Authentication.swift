//
//  Authentication.swift
//  Tapp
//
//  Created by D. graham on 2019-07-17.
//  Copyright © 2019 Carspotter Daily. All rights reserved.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let authentication = try Authentication(json)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAuthentication { response in
//     if let authentication = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Authentication
class Authentication: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
    
    init(accessToken: String, tokenType: String, expiresIn: Int, refreshToken: String, createdAt: Int) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.refreshToken = refreshToken
        self.createdAt = createdAt
    }
}

// MARK: Authentication convenience initializers and mutators

extension Authentication {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Authentication.self, from: data)
        self.init(accessToken: me.accessToken, tokenType: me.tokenType, expiresIn: me.expiresIn, refreshToken: me.refreshToken, createdAt: me.createdAt)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        accessToken: String? = nil,
        tokenType: String? = nil,
        expiresIn: Int? = nil,
        refreshToken: String? = nil,
        createdAt: Int? = nil
        ) -> Authentication {
        return Authentication(
            accessToken: accessToken ?? self.accessToken,
            tokenType: tokenType ?? self.tokenType,
            expiresIn: expiresIn ?? self.expiresIn,
            refreshToken: refreshToken ?? self.refreshToken,
            createdAt: createdAt ?? self.createdAt
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseAuthentication(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Authentication>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

