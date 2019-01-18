//
//  JobItem.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 16/01/2019.
//  Copyright © 2019 LucrezCeva. All rights reserved.
//

import Foundation

class JobItem {
    
    var id: Int?
    var type: String?
    var daysSincePosted: Int?
    var location: String?
    var title: String?
    var bookmarked: Bool?
    
    init() {}
    
    init(_ data: [String:Any]) {
        if let id = data[ApiContract.JobItem.ID] as? Int {
            self.id = id
        }
        if let type = data[ApiContract.JobItem.TYPE] as? String {
            self.type = type
        }
        if let daysSincePosted = data[ApiContract.JobItem.DAYS_SINCE_POSTED] as? Int {
            self.daysSincePosted = daysSincePosted
        }
        if let location = data[ApiContract.JobItem.LOCATION] as? String {
            self.location = location
        }
        if let title = data[ApiContract.JobItem.TITLE] as? String {
            self.title = title
        }
        if let bookmarked = data[ApiContract.JobItem.BOOKMARKED] as? Bool {
            self.bookmarked = bookmarked
        }
    }
    
    static func parseList(_ data:[[String:Any]]) -> [JobItem] {
        var result = [JobItem]()
        for entry in data {
            result.append(JobItem.init(entry))
        }
        return result
    }
    
}
