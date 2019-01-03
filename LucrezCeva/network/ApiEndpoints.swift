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
    UPDATE_ACCOUNT_DETAILS = ApiEndpoints.init(.post, ApiContract.Endpoints.UPDATE_ACCOUNT_DETAILS)
    
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
