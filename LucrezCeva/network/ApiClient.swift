//
//  ApiClient.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 31/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class ApiClient {
    static var shared = ApiClient()
    
    private init() {}
    
    public func login(username:String, password: String, completion: @escaping(_ loginResponse: LoginResponse, _ success: Bool)->()) {
        let body = [
            "username" : username,
            "password" : password,
            "grant_type" : "password"
        ]
        let url = ApiEndpoints.LOGIN.getUrl(pathParams: nil)
        Alamofire.request(url,
                          method: .post,
                          parameters: body,
                          encoding: URLEncoding.httpBody,
                          headers: ConstantApi.LOGIN_AUTH_HEADER)
            .validate().responseJSON { (response) in
                Logger.log(response)
                if response.error != nil {
                    completion(LoginResponse.init(),false)
                } else {
                    let result = LoginResponse.init(response.value as! [String : Any])
                    guard let token = result.accessToken else {return}
                    guard let refreshToken = result.refreshToken else {return}
                    PersistancyManager.setToken(token: token)
                    PersistancyManager.setRefreshToken(refreshToken: refreshToken)
                    completion(result,true)
                }
        }
    }
    
    public func register(_ fullName: String, _ email: String, _ password: String, _ confirmPassword: String, completion: @escaping(_ success: Bool)->()) {
        let body = [
            "email" : email,
            "name" : fullName,
            "password" : password,
            "passwordAgain" : confirmPassword
        ]
        let url = ApiEndpoints.REGISTER.getUrl(pathParams: nil)
        Alamofire.request(url,
                          method: ApiEndpoints.REGISTER.method,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: ConstantApi.BASE_HEADER)
            .validate().responseJSON { (response) in
                Logger.log("CREATE_ACCOUNT", response)
                if response.error != nil {
                    completion(false)
                } else {
                    self.login(username: email, password: password, completion: { (response, success) in
                        if success {
                            completion(true)
                        } else {
                            Logger.log("Error from LOGIN in CREATE ACCOUNT")
                            completion(false)
                        }
                    })
                }
        }
    }
    
    func refreshToken(completion: @escaping(_ success: Bool)->()) {
        let body = [
            "grant_type" : "refresh_token",
            "refresh_token" : PersistancyManager.getRefreshToken()
        ]
        let url = ApiEndpoints.REFRESH_TOKEN.getUrl(pathParams: nil)
        Alamofire.request(url,
                          method: .post,
                          parameters: body,
                          encoding: URLEncoding.httpBody,
                          headers: ConstantApi.LOGIN_AUTH_HEADER)
            .validate().responseJSON { (response) in
                if response.error != nil {
                    completion(false)
                } else {
                    let result = LoginResponse.init(response.value as! [String : Any])
                    guard let token = result.accessToken else {return}
                    guard let refreshToken = result.refreshToken else {return}
                    PersistancyManager.setToken(token: token)
                    PersistancyManager.setRefreshToken(refreshToken: refreshToken)
                    completion(true)
                }
        }
    }
    
    func updateAccountDetails(_ birthDay: String, _ location: String, _ gender: String, _ phone: String, _ tags: [String], completion: @escaping(_ success: Bool)->()) {
        let body = [
            "birthday" : birthDay,
            "location" : location,
            "gender" : gender,
            "phone" : phone,
            "abilities" : "",
            "tags" : tags
            ] as [String : Any]
        let url = ApiEndpoints.UPDATE_ACCOUNT_DETAILS.getUrl(pathParams: nil)
        Alamofire.request(url,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: ConstantApi.UPDATE_ACCOUNT_HEADER)
            .validate().responseJSON { (response) in
                Logger.log(response)
                if response.error != nil {
                    self.refreshToken(completion: { (success) in
                        // MARK: - Handeled error if refresh token is expired and called refreshToken method
                        if success {
                            // MARK: - Called again updateAccountDetails with the refreshed token
                            self.updateAccountDetails(birthDay, location, gender, phone, tags, completion: { (success) in
                                if success {
                                    // MARK: - i don't know what it will happen if it will get here
                                    completion(true)
                                } else {
                                    // MARK: - neither here
                                    completion(false)
                                }
                            })
                        }
                    })
                } else {
                    completion(true)
                }
        }
        
    }
    
}
