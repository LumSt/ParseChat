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
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(_ sender: Any) {
        
        let user = PFUser()
        user.username = usernameText.text
        user.password = passwordText.text
        
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) in
            if succeeded {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                self.present(self.alertController, animated: true) {
                    self.alertController.title = "Error"
                    self.alertController.message = "User name or password needed!"
                }
            }
            
        }
        
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameText.text! , password: passwordText.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("ilogged in")
            } else {
                
                self.present(self.alertController, animated: true) {
                    self.alertController.title = "Error"
                    self.alertController.message = "Invalid user name or password!"
                }
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
