// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let version = try Version(json)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseVersion { response in
//     if let version = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Version
class Version: Codable {
    let applications: [Application]
    
    enum CodingKeys: String, CodingKey {
        case applications = "Applications"
    }
    
    init(applications: [Application]) {
        self.applications = applications
    }
}

// MARK: Version convenience initializers and mutators

extension Version {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Version.self, from: data)
        self.init(applications: me.applications)
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
        applications: [Application]? = nil
        ) -> Version {
        return Version(
            applications: applications ?? self.applications
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseApplication { response in
//     if let application = response.result.value {
//       ...
//     }
//   }

// MARK: - Application
class Application: Codable {
    let type: String
    let identifier: Int
    let deprecatedVersions: Int
    let latestVersion: Double
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case identifier = "identifier"
        case deprecatedVersions = "deprecatedVersions"
        case latestVersion = "latestVersion"
    }
    
    init(type: String, identifier: Int, deprecatedVersions: Int, latestVersion: Double) {
        self.type = type
        self.identifier = identifier
        self.deprecatedVersions = deprecatedVersions
        self.latestVersion = latestVersion
    }
}

// MARK: Application convenience initializers and mutators

extension Application {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Application.self, from: data)
        self.init(type: me.type, identifier: me.identifier, deprecatedVersions: me.deprecatedVersions, latestVersion: me.latestVersion)
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
        type: String? = nil,
        identifier: Int? = nil,
        deprecatedVersions: Int? = nil,
        latestVersion: Double? = nil
        ) -> Application {
        return Application(
            type: type ?? self.type,
            identifier: identifier ?? self.identifier,
            deprecatedVersions: deprecatedVersions ?? self.deprecatedVersions,
            latestVersion: latestVersion ?? self.latestVersion
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
    func responseVersion(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Version>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
