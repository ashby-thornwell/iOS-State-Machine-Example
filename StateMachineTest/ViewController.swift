//
//  ViewController.swift
//  StateMachineTest
//
//  Created by Ashby Thornwell on 5/22/19.
//  Copyright © 2019 Ashby Thornwell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = NetworkingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewModel()
    }
    
    func setUpViewModel() {
        viewModel.delegate = self
        viewModel.refresh()
    }
}

extension ViewController: ViewModelDisplayDelegate {
    func displayData() {
        
    }
    
    func displayEmpty() {
        
    }
    
    func displayError() {
        
    }
}

