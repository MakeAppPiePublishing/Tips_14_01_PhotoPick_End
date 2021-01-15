//
//  ViewController.swift
//  PhotoPick
//
//  Created by Steven Lipton on 1/15/21.
//


import UIKit
import PhotosUI

class ViewController: UIViewController,PHPickerViewControllerDelegate {
    
   

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    @IBAction func selectPhotoButton(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
        
    }
 //MARK: Delegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated:true)
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass:UIImage.self){
            let previousImage = photo.image
            itemProvider.loadObject(ofClass: UIImage.self){ [weak self] image, error in
                DispatchQueue.main.async{
                    guard let self = self, let image = image as? UIImage, self.photo.image == previousImage else {return}
                    self.photo.image = image
                }
            }
        }
       }
 
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectPhotoButton.layer.cornerRadius = 10.0
    }


}

