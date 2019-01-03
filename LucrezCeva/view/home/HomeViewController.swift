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
    @IBOutlet weak var leadingSelectedTabConstraint: NSLayoutConstraint!
    
    var count = 10
    var selectedTabIndex = 0
    
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
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.jobsTableView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.jobsTableView.addGestureRecognizer(swipeRight)
        noutatiButton.isSelected = true
       
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            count = 1
            jobsTableView.reloadData()
            switch selectedTabIndex {
            case 1:
                animateTabColorChange(sender: noutatiButton)
            case 2:
                animateTabColorChange(sender: recomandateButton)
            default:
                break
            }
        } else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            count = 2
            jobsTableView.reloadData()
            switch selectedTabIndex {
            case 0:
                animateTabColorChange(sender: recomandateButton)
            case 1:
                animateTabColorChange(sender: salvateButton)
            default:
                break
            }
        }
    }
    
    private func animateTabColorChange(sender: UIButton) {
        noutatiButton.isSelected = false
        recomandateButton.isSelected = false
        salvateButton.isSelected = false
        UIView.animate(withDuration: 0.3) {
            sender.isSelected = true
            self.selectedTabIndex = sender.tag
            Logger.log("tag",sender.tag)
            self.leadingSelectedTabConstraint.constant = sender.frame.minX
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func noutatiTapped(_ sender: UIButton) {
        animateTabColorChange(sender: sender)
    }
    
    @IBAction func recomandateTapped(_ sender: UIButton) {
        animateTabColorChange(sender: sender)
    }
    
    @IBAction func salvateTapped(_ sender: UIButton) {
        animateTabColorChange(sender: sender)
        Logger.log("tag salv",sender.tag)

    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = jobsTableView.dequeueReusableCell(withIdentifier: "jobsCell") as? JobsCell else {return UITableViewCell()}
        return cell
    }
}

class JobsCell: UITableViewCell {
    
}
