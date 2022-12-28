//
//  HomeVC.swift
//  Calm demo
//
//  Created by Chirag Bhojani on 28/12/22.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnScheduleClick(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Identifier.ViewController.rawValue) as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
}
