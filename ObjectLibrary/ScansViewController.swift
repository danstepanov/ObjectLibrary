//
//  ScansViewController.swift
//  ObjectLibrary
//
//  Created by Daniel Stepanov on 2/17/16.
//  Copyright © 2016 Daniel Stepanov. All rights reserved.
//

import UIKit
import Parse
import PureLayout

class ScansViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var scansArray = []
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scans"
        getScans()
        setupSubviews()

        view.setNeedsUpdateConstraints()
    }
    
    // MARK: - Parse Query
    func getScans() {
        let query = PFQuery(className: "Scan")
        query.findObjectsInBackgroundWithBlock { (parseArray: [PFObject]?, error: NSError?) -> Void in
            self.scansArray = parseArray!
            self.scansTableView.reloadData()
        }
    
    }
    
    // MARK: - UI Element Layout & Constraints
    func setupSubviews() {
        view.addSubview(scansTableView)
    }
    
    override func updateViewConstraints() {
        scansTableViewConstraints()
        super.updateViewConstraints()
    }
    
    func scansTableViewConstraints() {
        scansTableView.autoCenterInSuperview()
        scansTableView.autoConstrainAttribute(.Height, toAttribute: .Height, ofView: view)
        scansTableView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: view)
    }
    
    // MARK: - Lazily Instantiated UI Elements
    lazy var scansTableView: UITableView = {
        var view: UITableView = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        let cellNib = UINib.init(nibName: "ScanCell", bundle: nil)
        view.registerNib(cellNib, forCellReuseIdentifier: "cellIdentifier")

        return view
    }()
    
    // MARK: - UITableView Delegate & Datasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scansArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Setup reusable cell
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath) as! ScanCell
        cell.selectionStyle = .None
        
        // Set Cell Title of Scanned Object
        cell.scanTitle.text = self.scansArray[indexPath.row].objectForKey("title")! as? String
        
        // Set Cell Thumbnail of Scanned Object
        let scanPicture = self.scansArray[indexPath.row].valueForKey("thumbnail")!
        scanPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            let thumbnail = UIImage(data:imageData!)
            cell.thumbnail.image = thumbnail
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sketchFabViewController = SketchFabViewController()
        
        // Retrieve proper page for cell selection
        let modelName = "d3d755836f9c42a882c0c15d5637309c"
        let URL = NSURL(string: "https://sketchfab.com/models/\(modelName)")
        let request = NSURLRequest(URL: URL!)
        sketchFabViewController.sketchFabWebView.loadRequest(request)
        navigationController?.pushViewController(sketchFabViewController, animated: false)

    }
}
