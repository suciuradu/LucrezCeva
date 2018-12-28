//
//  HomeViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit
import TagListView

enum JobStates {
    case all
    case recomanded
    case saved
    case searched
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var selectedTabView: UIView!
    @IBOutlet weak var noutatiButton: UIButton!
    @IBOutlet weak var recomandateButton: UIButton!
    @IBOutlet weak var salvateButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        hideKeyboardWhenTappedAround()
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        searchBar.setPlaceholderTextColor(color: UIColor.white.withAlphaComponent(0.5))
        searchBar.setTextColor(color: UIColor.white)
        searchBar.setImage(#imageLiteral(resourceName: "clear-button-white"), for: .clear, state: .normal)
        searchBar.setImage(#imageLiteral(resourceName: "search-white"), for: .search, state: .normal)
        topView.applyGradient(withColours: [Colors.colorTopBlue,Colors.colorMediumTurqoise], gradientOrientation: .vertical)
        tagList.addTags(["Cluj-Napoca","Ocazional"])
        self.selectedTabView.center.x = self.salvateButton.center.x
        selectedTabView.translatesAutoresizingMaskIntoConstraints = false
        self.selectedTabView.centerXAnchor.constraint(equalTo: noutatiButton.centerXAnchor).isActive = true
    }
    
    private func animateTabColorChange(sender: UIButton) {
        noutatiButton.isSelected = false
        recomandateButton.isSelected = false
        salvateButton.isSelected = false
        UIView.animate(withDuration: 0.3) {
            sender.isSelected = true
            self.selectedTabView.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
        }
    }
    
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = jobsTableView.dequeueReusableCell(withIdentifier: "jobsCell") as? JobsCell else {return UITableViewCell()}
        return cell
    }
}

class JobsCell: UITableViewCell {
    
}
