//
//  ApiClient.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 31/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import Alamofire

struct ApiContract {
    struct Endpoints {
        public static let
        BASE_URL = "https://lucrez-ceva-test.herokuapp.com",
        LOGIN = "/oauth/token",
        UNAUTHENTICATED = "/unauthenticated",
        AUTHENTICATED = "/authenticated",
        REGISTER = "/unauthenticated/register",
        UPDATE_USER = "/authenticated/update-account-details",
        REFRESH_TOKEN = "/oauth/token",
        UPDATE_ACCOUNT_DETAILS = "/authenticated/update-account-details"
    }
    
    struct LoginResponse {
        public static let
        ACCESS_TOKEN = "access_token",
        TOKEN_TYPE = "token_type",
        REFRESH_TOKEN = "refresh_token"
    }
}

struct ConstantApi {

    public static let
    LOGIN_AUTH_HEADER: HTTPHeaders = [
        "Authorization" : "Basic SU9TLWNsaWVudDpwYXNzd29yZA==",
        "Content-Type" : "application/x-www-form-urlencoded"
    ],
    BASE_HEADER: HTTPHeaders = [
        "Content-Type" : "application/json"
    ],
    UPDATE_ACCOUNT_HEADER: HTTPHeaders = [
        "Authorization" : "Bearer \(PersistancyManager.getToken() ?? "token")",
        "Content-Type" : "application/json"
    ]
    
    
}
