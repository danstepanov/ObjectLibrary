//
//  SketchFabViewController.swift
//  ObjectLibrary
//
//  Created by Daniel Stepanov on 2/17/16.
//  Copyright © 2016 Daniel Stepanov. All rights reserved.
//

import UIKit
import PureLayout
import WebKit

class SketchFabViewController: UIViewController {

    // MARK:
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        view.setNeedsUpdateConstraints()
    }
    
    // MARK:
    // MARK: UI Element Layout & Constraints
    func setupSubviews() {
        view.addSubview(sketchFabWebView)
    }
    
    override func updateViewConstraints() {
        sketchFabWebViewConstraints()
        super.updateViewConstraints()
    }
    
    func sketchFabWebViewConstraints() {
        sketchFabWebView.autoCenterInSuperview()
        sketchFabWebView.autoConstrainAttribute(.Height, toAttribute: .Height, ofView: view)
        sketchFabWebView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: view)
        
    }
    
    // MARK:
    // MARK: Lazily Instantiated UI Elements
    lazy var sketchFabWebView: WKWebView = {
        var view: WKWebView = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
         
        return view
    }()


}
