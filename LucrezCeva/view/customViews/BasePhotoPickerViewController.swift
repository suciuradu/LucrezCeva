//
//  BasePhotoPicker.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 04/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class BasePhotoPickerViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func showSelectOrCapturePhotoAlert(editImage:Bool) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        var alertStyle = UIAlertControllerStyle.actionSheet
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertStyle = UIAlertControllerStyle.alert
        }
        let pickerOptionsController = UIAlertController.init(title: "selectati o imagine", message: "mesaj de selectqare iamgine", preferredStyle: alertStyle)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let galleryAction = UIAlertAction.init(title: "din galerie", style: .default) { (action) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            pickerOptionsController.addAction(galleryAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction.init(title: "din camera", style: .default) { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            pickerOptionsController.addAction(cameraAction)
        }
        pickerOptionsController.addAction(UIAlertAction.init(title: "inapoi", style: .destructive, handler: nil))
        self.present(pickerOptionsController, animated: true, completion: nil)
    }
    
    func onPhotoReady(_ image:UIImage) {
        preconditionFailure("This method must be overriden")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[picker.allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage] as? UIImage {
            onPhotoReady(image)
        } else {
            Logger.log("no image returned", info)
        }
    }
    
}
