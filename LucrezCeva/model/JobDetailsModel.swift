//
//  JobDetailsModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 18/01/2019.
//  Copyright © 2019 LucrezCeva. All rights reserved.
//

import Foundation

class JobDetailsModel {
   
    var id: Int?
    var daysSincePosted: Int?
    var salary: Float?
    var title: String?
    var description: String?
    var typeOfJob: String?
    var location: String?
    var profilePicUrl: String?
    var userName: String?
    var bookmarked: Bool?
    var tags = [String]()
    
    init() {}

    init(_ data: [String:Any]) {
        if let id = data[ApiContract.JobDetails.ID] as? Int {
            self.id = id
        }
        if let daysSincePosted = data[ApiContract.JobDetails.DAYS_SINCE_POSTED] as? Int {
            self.daysSincePosted = daysSincePosted
        }
        if let salary = data[ApiContract.JobDetails.SALARY] as? Float {
            self.salary = salary
        }
        if let title = data[ApiContract.JobDetails.TITLE] as? String {
            self.title = title
        }
        if let description = data[ApiContract.JobDetails.DESCRIPTION] as? String {
            self.description = description
        }
        if let typeOfJob = data[ApiContract.JobDetails.TYPE] as? String {
            self.typeOfJob = typeOfJob
        }
        if let location = data[ApiContract.JobDetails.LOCATION] as? String {
            self.location = location
        }
        if let profilePicUrl = data[ApiContract.JobDetails.AVATAR_PATH] as? String {
            self.profilePicUrl = profilePicUrl
        }
        if let userName = data[ApiContract.JobDetails.USERNAME] as? String {
            self.userName = userName
        }
        if let bookmarked = data[ApiContract.JobDetails.BOOKMARKED] as? Bool {
            self.bookmarked = bookmarked
        }
        if let tags = data[ApiContract.JobDetails.TAGS] as? [String] {
            self.tags.append(contentsOf: tags)
        }
        
    }
    
    
}
