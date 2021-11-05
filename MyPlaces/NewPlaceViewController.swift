//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Владислав Соколов on 24.10.2021.
//

import UIKit
import PhotosUI

class NewPlaceViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeLocationTextField: UITextField!
    @IBOutlet weak var placeTypeTextField: UITextField!
    
    var currentPlace: Place?
    var imageIsChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        placeNameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    }

    private func setupEditScreen() {
        if currentPlace != nil {
            setupNavigationBar()
            imageIsChanged = true
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            placeNameTextField.text = currentPlace?.name
            placeLocationTextField.text = currentPlace?.location
            placeTypeTextField.text = currentPlace?.type
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
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
    
    func savePlace() {
        let newPlace: Place
        var image: UIImage?
        if imageIsChanged == true {
            image = placeImage.image
        } else {
            image = UIImage(named: "imagePlaceholder")
        }
        let imageData = image?.pngData()
        newPlace = Place(name: placeNameTextField.text!, location: placeLocationTextField.text, type: placeTypeTextField.text, imageData: imageData)
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
            }
        } else {
            StorageManager.saveObject(newPlace)
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension NewPlaceViewController: UITextFieldDelegate {
    
    //скрываем клаву при нажатии на done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if placeNameTextField.text?.isEmpty == false{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
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
        imageIsChanged = true
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
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
