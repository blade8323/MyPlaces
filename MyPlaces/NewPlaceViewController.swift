//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Владислав Соколов on 24.10.2021.
//

import UIKit
import PhotosUI

class NewPlaceViewController: UITableViewController {

    @IBOutlet weak var imageOfPlace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    // MARK: - UItableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cameraIcon = UIImage(named: "camera")
        let photoIcon = UIImage(named: "photo")
        
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true, completion: nil)
        } else {
            view.endEditing(true)
        }
    }
    
}

extension NewPlaceViewController: UITextFieldDelegate {
    
    //скрываем клаву при нажатии на done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK : - Work with Image
extension NewPlaceViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfPlace.image = info[.editedImage] as? UIImage
        imageOfPlace.contentMode = .scaleAspectFill
        imageOfPlace.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}

//extension NewPlaceViewController: PHPickerViewControllerDelegate {
//
//    func chooseImagePicker(source: UIImagePickerController.SourceType) {
//        var config = PHPickerConfiguration()
//        config.selectionLimit = 1
//        config.filter =  .any(of: [.images, .livePhotos, .videos])
//
//        let pickerViewController = PHPickerViewController(configuration: config)
//        pickerViewController.delegate = self
//        self.present(pickerViewController, animated: true, completion: nil)
//    }
//
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true, completion: nil)
//
//        for result in results {
//           result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
//              if let image = object as? UIImage {
//                 DispatchQueue.main.async {
//                    // Use UIImage
//                     self.imageOfPlace.image = image
//                     self.imageOfPlace.contentMode = .scaleAspectFill
//                     self.imageOfPlace.clipsToBounds = true
//                 }
//              }
//           })
//        }
//    }
//}
