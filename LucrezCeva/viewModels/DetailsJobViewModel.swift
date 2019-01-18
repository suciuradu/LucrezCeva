//
//  DetailsJobViewModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 18/01/2019.
//  Copyright © 2019 LucrezCeva. All rights reserved.
//

import Foundation

class DetailsJobViewModel: NSObject {
    
    let jobDetails = DynamicValue<JobDetailsModel?>(nil)
    let applyToJobSuccess = DynamicValue<Bool>(false)
    
    init(_ id: Int) {
        super.init()
        getJobDetails(id: id)
    }
    
    func getJobDetails(id: Int) {
        ApiClient.shared.getJobDetails(id: id) { (response) in
            if !response.isEmpty {
                self.jobDetails.value = JobDetailsModel.init(response)
            } else {
                self.jobDetails.value = JobDetailsModel()
            }
        }
    }
    
    func applyToJob(id: Int) {
        ApiClient.shared.applyToJob(id: id) { (success) in
            self.applyToJobSuccess.value = success
        }
    }
}
