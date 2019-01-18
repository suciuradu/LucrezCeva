//
//  ApiEndpoints.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 31/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ApiEndpoints {
    
    public static let
    LOGIN = ApiEndpoints.init(.post, ApiContract.Endpoints.LOGIN),
    REGISTER = ApiEndpoints.init(.post, ApiContract.Endpoints.REGISTER),
    UPDATE_USER = ApiEndpoints.init(.post, ApiContract.Endpoints.UPDATE_USER),
    REFRESH_TOKEN = ApiEndpoints.init(.post, ApiContract.Endpoints.REFRESH_TOKEN),
    UPDATE_ACCOUNT_DETAILS = ApiEndpoints.init(.post, ApiContract.Endpoints.UPDATE_ACCOUNT_DETAILS),
    GET_JOBS = ApiEndpoints.init(.post, ApiContract.Endpoints.GET_JOBS),
    GET_BOOKMARKS = ApiEndpoints.init(.post, ApiContract.Endpoints.GET_BOOKMARKS),
    ADD_BOOKMARK = ApiEndpoints.init(.post, ApiContract.Endpoints.ADD_BOOKMARK),
    DELETE_BOOKMARK = ApiEndpoints.init(.post, ApiContract.Endpoints.DELETE_BOOKMARK),
    GET_RECOMANDED = ApiEndpoints.init(.post, ApiContract.Endpoints.GET_RECOMANDED),
    GET_JOB_DETAILS = ApiEndpoints.init(.get, ApiContract.Endpoints.GET_JOB_DETAILS),
    APPLY_TO_JOB = ApiEndpoints.init(.post, ApiContract.Endpoints.APPLY_TO_JOB),
    ADD_JOB = ApiEndpoints.init(.post, ApiContract.Endpoints.ADD_JOB)

    
    public let path:String!
    public let method:HTTPMethod!
    
    private init(_ method:HTTPMethod, _ path:String) {
        self.method = method
        self.path = path
    }
    
    public func getUrl(pathParams:[String]?) -> String {
        var url = ApiContract.Endpoints.BASE_URL + self.path
        if pathParams != nil {
            for param in pathParams! {
                url.append("/" + param)
            }
        }
        return url
    }
   
    
    
}
