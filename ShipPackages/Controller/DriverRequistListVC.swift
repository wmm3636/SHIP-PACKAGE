//
//  DriverRequistListVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/14/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import Firebase
import SideMenuSwift

class DriverRequistListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var noteTable: UITableView!
    var data: [String] = []
    var keys: [String] = []
    var fileURL:URL!
    var selectedRow: Int = -1
    var changedText:String = ""
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let query = self.ref.child("orders").queryOrdered(byChild: "assignedTo").queryEqual(toValue: "none")
        query.observe(.value) { (snapshot) in
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let dict = child.value as? [String: AnyObject] ?? [:]
                self.data.append(dict["description"] as! String)
                self.keys.append(child.key)
            }
            print("From the viewDidLoad")
            print(self.data)
            // Do any additional setup after loading the view, typically from a nib.
            self.noteTable.dataSource = self
            self.noteTable.delegate = self
            self.title = "New Request"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
            //            let addReminderButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.self.addReminderText))
            //            self.navigationItem.rightBarButtonItem = addReminderButton
            //self.navigationItem.leftBarButtonItem = editButtonItem
            print("here")
            let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            self.fileURL = baseURL.appendingPathComponent("reminders.txt")
            self.loadReminder()
        }
        
    }
    @objc func addReminderText(){
        if noteTable.isEditing {
            return
        }
        let name:String = ""
        data.insert(name, at: 0)
        let indexPath: IndexPath = IndexPath(row:0, section: 0)
        noteTable.insertRows(at: [indexPath], with: .automatic)
        noteTable.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "reminderDetails", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseCell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        noteTable.setEditing(editing, animated: animated)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        saveReminder()
    }
    
    func saveReminder(){
        //        UserDefaults.standard.set(data, forKey: "reminders")
        let reminders = NSArray(array: data)
        do {
            try reminders.write(to: fileURL)
        } catch  {
            print("Failed writing to file")
        }
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        if selectedRow == -1 {
    //            return
    //        }
    //        data[selectedRow] = changedText
    //        if changedText == "" {
    //            data.remove(at: selectedRow)
    //        }
    //        noteTable.reloadData()
    //        saveReminder()
    //    }
    func loadReminder(){
        //        if let savedReminders:[String] = UserDefaults.standard.value(forKey: "reminders") as? [String]{
        //            data = savedReminders
        //            noteTable.reloadData()
        //        }
        print(self.data)
        if let savedReminders:[String] = NSArray(contentsOf:fileURL) as? [String]{
            // data = savedReminders
            //noteTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "reminderDetails", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController: DriverRequistDetailsVC = (segue.destination as? DriverRequistDetailsVC)!
        selectedRow = noteTable.indexPathForSelectedRow!.row
        detailViewController.parentView = self
        detailViewController.key = self.keys[selectedRow]
        detailViewController.setText(text: data[selectedRow])
    }
    

}
