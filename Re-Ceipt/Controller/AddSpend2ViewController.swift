//
//  AddSpend2ViewController.swift
//  Re-Ceipt
//
//  Created by Sunwoo Lee on 2017. 12. 19..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit

class AddSpend2ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var review_field: UILabel!
    @IBOutlet var Buttons: Array<UIButton>?
    @IBOutlet weak var title_field: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    
    let imagePicker = UIImagePickerController()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            let imageName = imageURL.lastPathComponent
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            button.imageView?.image = selectedImage
            button.imageView?.contentMode = .scaleAspectFill
            button.imageView?.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchCamera() {
        let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        present(photoSourceRequestController, animated: true, completion: nil)
    }
    
    var delegate: TopViewControllerProtocol!
    
    var amount: String = ""
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        review_field.numberOfLines=0
        review_field.text = "\(date) 에\n\(amount) 원을 입력합니다.\n카테고리를 선택하세요."
        review_field.sizeToFit()
        
        for button in Buttons! {
            button.layer.cornerRadius=10
            button.clipsToBounds=true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton)
    {
        if let title = title_field.text{
            Communicator.addSpend(self.view, title: title, type: sender.currentTitle!, date: date, amount: Int(amount)!){
                self.navigationController?.popToRootViewController(animated: true)
                self.delegate.dismissViewController()
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
