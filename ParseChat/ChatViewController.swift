//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Lum Situ on 2/22/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var objects: [PFObject] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let object = objects[indexPath.row]
        
        let user = object["user"] as? PFUser
        let userName = user?.username
        
        let message = object["text"] as? String
        
        cell.userNameLabel.text = userName
        cell.chatLabel.text = message
        
//        print("chat: \(cell.chatLabel.text)")
        
        return cell
    }
    
    
    func onTimer () {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    self.objects = objects
                    for _ in objects {
//                        print(object.objectId!)
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
            
        }
        
        self.tableView.reloadData()
        
    }

    @IBAction func onSendButton(_ sender: Any) {
        let message = PFObject(className: "Message")

        message["text"] = chatText.text
        
        message["user"] = PFUser.current()
        
        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print(message)
                // The object has been saved.
            } else {
                print("Error: \(error?.localizedDescription)")
                // There was a problem, check error.description
            }
        }
    }
    
    
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
