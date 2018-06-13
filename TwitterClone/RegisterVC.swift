//
//  ViewController.swift
//  TwitterClone
//
//  Created by Ahmet Berkay CALISTI on 10/06/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    // UI objects
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var firstnameTxt: UITextField!
    @IBOutlet var lastnameTxt: UITextField!
    
    // first func
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        
    }

    // register button clicked
    @IBAction func register_click(_ sender: Any) {
        
        //if no text
        if usernameText.text!.isEmpty || passwordTxt.text!.isEmpty || emailTxt.text!.isEmpty || firstnameTxt.text!.isEmpty || lastnameTxt.text!.isEmpty {
            
            //red placeholders
            usernameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            firstnameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            lastnameTxt.attributedPlaceholder = NSAttributedString(string: "surname", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])

            // if text is entered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            // url to php file
            let url = URL(string: "http://localhost/Twitter/register.php")!
            
            // request to this file
            var request = URLRequest(url: url)
            
            // method to pass data to this file (e.g. via POST)
            request.httpMethod = "POST"
            
            // body to be appended to url
            let body = "username=\(usernameText.text!.lowercased())&password=\(passwordTxt.text!)&email=\(emailTxt.text!)&fullname=\(firstnameTxt.text!)%20\(lastnameTxt.text!)"
            print(usernameText.text!)
            request.httpBody = body.data(using: .utf8)
            
            // proceed request
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    // get main queue in code process to communicate back to UI
                    DispatchQueue.main.async(execute: {
                        
                        do {
                            // get json result
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            // assign json to new var parseJSON in guard/secured way
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            // get id from parseJSON dictionary
                            let id = parseJSON["id"]
                            
                            // successfully registered
                            if id != nil {
                                
                                // save user information we received from our host
                                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                user  = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                
                                // go to tabbar / home page
                                DispatchQueue.main.async(execute: {
                                    appDelegate.login()
                                })
                            // error
                            } else {
                                // get main queue to communicate back to user
                                DispatchQueue.main.async(execute: {
                                    
                                    let message = parseJSON["message"] as! String
                                    appDelegate.infoView(message: message, color: colorSmoothRed)
                                    
                                })
                            }
                            
                        } catch {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                let message = error as! String
                                appDelegate.infoView(message: message, color: colorSmoothRed)
                                
                            })
                            
                        }
                        
                    })
                    
                    // if unable to proceed request
                } else {
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        appDelegate.infoView(message: message, color: colorSmoothRed)
                        
                    })
                }
                
                // launch prepared session
                }.resume()
            
            
        }
    }
    
    // white status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

