//
//  PostVC.swift
//  TwitterClone
//
//  Created by Ahmet Berkay CALISTI on 14/06/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import UIKit

class PostVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // UI objects
    @IBOutlet var textTxt: UITextView!
    @IBOutlet var countLbl: UILabel!
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var pictureImg: UIImageView!
    @IBOutlet var postBtn: UIButton!
    
    // unique id of post
    var uuid = String()
    var imageSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        // round corners
        textTxt.layer.cornerRadius = textTxt.bounds.width / 50
        postBtn.layer.cornerRadius = postBtn.bounds.width / 20
        
        // color
        textTxt.backgroundColor = colorSmoothGray
        selectBtn.setTitleColor(colorBrandBlue, for: .normal)
        postBtn.backgroundColor = colorBrandBlue
        countLbl.textColor = colorSmoothGray
        
        // disable auto scroll layout
        self.automaticallyAdjustsScrollViewInsets = false
        
        // disable button from the begining
        postBtn.isEnabled = false
        postBtn.alpha = 0.4
    }
    
    // entered some text in textView
    func textViewDidChange(_ textView: UITextView) {
        
        // counter
        let chars = textView.text.count
        
        // white spacing in text
        let spacing = CharacterSet.whitespacesAndNewlines
        
        // calculate string's length and convert to String
        countLbl.text = String(140 - chars)
        
        // if number of chars more than 140
        if chars > 140 {
            countLbl.textColor = colorSmoothRed
            postBtn.isEnabled = false
            postBtn.alpha = 0.4
            
        // if entered only spaces and new lines
        } else if textView.text.trimmingCharacters(in: spacing).isEmpty {
            postBtn.isEnabled = false
            postBtn.alpha = 0.4
            
        // everything is correct
        } else {
            countLbl.textColor = colorSmoothGray
            postBtn.isEnabled = true
            postBtn.alpha = 1
        }
    }
    // touched screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    // hide keyboard
        self.view.endEditing(false)
    }

    @IBAction func select_click(_ sender: Any) {
        
        
        
        // calling picker for selecting iamge
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    
    // selected image in picker view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        pictureImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        // cast as a true to save image file in server
        imageSelected = true
    }
    
    
    // custom body of HTTP request to upload image file
    @objc func createBodyWithParams(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        // if file is not selected, it will not upload a file to server, because we did not declare a name file
        var filename = ""
        
        if imageSelected == true {
            filename = "post-\(uuid).jpg"
        }
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        return body as Data
        
    }
    
    // function sending request to PHP tp upload a file
    @objc func uploadPost() {
        
        let id = user!["id"] as! String
        let uuid = UUID().uuidString
        let text = textTxt.text as String
        
        // url path to php file
        let url = URL(string: "http://locahost/Twitter/posts.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    }
    
    
    // clicked post button
    @IBAction func post_click(_ sender: Any) {
        
        if !textTxt.text.isEmpty && textTxt.text.count <= 140 {
            // post
            
            
        }
        
    }
    

}
