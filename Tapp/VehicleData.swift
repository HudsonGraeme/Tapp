// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let vehicleData = try VehicleData(json)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseVehicleData { response in
//     if let vehicleData = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - VehicleData
class VehicleData: Codable {
    let response: dResponse
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
    
    init(response: dResponse) {
        self.response = response
    }
}

// MARK: VehicleData convenience initializers and mutators

extension VehicleData {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(VehicleData.self, from: data)
        self.init(response: me.response)
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
        response: dResponse? = nil
        ) -> VehicleData {
        return VehicleData(
            response: response ?? self.response
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
//   Alamofire.request(url).responsedResponse { response in
//     if let response = response.result.value {
//       ...
//     }
//   }

// MARK: - dResponse
class dResponse: Codable {
    let color: JSONNull?
    let apiVersion: Int
    let vehicleID: Int
    let guiSettings: GUISettings
    let userID: Int
    let backseatToken: JSONNull?
    let vehicleConfig: VehicleConfig
    let climateState: ClimateState
    let vehicleState: VehicleState
    let vin: String
    let optionCodes: String
    let state: String
    let idS: String
    let id: Double
    let calendarEnabled: Bool
    let backseatTokenUpdatedAt: JSONNull?
    let chargeState: ChargeState
    let displayName: String
    let tokens: [String]
    let driveState: DriveState
    let inService: Bool
    
    enum CodingKeys: String, CodingKey {
        case color = "color"
        case apiVersion = "api_version"
        case vehicleID = "vehicle_id"
        case guiSettings = "gui_settings"
        case userID = "user_id"
        case backseatToken = "backseat_token"
        case vehicleConfig = "vehicle_config"
        case climateState = "climate_state"
        case vehicleState = "vehicle_state"
        case vin = "vin"
        case optionCodes = "option_codes"
        case state = "state"
        case idS = "id_s"
        case id = "id"
        case calendarEnabled = "calendar_enabled"
        case backseatTokenUpdatedAt = "backseat_token_updated_at"
        case chargeState = "charge_state"
        case displayName = "display_name"
        case tokens = "tokens"
        case driveState = "drive_state"
        case inService = "in_service"
    }
    
    init(color: JSONNull?, apiVersion: Int, vehicleID: Int, guiSettings: GUISettings, userID: Int, backseatToken: JSONNull?, vehicleConfig: VehicleConfig, climateState: ClimateState, vehicleState: VehicleState, vin: String, optionCodes: String, state: String, idS: String, id: Double, calendarEnabled: Bool, backseatTokenUpdatedAt: JSONNull?, chargeState: ChargeState, displayName: String, tokens: [String], driveState: DriveState, inService: Bool) {
        self.color = color
        self.apiVersion = apiVersion
        self.vehicleID = vehicleID
        self.guiSettings = guiSettings
        self.userID = userID
        self.backseatToken = backseatToken
        self.vehicleConfig = vehicleConfig
        self.climateState = climateState
        self.vehicleState = vehicleState
        self.vin = vin
        self.optionCodes = optionCodes
        self.state = state
        self.idS = idS
        self.id = id
        self.calendarEnabled = calendarEnabled
        self.backseatTokenUpdatedAt = backseatTokenUpdatedAt
        self.chargeState = chargeState
        self.displayName = displayName
        self.tokens = tokens
        self.driveState = driveState
        self.inService = inService
    }
}

// MARK: Response convenience initializers and mutators

extension dResponse {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(dResponse.self, from: data)
        self.init(color: me.color, apiVersion: me.apiVersion, vehicleID: me.vehicleID, guiSettings: me.guiSettings, userID: me.userID, backseatToken: me.backseatToken, vehicleConfig: me.vehicleConfig, climateState: me.climateState, vehicleState: me.vehicleState, vin: me.vin, optionCodes: me.optionCodes, state: me.state, idS: me.idS, id: me.id, calendarEnabled: me.calendarEnabled, backseatTokenUpdatedAt: me.backseatTokenUpdatedAt, chargeState: me.chargeState, displayName: me.displayName, tokens: me.tokens, driveState: me.driveState, inService: me.inService)
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
        color: JSONNull?? = nil,
        apiVersion: Int? = nil,
        vehicleID: Int? = nil,
        guiSettings: GUISettings? = nil,
        userID: Int? = nil,
        backseatToken: JSONNull?? = nil,
        vehicleConfig: VehicleConfig? = nil,
        climateState: ClimateState? = nil,
        vehicleState: VehicleState? = nil,
        vin: String? = nil,
        optionCodes: String? = nil,
        state: String? = nil,
        idS: String? = nil,
        id: Double? = nil,
        calendarEnabled: Bool? = nil,
        backseatTokenUpdatedAt: JSONNull?? = nil,
        chargeState: ChargeState? = nil,
        displayName: String? = nil,
        tokens: [String]? = nil,
        driveState: DriveState? = nil,
        inService: Bool? = nil
        ) -> dResponse {
        return dResponse(
            color: color ?? self.color,
            apiVersion: apiVersion ?? self.apiVersion,
            vehicleID: vehicleID ?? self.vehicleID,
            guiSettings: guiSettings ?? self.guiSettings,
            userID: userID ?? self.userID,
            backseatToken: backseatToken ?? self.backseatToken,
            vehicleConfig: vehicleConfig ?? self.vehicleConfig,
            climateState: climateState ?? self.climateState,
            vehicleState: vehicleState ?? self.vehicleState,
            vin: vin ?? self.vin,
            optionCodes: optionCodes ?? self.optionCodes,
            state: state ?? self.state,
            idS: idS ?? self.idS,
            id: id ?? self.id,
            calendarEnabled: calendarEnabled ?? self.calendarEnabled,
            backseatTokenUpdatedAt: backseatTokenUpdatedAt ?? self.backseatTokenUpdatedAt,
            chargeState: chargeState ?? self.chargeState,
            displayName: displayName ?? self.displayName,
            tokens: tokens ?? self.tokens,
            driveState: driveState ?? self.driveState,
            inService: inService ?? self.inService
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
//   Alamofire.request(url).responseChargeState { response in
//     if let chargeState = response.result.value {
//       ...
//     }
//   }

// MARK: - ChargeState
class ChargeState: Codable {
    let fastChargerType: String
    let timestamp: Int
    let estBatteryRange: Double
    let userChargeEnableRequest: JSONNull?
    let chargeEnergyAdded: Double
    let chargeCurrentRequestMax: Int
    let fastChargerBrand: String
    let chargerPhases: Int
    let fastChargerPresent: Bool
    let batteryHeaterOn: Bool
    let timeToFullCharge: Int
    let chargeCurrentRequest: Int
    let batteryRange: Double
    let chargeEnableRequest: Bool
    let chargePortDoorOpen: Bool
    let chargeLimitSocStd: Int
    let chargePortLatch: String
    let chargerActualCurrent: Int
    let managedChargingActive: Bool
    let chargerVoltage: Int
    let tripCharging: Bool
    let chargerPilotCurrent: Int
    let chargeRate: Double
    let connChargeCable: String
    let chargeLimitSocMax: Int
    let chargeLimitSocMin: Int
    let usableBatteryLevel: Int
    let idealBatteryRange: Double
    let maxRangeChargeCounter: Int
    let scheduledChargingStartTime: JSONNull?
    let chargerPower: Int
    let managedChargingStartTime: JSONNull?
    let notEnoughPowerToHeat: Bool
    let scheduledChargingPending: Bool
    let chargeMilesAddedRated: Int
    let batteryLevel: Int
    let chargeToMaxRange: Bool
    let chargePortColdWeatherMode: JSONNull?
    let chargeMilesAddedIdeal: Int
    let managedChargingUserCanceled: Bool
    let chargeLimitSoc: Int
    let chargingState: String
    
    enum CodingKeys: String, CodingKey {
        case fastChargerType = "fast_charger_type"
        case timestamp = "timestamp"
        case estBatteryRange = "est_battery_range"
        case userChargeEnableRequest = "user_charge_enable_request"
        case chargeEnergyAdded = "charge_energy_added"
        case chargeCurrentRequestMax = "charge_current_request_max"
        case fastChargerBrand = "fast_charger_brand"
        case chargerPhases = "charger_phases"
        case fastChargerPresent = "fast_charger_present"
        case batteryHeaterOn = "battery_heater_on"
        case timeToFullCharge = "time_to_full_charge"
        case chargeCurrentRequest = "charge_current_request"
        case batteryRange = "battery_range"
        case chargeEnableRequest = "charge_enable_request"
        case chargePortDoorOpen = "charge_port_door_open"
        case chargeLimitSocStd = "charge_limit_soc_std"
        case chargePortLatch = "charge_port_latch"
        case chargerActualCurrent = "charger_actual_current"
        case managedChargingActive = "managed_charging_active"
        case chargerVoltage = "charger_voltage"
        case tripCharging = "trip_charging"
        case chargerPilotCurrent = "charger_pilot_current"
        case chargeRate = "charge_rate"
        case connChargeCable = "conn_charge_cable"
        case chargeLimitSocMax = "charge_limit_soc_max"
        case chargeLimitSocMin = "charge_limit_soc_min"
        case usableBatteryLevel = "usable_battery_level"
        case idealBatteryRange = "ideal_battery_range"
        case maxRangeChargeCounter = "max_range_charge_counter"
        case scheduledChargingStartTime = "scheduled_charging_start_time"
        case chargerPower = "charger_power"
        case managedChargingStartTime = "managed_charging_start_time"
        case notEnoughPowerToHeat = "not_enough_power_to_heat"
        case scheduledChargingPending = "scheduled_charging_pending"
        case chargeMilesAddedRated = "charge_miles_added_rated"
        case batteryLevel = "battery_level"
        case chargeToMaxRange = "charge_to_max_range"
        case chargePortColdWeatherMode = "charge_port_cold_weather_mode"
        case chargeMilesAddedIdeal = "charge_miles_added_ideal"
        case managedChargingUserCanceled = "managed_charging_user_canceled"
        case chargeLimitSoc = "charge_limit_soc"
        case chargingState = "charging_state"
    }
    
    init(fastChargerType: String, timestamp: Int, estBatteryRange: Double, userChargeEnableRequest: JSONNull?, chargeEnergyAdded: Double, chargeCurrentRequestMax: Int, fastChargerBrand: String, chargerPhases: Int, fastChargerPresent: Bool, batteryHeaterOn: Bool, timeToFullCharge: Int, chargeCurrentRequest: Int, batteryRange: Double, chargeEnableRequest: Bool, chargePortDoorOpen: Bool, chargeLimitSocStd: Int, chargePortLatch: String, chargerActualCurrent: Int, managedChargingActive: Bool, chargerVoltage: Int, tripCharging: Bool, chargerPilotCurrent: Int, chargeRate: Double, connChargeCable: String, chargeLimitSocMax: Int, chargeLimitSocMin: Int, usableBatteryLevel: Int, idealBatteryRange: Double, maxRangeChargeCounter: Int, scheduledChargingStartTime: JSONNull?, chargerPower: Int, managedChargingStartTime: JSONNull?, notEnoughPowerToHeat: Bool, scheduledChargingPending: Bool, chargeMilesAddedRated: Int, batteryLevel: Int, chargeToMaxRange: Bool, chargePortColdWeatherMode: JSONNull?, chargeMilesAddedIdeal: Int, managedChargingUserCanceled: Bool, chargeLimitSoc: Int, chargingState: String) {
        self.fastChargerType = fastChargerType
        self.timestamp = timestamp
        self.estBatteryRange = estBatteryRange
        self.userChargeEnableRequest = userChargeEnableRequest
        self.chargeEnergyAdded = chargeEnergyAdded
        self.chargeCurrentRequestMax = chargeCurrentRequestMax
        self.fastChargerBrand = fastChargerBrand
        self.chargerPhases = chargerPhases
        self.fastChargerPresent = fastChargerPresent
        self.batteryHeaterOn = batteryHeaterOn
        self.timeToFullCharge = timeToFullCharge
        self.chargeCurrentRequest = chargeCurrentRequest
        self.batteryRange = batteryRange
        self.chargeEnableRequest = chargeEnableRequest
        self.chargePortDoorOpen = chargePortDoorOpen
        self.chargeLimitSocStd = chargeLimitSocStd
        self.chargePortLatch = chargePortLatch
        self.chargerActualCurrent = chargerActualCurrent
        self.managedChargingActive = managedChargingActive
        self.chargerVoltage = chargerVoltage
        self.tripCharging = tripCharging
        self.chargerPilotCurrent = chargerPilotCurrent
        self.chargeRate = chargeRate
        self.connChargeCable = connChargeCable
        self.chargeLimitSocMax = chargeLimitSocMax
        self.chargeLimitSocMin = chargeLimitSocMin
        self.usableBatteryLevel = usableBatteryLevel
        self.idealBatteryRange = idealBatteryRange
        self.maxRangeChargeCounter = maxRangeChargeCounter
        self.scheduledChargingStartTime = scheduledChargingStartTime
        self.chargerPower = chargerPower
        self.managedChargingStartTime = managedChargingStartTime
        self.notEnoughPowerToHeat = notEnoughPowerToHeat
        self.scheduledChargingPending = scheduledChargingPending
        self.chargeMilesAddedRated = chargeMilesAddedRated
        self.batteryLevel = batteryLevel
        self.chargeToMaxRange = chargeToMaxRange
        self.chargePortColdWeatherMode = chargePortColdWeatherMode
        self.chargeMilesAddedIdeal = chargeMilesAddedIdeal
        self.managedChargingUserCanceled = managedChargingUserCanceled
        self.chargeLimitSoc = chargeLimitSoc
        self.chargingState = chargingState
    }
}

// MARK: ChargeState convenience initializers and mutators

extension ChargeState {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ChargeState.self, from: data)
        self.init(fastChargerType: me.fastChargerType, timestamp: me.timestamp, estBatteryRange: me.estBatteryRange, userChargeEnableRequest: me.userChargeEnableRequest, chargeEnergyAdded: me.chargeEnergyAdded, chargeCurrentRequestMax: me.chargeCurrentRequestMax, fastChargerBrand: me.fastChargerBrand, chargerPhases: me.chargerPhases, fastChargerPresent: me.fastChargerPresent, batteryHeaterOn: me.batteryHeaterOn, timeToFullCharge: me.timeToFullCharge, chargeCurrentRequest: me.chargeCurrentRequest, batteryRange: me.batteryRange, chargeEnableRequest: me.chargeEnableRequest, chargePortDoorOpen: me.chargePortDoorOpen, chargeLimitSocStd: me.chargeLimitSocStd, chargePortLatch: me.chargePortLatch, chargerActualCurrent: me.chargerActualCurrent, managedChargingActive: me.managedChargingActive, chargerVoltage: me.chargerVoltage, tripCharging: me.tripCharging, chargerPilotCurrent: me.chargerPilotCurrent, chargeRate: me.chargeRate, connChargeCable: me.connChargeCable, chargeLimitSocMax: me.chargeLimitSocMax, chargeLimitSocMin: me.chargeLimitSocMin, usableBatteryLevel: me.usableBatteryLevel, idealBatteryRange: me.idealBatteryRange, maxRangeChargeCounter: me.maxRangeChargeCounter, scheduledChargingStartTime: me.scheduledChargingStartTime, chargerPower: me.chargerPower, managedChargingStartTime: me.managedChargingStartTime, notEnoughPowerToHeat: me.notEnoughPowerToHeat, scheduledChargingPending: me.scheduledChargingPending, chargeMilesAddedRated: me.chargeMilesAddedRated, batteryLevel: me.batteryLevel, chargeToMaxRange: me.chargeToMaxRange, chargePortColdWeatherMode: me.chargePortColdWeatherMode, chargeMilesAddedIdeal: me.chargeMilesAddedIdeal, managedChargingUserCanceled: me.managedChargingUserCanceled, chargeLimitSoc: me.chargeLimitSoc, chargingState: me.chargingState)
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
        fastChargerType: String? = nil,
        timestamp: Int? = nil,
        estBatteryRange: Double? = nil,
        userChargeEnableRequest: JSONNull?? = nil,
        chargeEnergyAdded: Double? = nil,
        chargeCurrentRequestMax: Int? = nil,
        fastChargerBrand: String? = nil,
        chargerPhases: Int? = nil,
        fastChargerPresent: Bool? = nil,
        batteryHeaterOn: Bool? = nil,
        timeToFullCharge: Int? = nil,
        chargeCurrentRequest: Int? = nil,
        batteryRange: Double? = nil,
        chargeEnableRequest: Bool? = nil,
        chargePortDoorOpen: Bool? = nil,
        chargeLimitSocStd: Int? = nil,
        chargePortLatch: String? = nil,
        chargerActualCurrent: Int? = nil,
        managedChargingActive: Bool? = nil,
        chargerVoltage: Int? = nil,
        tripCharging: Bool? = nil,
        chargerPilotCurrent: Int? = nil,
        chargeRate: Double? = nil,
        connChargeCable: String? = nil,
        chargeLimitSocMax: Int? = nil,
        chargeLimitSocMin: Int? = nil,
        usableBatteryLevel: Int? = nil,
        idealBatteryRange: Double? = nil,
        maxRangeChargeCounter: Int? = nil,
        scheduledChargingStartTime: JSONNull?? = nil,
        chargerPower: Int? = nil,
        managedChargingStartTime: JSONNull?? = nil,
        notEnoughPowerToHeat: Bool? = nil,
        scheduledChargingPending: Bool? = nil,
        chargeMilesAddedRated: Int? = nil,
        batteryLevel: Int? = nil,
        chargeToMaxRange: Bool? = nil,
        chargePortColdWeatherMode: JSONNull?? = nil,
        chargeMilesAddedIdeal: Int? = nil,
        managedChargingUserCanceled: Bool? = nil,
        chargeLimitSoc: Int? = nil,
        chargingState: String? = nil
        ) -> ChargeState {
        return ChargeState(
            fastChargerType: fastChargerType ?? self.fastChargerType,
            timestamp: timestamp ?? self.timestamp,
            estBatteryRange: estBatteryRange ?? self.estBatteryRange,
            userChargeEnableRequest: userChargeEnableRequest ?? self.userChargeEnableRequest,
            chargeEnergyAdded: chargeEnergyAdded ?? self.chargeEnergyAdded,
            chargeCurrentRequestMax: chargeCurrentRequestMax ?? self.chargeCurrentRequestMax,
            fastChargerBrand: fastChargerBrand ?? self.fastChargerBrand,
            chargerPhases: chargerPhases ?? self.chargerPhases,
            fastChargerPresent: fastChargerPresent ?? self.fastChargerPresent,
            batteryHeaterOn: batteryHeaterOn ?? self.batteryHeaterOn,
            timeToFullCharge: timeToFullCharge ?? self.timeToFullCharge,
            chargeCurrentRequest: chargeCurrentRequest ?? self.chargeCurrentRequest,
            batteryRange: batteryRange ?? self.batteryRange,
            chargeEnableRequest: chargeEnableRequest ?? self.chargeEnableRequest,
            chargePortDoorOpen: chargePortDoorOpen ?? self.chargePortDoorOpen,
            chargeLimitSocStd: chargeLimitSocStd ?? self.chargeLimitSocStd,
            chargePortLatch: chargePortLatch ?? self.chargePortLatch,
            chargerActualCurrent: chargerActualCurrent ?? self.chargerActualCurrent,
            managedChargingActive: managedChargingActive ?? self.managedChargingActive,
            chargerVoltage: chargerVoltage ?? self.chargerVoltage,
            tripCharging: tripCharging ?? self.tripCharging,
            chargerPilotCurrent: chargerPilotCurrent ?? self.chargerPilotCurrent,
            chargeRate: chargeRate ?? self.chargeRate,
            connChargeCable: connChargeCable ?? self.connChargeCable,
            chargeLimitSocMax: chargeLimitSocMax ?? self.chargeLimitSocMax,
            chargeLimitSocMin: chargeLimitSocMin ?? self.chargeLimitSocMin,
            usableBatteryLevel: usableBatteryLevel ?? self.usableBatteryLevel,
            idealBatteryRange: idealBatteryRange ?? self.idealBatteryRange,
            maxRangeChargeCounter: maxRangeChargeCounter ?? self.maxRangeChargeCounter,
            scheduledChargingStartTime: scheduledChargingStartTime ?? self.scheduledChargingStartTime,
            chargerPower: chargerPower ?? self.chargerPower,
            managedChargingStartTime: managedChargingStartTime ?? self.managedChargingStartTime,
            notEnoughPowerToHeat: notEnoughPowerToHeat ?? self.notEnoughPowerToHeat,
            scheduledChargingPending: scheduledChargingPending ?? self.scheduledChargingPending,
            chargeMilesAddedRated: chargeMilesAddedRated ?? self.chargeMilesAddedRated,
            batteryLevel: batteryLevel ?? self.batteryLevel,
            chargeToMaxRange: chargeToMaxRange ?? self.chargeToMaxRange,
            chargePortColdWeatherMode: chargePortColdWeatherMode ?? self.chargePortColdWeatherMode,
            chargeMilesAddedIdeal: chargeMilesAddedIdeal ?? self.chargeMilesAddedIdeal,
            managedChargingUserCanceled: managedChargingUserCanceled ?? self.managedChargingUserCanceled,
            chargeLimitSoc: chargeLimitSoc ?? self.chargeLimitSoc,
            chargingState: chargingState ?? self.chargingState
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
//   Alamofire.request(url).responseClimateState { response in
//     if let climateState = response.result.value {
//       ...
//     }
//   }

// MARK: - ClimateState
class ClimateState: Codable {
    let seatHeaterLeft: Int
    let fanStatus: Int
    let isFrontDefrosterOn: Bool
    let batteryHeaterNoPower: Bool
    let isClimateOn: Bool
    let isRearDefrosterOn: Bool
    let seatHeaterRearLeft: Int
    let minAvailTemp: Int
    let insideTemp: Double
    let climateKeeperMode: String
    let driverTempSetting: Int
    let outsideTemp: Int
    let passengerTempSetting: Int
    let seatHeaterRearCenter: Int
    let timestamp: Int
    let rightTempDirection: Int
    let leftTempDirection: Int
    let isPreconditioning: Bool
    let seatHeaterRearRight: Int
    let seatHeaterRight: Int
    let sideMirrorHeaters: Bool
    let smartPreconditioning: Bool
    let maxAvailTemp: Int
    let batteryHeater: Bool
    let isAutoConditioningOn: Bool
    let remoteHeaterControlEnabled: Bool
    let wiperBladeHeater: Bool
    let steeringWheelHeater: Bool
    
    enum CodingKeys: String, CodingKey {
        case seatHeaterLeft = "seat_heater_left"
        case fanStatus = "fan_status"
        case isFrontDefrosterOn = "is_front_defroster_on"
        case batteryHeaterNoPower = "battery_heater_no_power"
        case isClimateOn = "is_climate_on"
        case isRearDefrosterOn = "is_rear_defroster_on"
        case seatHeaterRearLeft = "seat_heater_rear_left"
        case minAvailTemp = "min_avail_temp"
        case insideTemp = "inside_temp"
        case climateKeeperMode = "climate_keeper_mode"
        case driverTempSetting = "driver_temp_setting"
        case outsideTemp = "outside_temp"
        case passengerTempSetting = "passenger_temp_setting"
        case seatHeaterRearCenter = "seat_heater_rear_center"
        case timestamp = "timestamp"
        case rightTempDirection = "right_temp_direction"
        case leftTempDirection = "left_temp_direction"
        case isPreconditioning = "is_preconditioning"
        case seatHeaterRearRight = "seat_heater_rear_right"
        case seatHeaterRight = "seat_heater_right"
        case sideMirrorHeaters = "side_mirror_heaters"
        case smartPreconditioning = "smart_preconditioning"
        case maxAvailTemp = "max_avail_temp"
        case batteryHeater = "battery_heater"
        case isAutoConditioningOn = "is_auto_conditioning_on"
        case remoteHeaterControlEnabled = "remote_heater_control_enabled"
        case wiperBladeHeater = "wiper_blade_heater"
        case steeringWheelHeater = "steering_wheel_heater"
    }
    
    init(seatHeaterLeft: Int, fanStatus: Int, isFrontDefrosterOn: Bool, batteryHeaterNoPower: Bool, isClimateOn: Bool, isRearDefrosterOn: Bool, seatHeaterRearLeft: Int, minAvailTemp: Int, insideTemp: Double, climateKeeperMode: String, driverTempSetting: Int, outsideTemp: Int, passengerTempSetting: Int, seatHeaterRearCenter: Int, timestamp: Int, rightTempDirection: Int, leftTempDirection: Int, isPreconditioning: Bool, seatHeaterRearRight: Int, seatHeaterRight: Int, sideMirrorHeaters: Bool, smartPreconditioning: Bool, maxAvailTemp: Int, batteryHeater: Bool, isAutoConditioningOn: Bool, remoteHeaterControlEnabled: Bool, wiperBladeHeater: Bool, steeringWheelHeater: Bool) {
        self.seatHeaterLeft = seatHeaterLeft
        self.fanStatus = fanStatus
        self.isFrontDefrosterOn = isFrontDefrosterOn
        self.batteryHeaterNoPower = batteryHeaterNoPower
        self.isClimateOn = isClimateOn
        self.isRearDefrosterOn = isRearDefrosterOn
        self.seatHeaterRearLeft = seatHeaterRearLeft
        self.minAvailTemp = minAvailTemp
        self.insideTemp = insideTemp
        self.climateKeeperMode = climateKeeperMode
        self.driverTempSetting = driverTempSetting
        self.outsideTemp = outsideTemp
        self.passengerTempSetting = passengerTempSetting
        self.seatHeaterRearCenter = seatHeaterRearCenter
        self.timestamp = timestamp
        self.rightTempDirection = rightTempDirection
        self.leftTempDirection = leftTempDirection
        self.isPreconditioning = isPreconditioning
        self.seatHeaterRearRight = seatHeaterRearRight
        self.seatHeaterRight = seatHeaterRight
        self.sideMirrorHeaters = sideMirrorHeaters
        self.smartPreconditioning = smartPreconditioning
        self.maxAvailTemp = maxAvailTemp
        self.batteryHeater = batteryHeater
        self.isAutoConditioningOn = isAutoConditioningOn
        self.remoteHeaterControlEnabled = remoteHeaterControlEnabled
        self.wiperBladeHeater = wiperBladeHeater
        self.steeringWheelHeater = steeringWheelHeater
    }
}

// MARK: ClimateState convenience initializers and mutators

extension ClimateState {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ClimateState.self, from: data)
        self.init(seatHeaterLeft: me.seatHeaterLeft, fanStatus: me.fanStatus, isFrontDefrosterOn: me.isFrontDefrosterOn, batteryHeaterNoPower: me.batteryHeaterNoPower, isClimateOn: me.isClimateOn, isRearDefrosterOn: me.isRearDefrosterOn, seatHeaterRearLeft: me.seatHeaterRearLeft, minAvailTemp: me.minAvailTemp, insideTemp: me.insideTemp, climateKeeperMode: me.climateKeeperMode, driverTempSetting: me.driverTempSetting, outsideTemp: me.outsideTemp, passengerTempSetting: me.passengerTempSetting, seatHeaterRearCenter: me.seatHeaterRearCenter, timestamp: me.timestamp, rightTempDirection: me.rightTempDirection, leftTempDirection: me.leftTempDirection, isPreconditioning: me.isPreconditioning, seatHeaterRearRight: me.seatHeaterRearRight, seatHeaterRight: me.seatHeaterRight, sideMirrorHeaters: me.sideMirrorHeaters, smartPreconditioning: me.smartPreconditioning, maxAvailTemp: me.maxAvailTemp, batteryHeater: me.batteryHeater, isAutoConditioningOn: me.isAutoConditioningOn, remoteHeaterControlEnabled: me.remoteHeaterControlEnabled, wiperBladeHeater: me.wiperBladeHeater, steeringWheelHeater: me.steeringWheelHeater)
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
        seatHeaterLeft: Int? = nil,
        fanStatus: Int? = nil,
        isFrontDefrosterOn: Bool? = nil,
        batteryHeaterNoPower: Bool? = nil,
        isClimateOn: Bool? = nil,
        isRearDefrosterOn: Bool? = nil,
        seatHeaterRearLeft: Int? = nil,
        minAvailTemp: Int? = nil,
        insideTemp: Double? = nil,
        climateKeeperMode: String? = nil,
        driverTempSetting: Int? = nil,
        outsideTemp: Int? = nil,
        passengerTempSetting: Int? = nil,
        seatHeaterRearCenter: Int? = nil,
        timestamp: Int? = nil,
        rightTempDirection: Int? = nil,
        leftTempDirection: Int? = nil,
        isPreconditioning: Bool? = nil,
        seatHeaterRearRight: Int? = nil,
        seatHeaterRight: Int? = nil,
        sideMirrorHeaters: Bool? = nil,
        smartPreconditioning: Bool? = nil,
        maxAvailTemp: Int? = nil,
        batteryHeater: Bool? = nil,
        isAutoConditioningOn: Bool? = nil,
        remoteHeaterControlEnabled: Bool? = nil,
        wiperBladeHeater: Bool? = nil,
        steeringWheelHeater: Bool? = nil
        ) -> ClimateState {
        return ClimateState(
            seatHeaterLeft: seatHeaterLeft ?? self.seatHeaterLeft,
            fanStatus: fanStatus ?? self.fanStatus,
            isFrontDefrosterOn: isFrontDefrosterOn ?? self.isFrontDefrosterOn,
            batteryHeaterNoPower: batteryHeaterNoPower ?? self.batteryHeaterNoPower,
            isClimateOn: isClimateOn ?? self.isClimateOn,
            isRearDefrosterOn: isRearDefrosterOn ?? self.isRearDefrosterOn,
            seatHeaterRearLeft: seatHeaterRearLeft ?? self.seatHeaterRearLeft,
            minAvailTemp: minAvailTemp ?? self.minAvailTemp,
            insideTemp: insideTemp ?? self.insideTemp,
            climateKeeperMode: climateKeeperMode ?? self.climateKeeperMode,
            driverTempSetting: driverTempSetting ?? self.driverTempSetting,
            outsideTemp: outsideTemp ?? self.outsideTemp,
            passengerTempSetting: passengerTempSetting ?? self.passengerTempSetting,
            seatHeaterRearCenter: seatHeaterRearCenter ?? self.seatHeaterRearCenter,
            timestamp: timestamp ?? self.timestamp,
            rightTempDirection: rightTempDirection ?? self.rightTempDirection,
            leftTempDirection: leftTempDirection ?? self.leftTempDirection,
            isPreconditioning: isPreconditioning ?? self.isPreconditioning,
            seatHeaterRearRight: seatHeaterRearRight ?? self.seatHeaterRearRight,
            seatHeaterRight: seatHeaterRight ?? self.seatHeaterRight,
            sideMirrorHeaters: sideMirrorHeaters ?? self.sideMirrorHeaters,
            smartPreconditioning: smartPreconditioning ?? self.smartPreconditioning,
            maxAvailTemp: maxAvailTemp ?? self.maxAvailTemp,
            batteryHeater: batteryHeater ?? self.batteryHeater,
            isAutoConditioningOn: isAutoConditioningOn ?? self.isAutoConditioningOn,
            remoteHeaterControlEnabled: remoteHeaterControlEnabled ?? self.remoteHeaterControlEnabled,
            wiperBladeHeater: wiperBladeHeater ?? self.wiperBladeHeater,
            steeringWheelHeater: steeringWheelHeater ?? self.steeringWheelHeater
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
//   Alamofire.request(url).responseDriveState { response in
//     if let driveState = response.result.value {
//       ...
//     }
//   }

// MARK: - DriveState
class DriveState: Codable {
    let heading: Int
    let nativeType: String
    let gpsAsOf: Int
    let speed: JSONNull?
    let nativeLongitude: Double
    let timestamp: Int
    let longitude: Double
    let latitude: Double
    let nativeLocationSupported: Int
    let power: Int
    let shiftState: JSONNull?
    let nativeLatitude: Double
    
    enum CodingKeys: String, CodingKey {
        case heading = "heading"
        case nativeType = "native_type"
        case gpsAsOf = "gps_as_of"
        case speed = "speed"
        case nativeLongitude = "native_longitude"
        case timestamp = "timestamp"
        case longitude = "longitude"
        case latitude = "latitude"
        case nativeLocationSupported = "native_location_supported"
        case power = "power"
        case shiftState = "shift_state"
        case nativeLatitude = "native_latitude"
    }
    
    init(heading: Int, nativeType: String, gpsAsOf: Int, speed: JSONNull?, nativeLongitude: Double, timestamp: Int, longitude: Double, latitude: Double, nativeLocationSupported: Int, power: Int, shiftState: JSONNull?, nativeLatitude: Double) {
        self.heading = heading
        self.nativeType = nativeType
        self.gpsAsOf = gpsAsOf
        self.speed = speed
        self.nativeLongitude = nativeLongitude
        self.timestamp = timestamp
        self.longitude = longitude
        self.latitude = latitude
        self.nativeLocationSupported = nativeLocationSupported
        self.power = power
        self.shiftState = shiftState
        self.nativeLatitude = nativeLatitude
    }
}

// MARK: DriveState convenience initializers and mutators

extension DriveState {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DriveState.self, from: data)
        self.init(heading: me.heading, nativeType: me.nativeType, gpsAsOf: me.gpsAsOf, speed: me.speed, nativeLongitude: me.nativeLongitude, timestamp: me.timestamp, longitude: me.longitude, latitude: me.latitude, nativeLocationSupported: me.nativeLocationSupported, power: me.power, shiftState: me.shiftState, nativeLatitude: me.nativeLatitude)
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
        heading: Int? = nil,
        nativeType: String? = nil,
        gpsAsOf: Int? = nil,
        speed: JSONNull?? = nil,
        nativeLongitude: Double? = nil,
        timestamp: Int? = nil,
        longitude: Double? = nil,
        latitude: Double? = nil,
        nativeLocationSupported: Int? = nil,
        power: Int? = nil,
        shiftState: JSONNull?? = nil,
        nativeLatitude: Double? = nil
        ) -> DriveState {
        return DriveState(
            heading: heading ?? self.heading,
            nativeType: nativeType ?? self.nativeType,
            gpsAsOf: gpsAsOf ?? self.gpsAsOf,
            speed: speed ?? self.speed,
            nativeLongitude: nativeLongitude ?? self.nativeLongitude,
            timestamp: timestamp ?? self.timestamp,
            longitude: longitude ?? self.longitude,
            latitude: latitude ?? self.latitude,
            nativeLocationSupported: nativeLocationSupported ?? self.nativeLocationSupported,
            power: power ?? self.power,
            shiftState: shiftState ?? self.shiftState,
            nativeLatitude: nativeLatitude ?? self.nativeLatitude
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
//   Alamofire.request(url).responseGUISettings { response in
//     if let gUISettings = response.result.value {
//       ...
//     }
//   }

// MARK: - GUISettings
class GUISettings: Codable {
    let gui24_HourTime: Bool
    let guiDistanceUnits: String
    let guiChargeRateUnits: String
    let guiRangeDisplay: String
    let showRangeUnits: Bool
    let timestamp: Int
    let guiTemperatureUnits: String
    
    enum CodingKeys: String, CodingKey {
        case gui24_HourTime = "gui_24_hour_time"
        case guiDistanceUnits = "gui_distance_units"
        case guiChargeRateUnits = "gui_charge_rate_units"
        case guiRangeDisplay = "gui_range_display"
        case showRangeUnits = "show_range_units"
        case timestamp = "timestamp"
        case guiTemperatureUnits = "gui_temperature_units"
    }
    
    init(gui24_HourTime: Bool, guiDistanceUnits: String, guiChargeRateUnits: String, guiRangeDisplay: String, showRangeUnits: Bool, timestamp: Int, guiTemperatureUnits: String) {
        self.gui24_HourTime = gui24_HourTime
        self.guiDistanceUnits = guiDistanceUnits
        self.guiChargeRateUnits = guiChargeRateUnits
        self.guiRangeDisplay = guiRangeDisplay
        self.showRangeUnits = showRangeUnits
        self.timestamp = timestamp
        self.guiTemperatureUnits = guiTemperatureUnits
    }
}

// MARK: GUISettings convenience initializers and mutators

extension GUISettings {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(GUISettings.self, from: data)
        self.init(gui24_HourTime: me.gui24_HourTime, guiDistanceUnits: me.guiDistanceUnits, guiChargeRateUnits: me.guiChargeRateUnits, guiRangeDisplay: me.guiRangeDisplay, showRangeUnits: me.showRangeUnits, timestamp: me.timestamp, guiTemperatureUnits: me.guiTemperatureUnits)
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
        gui24_HourTime: Bool? = nil,
        guiDistanceUnits: String? = nil,
        guiChargeRateUnits: String? = nil,
        guiRangeDisplay: String? = nil,
        showRangeUnits: Bool? = nil,
        timestamp: Int? = nil,
        guiTemperatureUnits: String? = nil
        ) -> GUISettings {
        return GUISettings(
            gui24_HourTime: gui24_HourTime ?? self.gui24_HourTime,
            guiDistanceUnits: guiDistanceUnits ?? self.guiDistanceUnits,
            guiChargeRateUnits: guiChargeRateUnits ?? self.guiChargeRateUnits,
            guiRangeDisplay: guiRangeDisplay ?? self.guiRangeDisplay,
            showRangeUnits: showRangeUnits ?? self.showRangeUnits,
            timestamp: timestamp ?? self.timestamp,
            guiTemperatureUnits: guiTemperatureUnits ?? self.guiTemperatureUnits
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
//   Alamofire.request(url).responseVehicleConfig { response in
//     if let vehicleConfig = response.result.value {
//       ...
//     }
//   }

// MARK: - VehicleConfig
class VehicleConfig: Codable {
    let wheelType: String
    let sunRoofInstalled: Int
    let trimBadging: String
    let seatType: Int
    let rearSeatType: Int
    let useRangeBadging: Bool
    let canAcceptNavigationRequests: Bool
    let roofColor: String
    let perfConfig: String
    let rhd: Bool
    let hasLudicrousMode: Bool
    let carSpecialType: String
    let spoilerType: String
    let timestamp: Int
    let plg: Bool
    let motorizedChargePort: Bool
    let euVehicle: Bool
    let rearSeatHeaters: Int
    let thirdRowSeats: String
    let hasAirSuspension: Bool
    let canActuateTrunks: Bool
    let carType: String
    let chargePortType: String
    let exteriorColor: String
    
    enum CodingKeys: String, CodingKey {
        case wheelType = "wheel_type"
        case sunRoofInstalled = "sun_roof_installed"
        case trimBadging = "trim_badging"
        case seatType = "seat_type"
        case rearSeatType = "rear_seat_type"
        case useRangeBadging = "use_range_badging"
        case canAcceptNavigationRequests = "can_accept_navigation_requests"
        case roofColor = "roof_color"
        case perfConfig = "perf_config"
        case rhd = "rhd"
        case hasLudicrousMode = "has_ludicrous_mode"
        case carSpecialType = "car_special_type"
        case spoilerType = "spoiler_type"
        case timestamp = "timestamp"
        case plg = "plg"
        case motorizedChargePort = "motorized_charge_port"
        case euVehicle = "eu_vehicle"
        case rearSeatHeaters = "rear_seat_heaters"
        case thirdRowSeats = "third_row_seats"
        case hasAirSuspension = "has_air_suspension"
        case canActuateTrunks = "can_actuate_trunks"
        case carType = "car_type"
        case chargePortType = "charge_port_type"
        case exteriorColor = "exterior_color"
    }
    
    init(wheelType: String, sunRoofInstalled: Int, trimBadging: String, seatType: Int, rearSeatType: Int, useRangeBadging: Bool, canAcceptNavigationRequests: Bool, roofColor: String, perfConfig: String, rhd: Bool, hasLudicrousMode: Bool, carSpecialType: String, spoilerType: String, timestamp: Int, plg: Bool, motorizedChargePort: Bool, euVehicle: Bool, rearSeatHeaters: Int, thirdRowSeats: String, hasAirSuspension: Bool, canActuateTrunks: Bool, carType: String, chargePortType: String, exteriorColor: String) {
        self.wheelType = wheelType
        self.sunRoofInstalled = sunRoofInstalled
        self.trimBadging = trimBadging
        self.seatType = seatType
        self.rearSeatType = rearSeatType
        self.useRangeBadging = useRangeBadging
        self.canAcceptNavigationRequests = canAcceptNavigationRequests
        self.roofColor = roofColor
        self.perfConfig = perfConfig
        self.rhd = rhd
        self.hasLudicrousMode = hasLudicrousMode
        self.carSpecialType = carSpecialType
        self.spoilerType = spoilerType
        self.timestamp = timestamp
        self.plg = plg
        self.motorizedChargePort = motorizedChargePort
        self.euVehicle = euVehicle
        self.rearSeatHeaters = rearSeatHeaters
        self.thirdRowSeats = thirdRowSeats
        self.hasAirSuspension = hasAirSuspension
        self.canActuateTrunks = canActuateTrunks
        self.carType = carType
        self.chargePortType = chargePortType
        self.exteriorColor = exteriorColor
    }
}

// MARK: VehicleConfig convenience initializers and mutators

extension VehicleConfig {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(VehicleConfig.self, from: data)
        self.init(wheelType: me.wheelType, sunRoofInstalled: me.sunRoofInstalled, trimBadging: me.trimBadging, seatType: me.seatType, rearSeatType: me.rearSeatType, useRangeBadging: me.useRangeBadging, canAcceptNavigationRequests: me.canAcceptNavigationRequests, roofColor: me.roofColor, perfConfig: me.perfConfig, rhd: me.rhd, hasLudicrousMode: me.hasLudicrousMode, carSpecialType: me.carSpecialType, spoilerType: me.spoilerType, timestamp: me.timestamp, plg: me.plg, motorizedChargePort: me.motorizedChargePort, euVehicle: me.euVehicle, rearSeatHeaters: me.rearSeatHeaters, thirdRowSeats: me.thirdRowSeats, hasAirSuspension: me.hasAirSuspension, canActuateTrunks: me.canActuateTrunks, carType: me.carType, chargePortType: me.chargePortType, exteriorColor: me.exteriorColor)
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
        wheelType: String? = nil,
        sunRoofInstalled: Int? = nil,
        trimBadging: String? = nil,
        seatType: Int? = nil,
        rearSeatType: Int? = nil,
        useRangeBadging: Bool? = nil,
        canAcceptNavigationRequests: Bool? = nil,
        roofColor: String? = nil,
        perfConfig: String? = nil,
        rhd: Bool? = nil,
        hasLudicrousMode: Bool? = nil,
        carSpecialType: String? = nil,
        spoilerType: String? = nil,
        timestamp: Int? = nil,
        plg: Bool? = nil,
        motorizedChargePort: Bool? = nil,
        euVehicle: Bool? = nil,
        rearSeatHeaters: Int? = nil,
        thirdRowSeats: String? = nil,
        hasAirSuspension: Bool? = nil,
        canActuateTrunks: Bool? = nil,
        carType: String? = nil,
        chargePortType: String? = nil,
        exteriorColor: String? = nil
        ) -> VehicleConfig {
        return VehicleConfig(
            wheelType: wheelType ?? self.wheelType,
            sunRoofInstalled: sunRoofInstalled ?? self.sunRoofInstalled,
            trimBadging: trimBadging ?? self.trimBadging,
            seatType: seatType ?? self.seatType,
            rearSeatType: rearSeatType ?? self.rearSeatType,
            useRangeBadging: useRangeBadging ?? self.useRangeBadging,
            canAcceptNavigationRequests: canAcceptNavigationRequests ?? self.canAcceptNavigationRequests,
            roofColor: roofColor ?? self.roofColor,
            perfConfig: perfConfig ?? self.perfConfig,
            rhd: rhd ?? self.rhd,
            hasLudicrousMode: hasLudicrousMode ?? self.hasLudicrousMode,
            carSpecialType: carSpecialType ?? self.carSpecialType,
            spoilerType: spoilerType ?? self.spoilerType,
            timestamp: timestamp ?? self.timestamp,
            plg: plg ?? self.plg,
            motorizedChargePort: motorizedChargePort ?? self.motorizedChargePort,
            euVehicle: euVehicle ?? self.euVehicle,
            rearSeatHeaters: rearSeatHeaters ?? self.rearSeatHeaters,
            thirdRowSeats: thirdRowSeats ?? self.thirdRowSeats,
            hasAirSuspension: hasAirSuspension ?? self.hasAirSuspension,
            canActuateTrunks: canActuateTrunks ?? self.canActuateTrunks,
            carType: carType ?? self.carType,
            chargePortType: chargePortType ?? self.chargePortType,
            exteriorColor: exteriorColor ?? self.exteriorColor
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
//   Alamofire.request(url).responseVehicleState { response in
//     if let vehicleState = response.result.value {
//       ...
//     }
//   }

// MARK: - VehicleState
class VehicleState: Codable {
    let softwareUpdate: SoftwareUpdate
    let apiVersion: Int
    let locked: Bool
    let remoteStartEnabled: Bool
    let df: Int
    let notificationsSupported: Bool
    let pf: Int
    let autoparkStyle: String
    let lastAutoparkError: String
    let remoteStartSupported: Bool
    let valetPinNeeded: Bool
    let vehicleName: String
    let isUserPresent: Bool
    let ft: Int
    let parsedCalendarSupported: Bool
    let carVersion: String
    let dr: Int
    let remoteStart: Bool
    let rt: Int
    let sunRoofState: String
    let pr: Int
    let autoparkStateV2: String
    let calendarSupported: Bool
    let centerDisplayState: Int
    let sunRoofPercentOpen: Int
    let mediaState: MediaState
    let timestamp: Int
    let homelinkNearby: Bool
    let odometer: Double
    let valetMode: Bool
    let speedLimitMode: SpeedLimitMode
    
    enum CodingKeys: String, CodingKey {
        case softwareUpdate = "software_update"
        case apiVersion = "api_version"
        case locked = "locked"
        case remoteStartEnabled = "remote_start_enabled"
        case df = "df"
        case notificationsSupported = "notifications_supported"
        case pf = "pf"
        case autoparkStyle = "autopark_style"
        case lastAutoparkError = "last_autopark_error"
        case remoteStartSupported = "remote_start_supported"
        case valetPinNeeded = "valet_pin_needed"
        case vehicleName = "vehicle_name"
        case isUserPresent = "is_user_present"
        case ft = "ft"
        case parsedCalendarSupported = "parsed_calendar_supported"
        case carVersion = "car_version"
        case dr = "dr"
        case remoteStart = "remote_start"
        case rt = "rt"
        case sunRoofState = "sun_roof_state"
        case pr = "pr"
        case autoparkStateV2 = "autopark_state_v2"
        case calendarSupported = "calendar_supported"
        case centerDisplayState = "center_display_state"
        case sunRoofPercentOpen = "sun_roof_percent_open"
        case mediaState = "media_state"
        case timestamp = "timestamp"
        case homelinkNearby = "homelink_nearby"
        case odometer = "odometer"
        case valetMode = "valet_mode"
        case speedLimitMode = "speed_limit_mode"
    }
    
    init(softwareUpdate: SoftwareUpdate, apiVersion: Int, locked: Bool, remoteStartEnabled: Bool, df: Int, notificationsSupported: Bool, pf: Int, autoparkStyle: String, lastAutoparkError: String, remoteStartSupported: Bool, valetPinNeeded: Bool, vehicleName: String, isUserPresent: Bool, ft: Int, parsedCalendarSupported: Bool, carVersion: String, dr: Int, remoteStart: Bool, rt: Int, sunRoofState: String, pr: Int, autoparkStateV2: String, calendarSupported: Bool, centerDisplayState: Int, sunRoofPercentOpen: Int, mediaState: MediaState, timestamp: Int, homelinkNearby: Bool, odometer: Double, valetMode: Bool, speedLimitMode: SpeedLimitMode) {
        self.softwareUpdate = softwareUpdate
        self.apiVersion = apiVersion
        self.locked = locked
        self.remoteStartEnabled = remoteStartEnabled
        self.df = df
        self.notificationsSupported = notificationsSupported
        self.pf = pf
        self.autoparkStyle = autoparkStyle
        self.lastAutoparkError = lastAutoparkError
        self.remoteStartSupported = remoteStartSupported
        self.valetPinNeeded = valetPinNeeded
        self.vehicleName = vehicleName
        self.isUserPresent = isUserPresent
        self.ft = ft
        self.parsedCalendarSupported = parsedCalendarSupported
        self.carVersion = carVersion
        self.dr = dr
        self.remoteStart = remoteStart
        self.rt = rt
        self.sunRoofState = sunRoofState
        self.pr = pr
        self.autoparkStateV2 = autoparkStateV2
        self.calendarSupported = calendarSupported
        self.centerDisplayState = centerDisplayState
        self.sunRoofPercentOpen = sunRoofPercentOpen
        self.mediaState = mediaState
        self.timestamp = timestamp
        self.homelinkNearby = homelinkNearby
        self.odometer = odometer
        self.valetMode = valetMode
        self.speedLimitMode = speedLimitMode
    }
}

// MARK: VehicleState convenience initializers and mutators

extension VehicleState {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(VehicleState.self, from: data)
        self.init(softwareUpdate: me.softwareUpdate, apiVersion: me.apiVersion, locked: me.locked, remoteStartEnabled: me.remoteStartEnabled, df: me.df, notificationsSupported: me.notificationsSupported, pf: me.pf, autoparkStyle: me.autoparkStyle, lastAutoparkError: me.lastAutoparkError, remoteStartSupported: me.remoteStartSupported, valetPinNeeded: me.valetPinNeeded, vehicleName: me.vehicleName, isUserPresent: me.isUserPresent, ft: me.ft, parsedCalendarSupported: me.parsedCalendarSupported, carVersion: me.carVersion, dr: me.dr, remoteStart: me.remoteStart, rt: me.rt, sunRoofState: me.sunRoofState, pr: me.pr, autoparkStateV2: me.autoparkStateV2, calendarSupported: me.calendarSupported, centerDisplayState: me.centerDisplayState, sunRoofPercentOpen: me.sunRoofPercentOpen, mediaState: me.mediaState, timestamp: me.timestamp, homelinkNearby: me.homelinkNearby, odometer: me.odometer, valetMode: me.valetMode, speedLimitMode: me.speedLimitMode)
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
        softwareUpdate: SoftwareUpdate? = nil,
        apiVersion: Int? = nil,
        locked: Bool? = nil,
        remoteStartEnabled: Bool? = nil,
        df: Int? = nil,
        notificationsSupported: Bool? = nil,
        pf: Int? = nil,
        autoparkStyle: String? = nil,
        lastAutoparkError: String? = nil,
        remoteStartSupported: Bool? = nil,
        valetPinNeeded: Bool? = nil,
        vehicleName: String? = nil,
        isUserPresent: Bool? = nil,
        ft: Int? = nil,
        parsedCalendarSupported: Bool? = nil,
        carVersion: String? = nil,
        dr: Int? = nil,
        remoteStart: Bool? = nil,
        rt: Int? = nil,
        sunRoofState: String? = nil,
        pr: Int? = nil,
        autoparkStateV2: String? = nil,
        calendarSupported: Bool? = nil,
        centerDisplayState: Int? = nil,
        sunRoofPercentOpen: Int? = nil,
        mediaState: MediaState? = nil,
        timestamp: Int? = nil,
        homelinkNearby: Bool? = nil,
        odometer: Double? = nil,
        valetMode: Bool? = nil,
        speedLimitMode: SpeedLimitMode? = nil
        ) -> VehicleState {
        return VehicleState(
            softwareUpdate: softwareUpdate ?? self.softwareUpdate,
            apiVersion: apiVersion ?? self.apiVersion,
            locked: locked ?? self.locked,
            remoteStartEnabled: remoteStartEnabled ?? self.remoteStartEnabled,
            df: df ?? self.df,
            notificationsSupported: notificationsSupported ?? self.notificationsSupported,
            pf: pf ?? self.pf,
            autoparkStyle: autoparkStyle ?? self.autoparkStyle,
            lastAutoparkError: lastAutoparkError ?? self.lastAutoparkError,
            remoteStartSupported: remoteStartSupported ?? self.remoteStartSupported,
            valetPinNeeded: valetPinNeeded ?? self.valetPinNeeded,
            vehicleName: vehicleName ?? self.vehicleName,
            isUserPresent: isUserPresent ?? self.isUserPresent,
            ft: ft ?? self.ft,
            parsedCalendarSupported: parsedCalendarSupported ?? self.parsedCalendarSupported,
            carVersion: carVersion ?? self.carVersion,
            dr: dr ?? self.dr,
            remoteStart: remoteStart ?? self.remoteStart,
            rt: rt ?? self.rt,
            sunRoofState: sunRoofState ?? self.sunRoofState,
            pr: pr ?? self.pr,
            autoparkStateV2: autoparkStateV2 ?? self.autoparkStateV2,
            calendarSupported: calendarSupported ?? self.calendarSupported,
            centerDisplayState: centerDisplayState ?? self.centerDisplayState,
            sunRoofPercentOpen: sunRoofPercentOpen ?? self.sunRoofPercentOpen,
            mediaState: mediaState ?? self.mediaState,
            timestamp: timestamp ?? self.timestamp,
            homelinkNearby: homelinkNearby ?? self.homelinkNearby,
            odometer: odometer ?? self.odometer,
            valetMode: valetMode ?? self.valetMode,
            speedLimitMode: speedLimitMode ?? self.speedLimitMode
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
//   Alamofire.request(url).responseMediaState { response in
//     if let mediaState = response.result.value {
//       ...
//     }
//   }

// MARK: - MediaState
class MediaState: Codable {
    let remoteControlEnabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case remoteControlEnabled = "remote_control_enabled"
    }
    
    init(remoteControlEnabled: Bool) {
        self.remoteControlEnabled = remoteControlEnabled
    }
}

// MARK: MediaState convenience initializers and mutators

extension MediaState {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MediaState.self, from: data)
        self.init(remoteControlEnabled: me.remoteControlEnabled)
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
        remoteControlEnabled: Bool? = nil
        ) -> MediaState {
        return MediaState(
            remoteControlEnabled: remoteControlEnabled ?? self.remoteControlEnabled
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
//   Alamofire.request(url).responseSoftwareUpdate { response in
//     if let softwareUpdate = response.result.value {
//       ...
//     }
//   }

// MARK: - SoftwareUpdate
class SoftwareUpdate: Codable {
    let expectedDurationSEC: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case expectedDurationSEC = "expected_duration_sec"
        case status = "status"
    }
    
    init(expectedDurationSEC: Int, status: String) {
        self.expectedDurationSEC = expectedDurationSEC
        self.status = status
    }
}

// MARK: SoftwareUpdate convenience initializers and mutators

extension SoftwareUpdate {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SoftwareUpdate.self, from: data)
        self.init(expectedDurationSEC: me.expectedDurationSEC, status: me.status)
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
        expectedDurationSEC: Int? = nil,
        status: String? = nil
        ) -> SoftwareUpdate {
        return SoftwareUpdate(
            expectedDurationSEC: expectedDurationSEC ?? self.expectedDurationSEC,
            status: status ?? self.status
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
//   Alamofire.request(url).responseSpeedLimitMode { response in
//     if let speedLimitMode = response.result.value {
//       ...
//     }
//   }

// MARK: - SpeedLimitMode
class SpeedLimitMode: Codable {
    let currentLimitMph: Int
    let pinCodeSet: Bool
    let active: Bool
    let maxLimitMph: Int
    let minLimitMph: Int
    
    enum CodingKeys: String, CodingKey {
        case currentLimitMph = "current_limit_mph"
        case pinCodeSet = "pin_code_set"
        case active = "active"
        case maxLimitMph = "max_limit_mph"
        case minLimitMph = "min_limit_mph"
    }
    
    init(currentLimitMph: Int, pinCodeSet: Bool, active: Bool, maxLimitMph: Int, minLimitMph: Int) {
        self.currentLimitMph = currentLimitMph
        self.pinCodeSet = pinCodeSet
        self.active = active
        self.maxLimitMph = maxLimitMph
        self.minLimitMph = minLimitMph
    }
}

// MARK: SpeedLimitMode convenience initializers and mutators

extension SpeedLimitMode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SpeedLimitMode.self, from: data)
        self.init(currentLimitMph: me.currentLimitMph, pinCodeSet: me.pinCodeSet, active: me.active, maxLimitMph: me.maxLimitMph, minLimitMph: me.minLimitMph)
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
        currentLimitMph: Int? = nil,
        pinCodeSet: Bool? = nil,
        active: Bool? = nil,
        maxLimitMph: Int? = nil,
        minLimitMph: Int? = nil
        ) -> SpeedLimitMode {
        return SpeedLimitMode(
            currentLimitMph: currentLimitMph ?? self.currentLimitMph,
            pinCodeSet: pinCodeSet ?? self.pinCodeSet,
            active: active ?? self.active,
            maxLimitMph: maxLimitMph ?? self.maxLimitMph,
            minLimitMph: minLimitMph ?? self.minLimitMph
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
    func responseVehicleData(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<VehicleData>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

