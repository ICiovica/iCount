//
//  AlarmViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit

class AlarmViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var alarm: Alarm!

    @IBOutlet var name: UITextField!
    @IBOutlet var caption: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tapToSelectImage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = alarm.name
        caption.text = alarm.caption
        datePicker.date = alarm.time

        if alarm.image.count > 0 {
            let imageFilename = Helper.getDocumentsDirectory().appendingPathComponent(alarm.image)
            imageView.image = UIImage(contentsOfFile: imageFilename.path)
            tapToSelectImage.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        alarm.name = name.text!
        alarm.caption = caption.text!
        title = alarm.name

        save()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        alarm.time = datePicker.date

        save()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }
    
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else { return }
        let fm = FileManager()

        if alarm.image.count > 0 {
            do {
                let currentImage = Helper.getDocumentsDirectory().appendingPathComponent(alarm.image)

                if fm.fileExists(atPath: currentImage.path) {
                    try fm.removeItem(at: currentImage)
                }
            } catch {
                print("Failed to remove current image")
            }
        }

        do {
            alarm.image = "\(UUID().uuidString).jpg"
            let newPath = Helper.getDocumentsDirectory().appendingPathComponent(alarm.image)

            let jpeg = image.jpegData(compressionQuality: 0.8)
            try jpeg?.write(to: newPath)

            save()
        } catch {
            print("Failed to save new image")
        }

        imageView.image = image
        tapToSelectImage.isHidden = true
    }

    func save() {
        NotificationCenter.default.post(name: Notification.Name("save"), object: nil)
    }
}
