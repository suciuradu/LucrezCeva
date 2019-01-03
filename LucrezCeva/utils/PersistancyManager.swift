//
//  PersistancyManager.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 31/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation

class PersistancyManager {
    
    private static let
    TOKEN = "token",
    REFRESH_TOKEN = "refresh_token"
    
    public static func setToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: TOKEN)
        defaults.synchronize()
    }
    
    public static func setRefreshToken(refreshToken: String) {
        let defaults = UserDefaults.standard
        defaults.set(refreshToken, forKey: REFRESH_TOKEN)
        defaults.synchronize()
    }
    
    public static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: TOKEN)
    }
    
    public static func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: REFRESH_TOKEN)
    }
    
    
    
}
