//
//  ViewController.swift
//  NewsFeed
//
//  Created by Azharuddin 1 on 26/07/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let controller =  UIHostingController(rootView: NewsFeedListView())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        self.addChild(controller)
        view.addSubview(controller.view)
        
        setConstraints()
    }
    
    
    func setConstraints(){
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

