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
        if pictureImg.image == info[UIImagePickerControllerEditedImage] as? UIImage {
        }
    }
    
    
    
    // clicked post button
    @IBAction func post_click(_ sender: Any) {
        
        if !textTxt.text.isEmpty && textTxt.text.count <= 140 {
            // post
            
            
        }
        
    }
    

}
