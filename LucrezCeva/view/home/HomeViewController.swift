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

class HomeViewController: BaseViewController, PopUpDelegate {
    
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
    @IBOutlet weak var tagListViewHeightConstraint: NSLayoutConstraint!
    
    var delegate: HomeDelegate?
    var viewModel: HomeViewModel!
    var selectedTabIndex = 0
    var tagsArray = [String]() {
        didSet {
            Logger.log("set")
        }
    }
    var tags  = [String]()
    var cityFilter = ""
    var jobArray = [JobItem]()
    var recomandedArray = [JobItem]()
    var bookmarkedArray = [JobItem]()
    var standardArray = [JobItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func initViewModel() {
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        searchBar.delegate = self
        viewModel.jobArray.bind { (array) in
            self.jobArray.removeAll()
            self.standardArray.removeAll()
            self.standardArray.append(contentsOf: array)
            self.jobArray.append(contentsOf: array)
            self.jobsTableView.reloadData()
        }
        viewModel.bookmarkedArray.bind { (array) in
            self.bookmarkedArray.removeAll()
            self.standardArray.removeAll()
            self.standardArray.append(contentsOf: array)
            self.bookmarkedArray.append(contentsOf: array)
            // nu stiu ce o sa se intample daca las reloaddata
            self.jobsTableView.reloadData()
        }
        viewModel.recomandedArray.bind { (array) in
            self.recomandedArray.removeAll()
            self.standardArray.removeAll()
            self.standardArray.append(contentsOf: array)
            self.recomandedArray.append(contentsOf: array)
            // nu stiu ce o sa se intample daca las reloaddata
            self.jobsTableView.reloadData()
        }
        
    }
    
    private func initUI() {
        hideKeyboardWhenTappedAround()
        searchBar.setPlaceholderTextColor(color: UIColor.white.withAlphaComponent(0.5))
        searchBar.setTextColor(color: UIColor.white)
        searchBar.setImage(#imageLiteral(resourceName: "clear-button-white"), for: .clear, state: .normal)
        searchBar.setImage(#imageLiteral(resourceName: "search-white"), for: .search, state: .normal)
        topView.applyGradient(withColours: [Colors.colorTopBlue,Colors.colorMediumTurqoise], gradientOrientation: .vertical)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.jobsTableView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.jobsTableView.addGestureRecognizer(swipeRight)
        noutatiButton.isSelected = true
        showFilters.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPopUp)))
        createTagCloud(OnView: tagList, withArray: tagsArray as [AnyObject])
        tagListViewHeightConstraint.constant = 0
    }
    
    func recieve(data: [String], city: String) {
        tagsArray = data
        tags = data
        if city != "" {
            tagsArray.append(city)
            cityFilter = city
            viewModel.getJobs([cityFilter], tags, "")
        } else {
            viewModel.getJobs([], tags, "")
        }
        createTagCloud(OnView: tagList, withArray: tagsArray as [AnyObject])
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            jobsTableView.reloadData()
            switch selectedTabIndex {
            case 1:
                viewModel.getJobs([], [], "")
                animateTabColorChange(sender: noutatiButton)
            case 2:
                viewModel.getRecomanded([], [], "")
                animateTabColorChange(sender: recomandateButton)
            default:
                break
            }
        } else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            jobsTableView.reloadData()
            switch selectedTabIndex {
            case 0:
                viewModel.getRecomanded([], [], "")
                animateTabColorChange(sender: recomandateButton)
            case 1:
                viewModel.getBookmarks()
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
        viewModel.getJobs([], [], "")
        animateTabColorChange(sender: sender)
    }
    
    @IBAction func recomandateTapped(_ sender: UIButton) {
        viewModel.getRecomanded([], [], "")
        animateTabColorChange(sender: sender)
    }
    
    @IBAction func salvateTapped(_ sender: UIButton) {
        viewModel.getBookmarks()
        animateTabColorChange(sender: sender)
    }
    
    @objc private func showPopUp() {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "popup") as! PopUpViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        vc.filterArray = tagsArray
        self.present(vc, animated: true, completion: nil)
    }
}

protocol HomeDelegate: AnyObject {
    func jobCellTapped(job: JobItem)
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if cityFilter != "" {
            if tags.count > 0 {
                 viewModel.getJobs([cityFilter], tags, searchText)
            } else {
                viewModel.getJobs([cityFilter], [], searchText)
            }
        } else {
            if tags.count > 0 {
                viewModel.getJobs([],tags, searchText)
            } else {
                viewModel.getJobs([], [], searchText)
            }
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if standardArray.count > 0 {
            self.jobsTableView.setEmptyMessage("")
            return standardArray.count
        } else {
            self.jobsTableView.setEmptyMessage("Nu aveți încă joburi salvate!")
            return standardArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = jobsTableView.dequeueReusableCell(withIdentifier: "jobsCell") as? JobsCell else {return UITableViewCell()}
        cell.bookmarkImage.tag = standardArray[indexPath.row].id!
        cell.bookmarkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBookmark(_:))))
        cell.configureCell(job: standardArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.jobCellTapped(job: standardArray[indexPath.row])
    }
    
    @objc func onBookmark(_ sender: UITapGestureRecognizer) {
        if PersistancyManager.getToken() != nil {
            if let job = standardArray.first(where: {$0.id == sender.view!.tag}) {
                job.bookmarked = !job.bookmarked!
                if job.bookmarked! {
                    viewModel.addBookmark(id: job.id ?? 0)
                    bookmarkedArray.append(job)
                } else {
                    viewModel.deleteBookmark(id: job.id ?? 0)
                    bookmarkedArray.removeAll(where: {$0.id == job.id})
                }
                jobsTableView.reloadData()
            }
        } else {
            showErrorMessage("Nu puteti salva un job daca nu sunteti logat!")
        }
    }
}




class JobsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var jobType: UILabel!
    @IBOutlet weak var daysSincePostedLabel: UILabel!
     @IBOutlet weak var bookmarkImage: UIImageView!
    var isBookmarked: Bool!
    
   
    func configureCell(job: JobItem) {
        self.isBookmarked = job.bookmarked ?? false
        self.titleLabel.text = job.title ?? "Titlu job"
        self.locationLabel.text = job.location ?? "Locatie job"
        self.jobType.text = job.type ?? "Tip job"
        if job.daysSincePosted == 1 {
            self.daysSincePostedLabel.text = "acum o zi"
        } else if job.daysSincePosted! > 1 {
            self.daysSincePostedLabel.text = "acum \(job.daysSincePosted ?? 1) zile"
        } else {
            self.daysSincePostedLabel.text = "azi"
        }
        self.bookmarkImage.isHighlighted = isBookmarked
    }
}

protocol PopUpDelegate: AnyObject {
    func recieve(data: [String], city: String)
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var tapDismissView: UIView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zilnicButton: UIButton!
    @IBOutlet weak var saptamanalButton: UIButton!
    @IBOutlet weak var lunarButton: UIButton!
    @IBOutlet weak var ocazionalButton: UIButton!
    
    var delegate: PopUpDelegate?
    var city: String?
    
    var filterArray = [String]() {
        didSet {
            Logger.log("also set", filterArray.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tapDismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.dismissViewController)))
        for item in filterArray {
            switch item {
            case "Zilnic":
                zilnicButton.isSelected = true
            case "Ocazional":
                ocazionalButton.isSelected = true
            case "Săptămânal":
                saptamanalButton.isSelected = true
            case "Lunar":
                lunarButton.isSelected = true
            default:
                cityTextField.text = item
            }
        }
    }
    
    @objc private func dismissViewController() {
        delegate?.recieve(data: filterArray, city: city ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func zilnicFilter(_ sender: UIButton) {
        setButtonState(sender: sender, title: "Zilnic")
    }
    
    @IBAction func saptamanalFilter(_ sender: UIButton) {
        setButtonState(sender: sender, title: "Săptămânal")
    }
    @IBAction func lunarFilter(_ sender: UIButton) {
        setButtonState(sender: sender, title: "Lunar")

    }
    @IBAction func ocazionalFilter(_ sender: UIButton) {
        setButtonState(sender: sender, title: "Ocazional")
    }
    
    @IBAction func aplicaFiltersDismiss(_ sender: Any) {
        if cityTextField.text != "" {
            city = cityTextField.text
        }
        dismissViewController()
    }
    
    private func setButtonState(sender: UIButton, title: String) {
        if sender.isSelected {
            sender.isSelected = false
            filterArray.removeAll(title)
        } else {
            sender.isSelected = true
            filterArray.append(title)
        }
    }
}

///////////////////////////////////////////////   TAG LIST EXTENSION   //////////////////////////////////////////////////////

extension HomeViewController {
    func createTagCloud(OnView view: UIView, withArray data:[AnyObject]) {
        tagListViewHeightConstraint.constant = 39
        for tempView in view.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
        
        var xPos:CGFloat = 0.0
        var ypos: CGFloat = 0.0
        var tag: Int = 1
        for str in data  {
            let startstring = str as! String
            let width = startstring.widthOfString(usingFont: UIFont(name:"verdana", size: 13.0)!)
            let checkWholeWidth = CGFloat(xPos) + CGFloat(width) + CGFloat(5.0) + CGFloat(25.5)
            if checkWholeWidth > view.frame.width {
                xPos = 0.0
                ypos = ypos + 29.0 + 8.0
                tagListViewHeightConstraint.constant += ypos
            }
            
            let bgView = UIView(frame: CGRect(x: xPos, y: ypos, width:width + 4.0 + 35.5 , height: 29.0))
            bgView.layer.cornerRadius = 14.5
            bgView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            bgView.tag = tag
            
            let textlable = UILabel(frame: CGRect(x: 17.0, y: 0.0, width: width, height: bgView.frame.size.height))
            textlable.font = UIFont(name: "avenir-medium", size: 13.0)
            textlable.text = startstring
            textlable.textColor = UIColor.white
            bgView.addSubview(textlable)
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: bgView.frame.size.width - 3.5 - 23.0, y: 3.0, width: 23.0, height: 23.0)
            //button.backgroundColor = UIColor.white
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.setImage(UIImage(named: "delete-tag"), for: .normal)
            button.tag = tag
            button.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
            bgView.addSubview(button)
            xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(5.0) + CGFloat(43.0)
            view.addSubview(bgView)
            tag = tag  + 1
        }
    }
    
    @objc func removeTag(_ sender: AnyObject) {
        let tag = tagsArray.item(at: (sender.tag - 1))
        if tags.contains(tag!) {
            tags.removeAll(tag!)
        }
        if cityFilter != "" {
            if tag == cityFilter {
                viewModel.getJobs([], tags, "")
            } else {
                viewModel.getJobs([cityFilter], tags, "")
            }
        } else {
            viewModel.getJobs([], tags, "")
        }
        tagsArray.remove(at: (sender.tag - 1))
        createTagCloud(OnView: tagList, withArray: tagsArray as [AnyObject])
        if tagsArray.count == 0 {
            tagListViewHeightConstraint.constant = 0
        }
    }
    
}
