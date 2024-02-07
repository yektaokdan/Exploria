//
//  WelcomeVC.swift
//  Exploria
//
//  Created by yekta on 7.02.2024.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var ContinueButtonUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ContinueButtonUI.layer.cornerRadius = 20
        ContinueButtonUI.layer.masksToBounds = true
    }
    @IBAction func continueButtonTap(_ sender: Any) {
        performSegue(withIdentifier: "toTableVC", sender: self)
    }
}
