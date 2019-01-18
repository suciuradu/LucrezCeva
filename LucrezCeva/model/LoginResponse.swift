//
//  LoginResponse.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 31/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation

class LoginResponse {
    var accessToken: String?
    var tokenType: String?
    var refreshToken: String?
    
    init() {}
    
    init(_ data: [String:Any]) {
        if let accessToken = data[ApiContract.LoginResponse.ACCESS_TOKEN] as? String {
            self.accessToken = accessToken
        }
        if let tokenType = data[ApiContract.LoginResponse.TOKEN_TYPE] as? String {
            self.tokenType = tokenType
        }
        if let refreshToken = data[ApiContract.LoginResponse.REFRESH_TOKEN] as? String {
            self.refreshToken = refreshToken
        }
    }
}

