//
//  EditTasksVC.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/18/21.
//

import UIKit

class EditTasksVC: UIViewController {

    
    @IBOutlet weak var remindMe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelAction(_:)))
            
        remindMe.addGestureRecognizer(tap)
    }
    
    @objc func labelAction(_ recognizer: UITapGestureRecognizer) {

            print("button is tapped")

    }
   

}
