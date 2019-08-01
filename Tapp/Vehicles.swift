// This file was generated from JSON Schema using quicktype, do not modify it directly.

// To parse the JSON, add this file to your project and do:

//

//   let vehicles = try Vehicles(json)



//

// To parse values from Alamofire responses:

//

//   Alamofire.request(url).responseVehicles { response in

//     if let vehicles = response.result.value {

//       ...

//     }

//   }



import Foundation

import Alamofire



// MARK: - Vehicles

class Vehicles: Codable {
    
    let response: [Response]
    
    let count: Int
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case response = "response"
        
        case count = "count"
        
    }
    
    
    
    init(response: [Response], count: Int) {
        
        self.response = response
        
        self.count = count
        
    }
    
}



// MARK: Vehicles convenience initializers and mutators



extension Vehicles {
    
    convenience init(data: Data) throws {
        
        let me = try newJSONDecoder().decode(Vehicles.self, from: data)
        
        self.init(response: me.response, count: me.count)
        
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
        
        response: [Response]? = nil,
        
        count: Int? = nil
        
        ) -> Vehicles {
        
        return Vehicles(
            
            response: response ?? self.response,
            
            count: count ?? self.count
            
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

//   Alamofire.request(url).responseResponse { response in

//     if let response = response.result.value {

//       ...

//     }

//   }



// MARK: - Response

class Response: Codable {
    
    let id: Int
    
    let vehicleID: Int
    
    let vin: String
    
    let displayName: String
    
    let optionCodes: String
    
    let color: JSONNull?
    
    let tokens: [String]
    
    let state: String
    
    let inService: Bool
    
    let idS: String
    
    let calendarEnabled: Bool
    
    let apiVersion: Int
    
    let backseatToken: JSONNull?
    
    let backseatTokenUpdatedAt: JSONNull?
    
    var image: NSImage?
    
    var data: VehicleData?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        
        case vehicleID = "vehicle_id"
        
        case vin = "vin"
        
        case displayName = "display_name"
        
        case optionCodes = "option_codes"
        
        case color = "color"
        
        case tokens = "tokens"
        
        case state = "state"
        
        case inService = "in_service"
        
        case idS = "id_s"
        
        case calendarEnabled = "calendar_enabled"
        
        case apiVersion = "api_version"
        
        case backseatToken = "backseat_token"
        
        case backseatTokenUpdatedAt = "backseat_token_updated_at"
        
    }
    
    
    
    init(id: Int, vehicleID: Int, vin: String, displayName: String, optionCodes: String, color: JSONNull?, tokens: [String], state: String, inService: Bool, idS: String, calendarEnabled: Bool, apiVersion: Int, backseatToken: JSONNull?, backseatTokenUpdatedAt: JSONNull?) {
        
        self.id = id
        
        self.vehicleID = vehicleID
        
        self.vin = vin
        
        self.displayName = displayName
        
        self.optionCodes = optionCodes
        
        self.color = color
        
        self.tokens = tokens
        
        self.state = state
        
        self.inService = inService
        
        self.idS = idS
        
        self.calendarEnabled = calendarEnabled
        
        self.apiVersion = apiVersion
        
        self.backseatToken = backseatToken
        
        self.backseatTokenUpdatedAt = backseatTokenUpdatedAt
        
    }
    
}



// MARK: Response convenience initializers and mutators



extension Response {
    
    convenience init(data: Data) throws {
        
        let me = try newJSONDecoder().decode(Response.self, from: data)
        
        self.init(id: me.id, vehicleID: me.vehicleID, vin: me.vin, displayName: me.displayName, optionCodes: me.optionCodes, color: me.color, tokens: me.tokens, state: me.state, inService: me.inService, idS: me.idS, calendarEnabled: me.calendarEnabled, apiVersion: me.apiVersion, backseatToken: me.backseatToken, backseatTokenUpdatedAt: me.backseatTokenUpdatedAt)
        
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
        
        id: Int? = nil,
        
        vehicleID: Int? = nil,
        
        vin: String? = nil,
        
        displayName: String? = nil,
        
        optionCodes: String? = nil,
        
        color: JSONNull?? = nil,
        
        tokens: [String]? = nil,
        
        state: String? = nil,
        
        inService: Bool? = nil,
        
        idS: String? = nil,
        
        calendarEnabled: Bool? = nil,
        
        apiVersion: Int? = nil,
        
        backseatToken: JSONNull?? = nil,
        
        backseatTokenUpdatedAt: JSONNull?? = nil
        
        ) -> Response {
        
        return Response(
            
            id: id ?? self.id,
            
            vehicleID: vehicleID ?? self.vehicleID,
            
            vin: vin ?? self.vin,
            
            displayName: displayName ?? self.displayName,
            
            optionCodes: optionCodes ?? self.optionCodes,
            
            color: color ?? self.color,
            
            tokens: tokens ?? self.tokens,
            
            state: state ?? self.state,
            
            inService: inService ?? self.inService,
            
            idS: idS ?? self.idS,
            
            calendarEnabled: calendarEnabled ?? self.calendarEnabled,
            
            apiVersion: apiVersion ?? self.apiVersion,
            
            backseatToken: backseatToken ?? self.backseatToken,
            
            backseatTokenUpdatedAt: backseatTokenUpdatedAt ?? self.backseatTokenUpdatedAt
            
        )
        
    }
    
    
    
    func jsonData() throws -> Data {
        
        return try newJSONEncoder().encode(self)
        
    }
    
    
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        
        return String(data: try self.jsonData(), encoding: encoding)
        
    }
    
}



// MARK: - Helper functions for creating encoders and decoders



func newJSONDecoder() -> JSONDecoder {
    
    let decoder = JSONDecoder()
    
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        
        decoder.dateDecodingStrategy = .iso8601
        
    }
    
    return decoder
    
}



func newJSONEncoder() -> JSONEncoder {
    
    let encoder = JSONEncoder()
    
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        
        encoder.dateEncodingStrategy = .iso8601
        
    }
    
    return encoder
    
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
    
    func responseVehicles(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Vehicles>) -> Void) -> Self {
        
        return responseDecodable(queue: queue, completionHandler: completionHandler)
        
    }
    
}



// MARK: - Encode/decode helpers



class JSONNull: Codable, Hashable {
    
    
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        
        return true
        
    }
    
    
    
    public var hashValue: Int {
        
        return 0
        
    }
    
    
    
    public func hash(into hasher: inout Hasher) {
        
        // No-op
        
    }
    
    
    
    public init() {}
    
    
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if !container.decodeNil() {
            
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            
        }
        
    }
    
    
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        try container.encodeNil()
        
    }
    
}


