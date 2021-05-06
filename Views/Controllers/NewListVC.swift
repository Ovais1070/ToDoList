//
//  NewListVC.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import UIKit


class NewListVC: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskBtn: UIButton!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet var addTaskView: UIView!
    @IBOutlet weak var task_title: UITextField!
    @IBOutlet weak var timeAndDate: UITextField!
    
    
    var task = [SaveTaskModel]()
    var filteredTask = [SaveTaskModel]()
    var datePicker :UIDatePicker!
    var doneBarButtonItem: UIBarButtonItem!
    var listName = ""
    var listID = ""
    let uuid = UUID().uuidString
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9843137255, green: 0.2666666667, blue: 0.3607843137, alpha: 1)
        self.title = listName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell
        tableView.register(UINib(nibName: "TaskAddedCell", bundle: nil), forCellReuseIdentifier: "TaskAddedCell")
        
        
        // Do any additional setup after loading the view.
        UIsetup()
        // Accessory
        hideKeyboardWhenTappedAround()
        
        doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButton))
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
        self.navigationItem.rightBarButtonItem = nil
        
        
        
        // TableView Delegate and Datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        checkTasks()
        
    }
    
    
    func UIsetup(){
        self.btnView.layer.cornerRadius = 10
        self.addTaskView.layer.cornerRadius = 10
    }
    
    func SetupDatePicker(){
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        timeAndDate.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        timeAndDate.inputAccessoryView = toolBar
        
        
    }
    
    
    @objc func doneButton(){
        print("done Button clicked")
        loadData()
        task_title.text = nil
        dismissKeyboard()
    }
    
    func loadData(){
        
        
        
        if task_title.hasText {
            let saveTask = SaveTaskModel(taskName: task_title.text ?? "", timeandDate: "", listId: listID, taskId: uuid)
            self.task.append(saveTask)
            if let saveDate = try? NSKeyedArchiver.archivedData(withRootObject: self.task, requiringSecureCoding: false) {
                let defaults = UserDefaults.standard
                defaults.set(saveDate, forKey: "tasks")
                filteredTask.removeAll()
                tableView.reloadData()
                checkTasks()
            }
        }
    }
    
    
    func checkTasks(){
        let defaults = UserDefaults.standard
        if let savedTasks = defaults.object(forKey: "tasks") as? Data {
            if let decodedReminder = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTasks) as? [SaveTaskModel] {
                task = decodedReminder
                
                filterData()
                self.tableView.reloadData()
            }
        }
    }
    
    
    func filterData(){
        for index in 0..<task.count {
            
            if listID == task[index].listId {
                let filteredData = SaveTaskModel(taskName: task[index].taskName, timeandDate: task[index].timeandDate, listId: task[index].listId, taskId: uuid)
                filteredTask.append(filteredData)
                self.tableView.reloadData()
            }
        }
    }
    
  
    
    
    @IBAction func addTaskBtn(_ sender: Any) {
        
        
        task_title.inputAccessoryView = addTaskView
        self.view.addSubview(addTaskView)
        task_title.becomeFirstResponder()
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    @objc func datePickerDone() {
        timeAndDate.resignFirstResponder()
    }
    
    @objc func dateChanged() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date12 = dateFormatter.string(from: datePicker.date)
        print("12 hour formatted Date:", date12)
        timeAndDate.text = "\(date12)"
    }
    
    
    
    
    
}

extension NewListVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewListVC.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
        
        if task_title.isFirstResponder {
            print("it is first responder")
            self.addTaskView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem = nil
//            print("REMINDER", remind.count)
        }
    }
    
    
}


extension NewListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        print("self.fliteredTask.count", self.filteredTask.count)
        print("self.task.count", self.task.count)
        return self.filteredTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TaskAddedCell") as! TaskAddedCell
        cell.taskTitle.text = filteredTask[indexPath.row].taskName
        print("listUDIDabsd", filteredTask[indexPath.row].listId)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
 
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EditTasksVC") as! EditTasksVC
//        vc.listName = listData[indexPath.row].listName
//        vc.listID = listData[indexPath.row].listId
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let defaults = UserDefaults.standard
            if let savedReminder = defaults.object(forKey: "tasks") as? Data {
                if let decodedReminder = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedReminder) as? [SaveTaskModel] {
                    task = decodedReminder
                    
                    print("check taskCOunt", self.task.count)
                    print("INDEXPATH", indexPath.row)
                    
                    let id = filteredTask[indexPath.row].taskName
                    
                    if task.count != 1 {
                        for idx in 0..<task.count - 1 {
                            
                            print("check IDX", idx)
                            
                            if task[idx].taskName ==  id {
                                task.remove(at: idx)
                                filteredTask.remove(at: indexPath.row)
                                self.tableView.reloadData()
                            }
                        }
                    } else {
                        for idx in 0..<task.count {
                            
                            print("check IDX", idx)
                            
                            if task[idx].taskName ==  id {
                                task.remove(at: idx)
                                filteredTask.remove(at: indexPath.row)
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                    
                    
                    
                    
                   
                 }
            }
            
            if let saveDate = try? NSKeyedArchiver.archivedData(withRootObject: task, requiringSecureCoding: false) {
                let defaults = UserDefaults.standard
                defaults.set(saveDate, forKey: "tasks")
                
            }
        } else {
            
            
        }
            
            
            
            
        }
        
    
    
   
   

}
