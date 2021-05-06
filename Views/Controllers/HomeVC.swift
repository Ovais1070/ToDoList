//
//  HomeVC.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var listData = [SaveListModel]()
    var counter: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
            // Register TableCell
        tableView.register(UINib(nibName: "TopCell", bundle: nil), forCellReuseIdentifier: "TopCell")
        tableView.register(UINib(nibName: "FooterCell", bundle: nil), forCellReuseIdentifier: "FooterCell")
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")


        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        checkReminder()
    }
    

    
    //// save reminder in NSCODING Class using archive method
    /////The method archive the class object in user defaults
    
    @IBAction func newList_Btn(_ sender: Any) {
        
        
        let alertController = UIAlertController(title: "Add a new list", message: "", preferredStyle: .alert)

        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let listName = alertController.textFields![0] as UITextField
            if listName.hasText{
                
                let uuid = UUID().uuidString
                let saveList = SaveListModel(listName: listName.text ?? "", listId: "\(uuid)" )
                self.listData.append(saveList)
                if let saveDate = try? NSKeyedArchiver.archivedData(withRootObject: self.listData, requiringSecureCoding: false) {
                    let defaults = UserDefaults.standard
                    defaults.set(saveDate, forKey: "listData")
                    
                }
                self.tableView.reloadData()
            } else {
                return
            }
            
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "List Name"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    
   /////Retrieve NSCODING CLASS usinf unarchive method
    ////The merhod unarchive the class object from user defaults
    func checkReminder(){
        let defaults = UserDefaults.standard
        if let savedReminder = defaults.object(forKey: "listData") as? Data {
            if let decodedReminder = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedReminder) as? [SaveListModel] {
                listData = decodedReminder
                
                
            }
        }
    }
    
    
    
    
}
 
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        print("REMINDER", self.listData.count)
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = UITableViewCell()
        let section = indexPath.section
        
        
        
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell") as! TopCell
            
            let indexpath = indexPath.row
            switch indexpath {
            case 0:
                
                cell.logo.image = UIImage(named: "sun")
                cell.title.text = "Daily Task"
                
                return cell
            case 1:
                cell.logo.image = UIImage(named: "important")
                cell.title.text = "Important"
                
                return cell
            case 2:
                cell.logo.image = UIImage(named: "completed")
                cell.title.text = "Tasks Completed"
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! FooterCell
                cell.selectionStyle  = .none
                return cell
            default:
                break
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
            
            cell.list_Title.text = listData[indexPath.row].listName
            print("listUDID", listData[indexPath.row].listId)
            return cell
            
        default:
            break
        }
        
        return emptyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        switch section {
        case 1:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "NewListVC") as! NewListVC
            vc.listName = listData[indexPath.row].listName
            vc.listID = listData[indexPath.row].listId
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        default:
            break
        }
    }
    
}
