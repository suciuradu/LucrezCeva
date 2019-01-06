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
    @IBOutlet weak var showFilters: UIImageView!

    
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
        showFilters.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPopUp)))
       
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
    
    @objc private func showPopUp() {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "popup") as! PopUpViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
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

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var tapDismissView: UIView!
    var filterArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tapDismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.dismissViewController)))
    }
    
    @objc private func dismissViewController() {
        if let vc = presentingViewController as? HomeViewController {
           //send the array of filters back
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func zilnicFilter(_ sender: UIButton) {
        setButtonState(sender: sender)
    }
    
    @IBAction func saptamanalFilter(_ sender: UIButton) {
        setButtonState(sender: sender)
    }
    @IBAction func lunarFilter(_ sender: UIButton) {
        setButtonState(sender: sender)

    }
    @IBAction func ocazionalFilter(_ sender: UIButton) {
        setButtonState(sender: sender)
    }
    
    private func setButtonState(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
}
