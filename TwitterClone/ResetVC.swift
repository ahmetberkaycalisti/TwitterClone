//
//  ResetVC.swift
//  TwitterClone
//
//  Created by Ahmet Berkay CALISTI on 12/06/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import UIKit

class ResetVC: UIViewController {
    @IBOutlet var emailTxt: UITextField!
    
    
    // first func
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func reset_clicked(_ sender: Any) {
        
        // if not text entered
        if emailTxt.text!.isEmpty {
            
            //red placeholder
            emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
            
            // if text is entered
        } else {
            
            let email = emailTxt.text!.lowercased()
            
            // send mysql / php / hosting request
            
            // url path to php file
            let url = URL(string: "http://localhost/Twitter/resetPassword.php")!
            
            // request to send to this file
            var request = URLRequest(url: url)
            
            // method of passing inf to this file
            request.httpMethod = "POST"
            
            // body to be appended to url. It passes inf to this file
            let body = "email=\(email)"
            request.httpBody = body.data(using: .utf8)
            
            // proces request
            URLSession.shared.dataTask(with: request){ data, response, error in
                
                if error == nil {
                    
                    // give main queue to UI to communicate back
                    DispatchQueue.main.async(execute: {
                        
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                                
                            }
                            
                            let email = parseJSON["email"]
                            
                            // successfully reset
                            if email != nil {
                                // get main queue to communicate back to user
                                DispatchQueue.main.async(execute: {
                                    
                                    let message = parseJSON["message"] as! String
                                    appDelegate.infoView(message: message, color: colorLightGreen)
                                    
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
                    
                } else {
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        appDelegate.infoView(message: message, color: colorSmoothRed)

                    })
                }
            }.resume()
        }
    }
    
    // white status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
    }
    
}
