//
//  DetailsJobViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 18/01/2019.
//  Copyright © 2019 LucrezCeva. All rights reserved.
//

import UIKit
import TagListView

class DetailsJobViewController: BaseViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var jobPriceLabel: UILabel!
    @IBOutlet weak var jobLocationLabel: UILabel!
    @IBOutlet weak var jobTagList: TagListView!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    
    var viewModel: DetailsJobViewModel!
    var jobData: JobDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
    }
    
    private func initUI() {
        
    }
    
    private func initViewModel() {
        viewModel.jobDetails.bind { (job) in
            self.jobData = job
            UIView.animate(withDuration: 0.2, animations: {
                self.jobTitleLabel.text = self.jobData?.title ?? "Titlu"
                self.jobTypeLabel.text = self.jobData?.typeOfJob ?? "Saptamanal"
                self.jobDescriptionLabel.text = self.jobData?.description ?? "Descriere"
                self.jobLocationLabel.text = self.jobData?.location ?? "Locatie"
                self.jobPriceLabel.text = "\(Float(self.jobData?.salary ?? 100.0)) RON"
                self.userNameLabel.text = self.jobData?.userName ?? "Username"
                if let url = self.jobData?.profilePicUrl {
                    self.userProfileImage.fromUrl(url)
                }
                if let tags = self.jobData?.tags {
                    self.jobTagList.addTags(tags)
                }
                self.view.layoutIfNeeded()
            })
        }
        viewModel.applyToJobSuccess.bind { (success) in
            if success {
                self.showSuccessMessage("Ați aplicat la acest job!")
            } else {
                self.showErrorMessage("Autentifică-te pentru a aplica la acest job!")
            }
        }
    }
    
    @IBAction func applyToJobTapped(_ sender: Any) {
        viewModel.applyToJob(id: jobData?.id ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}
