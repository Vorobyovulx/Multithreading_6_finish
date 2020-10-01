//
//  TestViewController.swift
//  GeekWeather
//
//  Created by Mad Brains on 01.10.2020.
//  Copyright © 2020 GeekTest. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var viewModel: TestViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vm = TestViewModel(authService: AuthService(), networkService: NetworkService())
        let vc = TestViewController()
        
        vc.viewModel = vm
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
    }
    
}
