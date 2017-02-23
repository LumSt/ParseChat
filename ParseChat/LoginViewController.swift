//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Lum Situ on 2/22/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(_ sender: Any) {
        
        var user = PFUser()
        user.username = usernameText.text
        user.password = passwordText.text
       // user.email = "email@example.com"
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = error.localizedDescription
                print("error: \(errorString)")
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
        
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameText.text! , password: passwordText.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                
                
                print("ilogged in")
            } else {
                // The login failed. Check error to see why.
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
