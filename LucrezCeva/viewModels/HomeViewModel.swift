//
//  HomeViewModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 16/01/2019.
//  Copyright © 2019 LucrezCeva. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    let jobArray = DynamicValue<[JobItem]>([])
    let bookmarkedArray = DynamicValue<[JobItem]>([])
    let recomandedArray = DynamicValue<[JobItem]>([])
    let successAddBookmark = DynamicValue<Bool>(false)
    let successDeleteBookmark = DynamicValue<Bool>(false)

    
    override init() {
        super.init()
        getBookmarks()
        getJobs([], [], "")
    }
    
    func getJobs(_ locations: [String], _ types: [String], _ word: String) {
        ApiClient.shared.getJobs(locations, types, word) { (response) in
            if !response.isEmpty {
                self.jobArray.value.removeAll()
                self.jobArray.value.append(contentsOf: JobItem.parseList(response))
            } else {
                self.jobArray.value = []
            }
        }
    }
    
    func getRecomanded(_ locations: [String], _ types: [String], _ word: String) {
        ApiClient.shared.getRecomanded(locations, types, word) { (response) in
            if !response.isEmpty {
                self.recomandedArray.value.removeAll()
                self.recomandedArray.value.append(contentsOf: JobItem.parseList(response))
            } else {
                self.recomandedArray.value = []
            }
        }
    }
    
    func getBookmarks() {
        ApiClient.shared.getBookmarks { (response) in
            if !response.isEmpty {
                self.bookmarkedArray.value.removeAll()
                self.bookmarkedArray.value.append(contentsOf: JobItem.parseList(response))
            } else {
                self.bookmarkedArray.value = []
            }
        }
    }
    
    func addBookmark(id: Int) {
        ApiClient.shared.addBookmark(with: id) { (success) in
            if success {
                self.successAddBookmark.value = true
            } else {
                self.successAddBookmark.value = false
            }
        }
    }
    
    func deleteBookmark(id: Int) {
        ApiClient.shared.deleteBookmark(with: id) { (success) in
            if success {
                self.successDeleteBookmark.value = true
            } else {
                self.successDeleteBookmark.value = false
            }
        }
    }
 }
