//
//  SplashVC.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var vu_bg: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
        
           vu_bg.layer.cornerRadius = vu_bg.frame.size.width/2
           vu_bg.clipsToBounds = true
           
           UIView.animate(withDuration: 4,
                          animations: {
                           self.vu_bg.transform = CGAffineTransform(scaleX: 100, y: 100)
           },
                          completion: { _ in
                           
                           DispatchQueue.main.async {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            self.navigationController?.setNavigationBarHidden(false, animated: true)
                           }
                           
           })
           
       }
    

    
}
