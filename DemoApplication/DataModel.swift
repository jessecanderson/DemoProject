//
//  DataModel.swift
//  DemoApplication
//
//  Created by Jesse Anderson on 9/2/19.
//  Copyright © 2019 Jesse Anderson. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aPIResponse = try? newJSONDecoder().decode(APIResponse.self, from: jsonData)

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let status: Int
    let message: String
    let data: [[Datum]]

}

// MARK: - Datum
struct Datum: Codable {
    let nid, name, appName, networkName: String
    let registrationFields, nType: String
    let img: String
    let latitude, longitude, address: String
    let configuration: Configuration
    
    enum CodingKeys: String, CodingKey {
        case nid, name
        case appName = "app_name"
        case networkName = "network_name"
        case registrationFields = "registration_fields"
        case nType = "n_type"
        case img, latitude, longitude, address, configuration
    }
}

// MARK: - Configuration
struct Configuration: Codable {
    let nid, primaryColor, secondaryColor: String
    let homescreenImage, loginImage: String
    let icon: String
    let homescreenVideo: String
    let menuConfig: [MenuConfig]
    let sso: String?
    
    enum CodingKeys: String, CodingKey {
        case nid
        case primaryColor = "primary_color"
        case secondaryColor = "secondary_color"
        case homescreenImage = "homescreen_image"
        case loginImage = "login_image"
        case icon
        case homescreenVideo = "homescreen_video"
        case menuConfig = "menu_config"
        case sso
    }
}

// MARK: - MenuConfig
struct MenuConfig: Codable {
    let moduleName, displayName, moduleIdentifier: String
    let imagepath: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case moduleName = "module_name"
        case displayName = "display_name"
        case moduleIdentifier = "module_identifier"
        case imagepath, url
    }
}


