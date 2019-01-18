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
        UPDATE_ACCOUNT_DETAILS = "/authenticated/update-account-details",
        GET_JOBS = "/unauthenticated/getAll",
        GET_RECOMANDED = "/authenticated/getAll",
        ADD_BOOKMARK = "/authenticated/bookmark",
        DELETE_BOOKMARK = "/authenticated/remove_bookmark",
        GET_BOOKMARKS = "/authenticated/getBookmarks",
        GET_JOB_DETAILS = "/unauthenticated/getJob",
        APPLY_TO_JOB = "/authenticated/apply",
        ADD_JOB = "/authenticated/add"
        
    }
    
    struct LoginResponse {
        public static let
        ACCESS_TOKEN = "access_token",
        TOKEN_TYPE = "token_type",
        REFRESH_TOKEN = "refresh_token"
    }
    
    struct JobItem {
        public static let
        ID = "id",
        TYPE = "type",
        DAYS_SINCE_POSTED = "daysSincePosted",
        LOCATION = "location",
        TITLE = "title",
        BOOKMARKED = "bookmarked"
    }
    
    struct  JobDetails {
        public static let
        ID = "id",
        TYPE = "type",
        DAYS_SINCE_POSTED = "daysSincePosted",
        LOCATION = "location",
        TITLE = "title",
        BOOKMARKED = "bookmarked",
        DESCRIPTION = "description",
        TAGS = "tags",
        AVATAR_PATH = "avatarPath",
        USERNAME = "username",
        SALARY = "salary"
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
    ],
    AUTHENTICATED_HEADER: HTTPHeaders = [
        "Authorization" : "Bearer \(PersistancyManager.getToken() ?? "token")"
    ]
    
    
}
