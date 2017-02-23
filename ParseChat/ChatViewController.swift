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
    
    let chat = PFObject(className: "Message")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSendButton(_ sender: Any) {
        
        chat["text"] = chatText.text
//        chat["playerName"] = "Sean Plott"
//        chat["cheatMode"] = false
        chat.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print("Success!")
                // The object has been saved.
            } else {
                print("Error: \(error?.localizedDescription)")
                // There was a problem, check error.description
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        cell.chatLabel.text = chat["text"] as! String?
        
        
        return cell
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
