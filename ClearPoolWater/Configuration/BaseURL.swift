//
//  BaseURL.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

struct Configuration {
    static let baseURL: String = {
        // TODO: Add config .plist file and use different configs for Debug, Release, and Test environments.
        //        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
        //              let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
        //              let url = dict["BaseURL"] as? String else {
        //            fatalError("Base URL not found in Config.plist")
        //        }
        return "https://127.0.0.1:4343"
    }()
}
