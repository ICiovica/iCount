//
//  PersonTableViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 07/11/2021.
//

import UIKit

class PersonViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var personImage: UIImageView!
    @IBOutlet var personName: UITextField!
    @IBOutlet var dobPerson: UIDatePicker!
    
    lazy var gradient: CAGradientLayer = {
         let gradient = CAGradientLayer()
         gradient.type = .axial
         gradient.colors = [
             UIColor.colorHunt.cgColor,
             UIColor.purple.cgColor,
             UIColor.cyan.cgColor
         ]
         gradient.locations = [0, 0.25, 1]

         return gradient
     }()
    
    var imageDescription: String?
    var name: String?
    var date: String?
    
   static var persons = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let nameText = personName.text else { return }
        name = nameText
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        date = formatter.string(from: dobPerson.date)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.modalPresentationStyle = .formSheet
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        personImage.image = image
        
        let imageName = UUID().uuidString
        
        imageDescription = imageName
        
        let imagePath = HelperBirth.getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func savePerson(_ sender: UIBarButtonItem) {
        
        guard let name = name else { return }

        guard let date = date else { return }

        guard let imageDescription = imageDescription else { return }
        
        let newPerson = Person(name: name, image: imageDescription, dob: date)
        
//        people.append(person)
        PersonViewController.persons.append(newPerson)
        
        print(PersonViewController.persons.count)
        print(newPerson.dob)
        print(newPerson.image)
        print(newPerson.name)
        
        save()
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(PersonViewController.persons) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        } else {
            print("Failed to save people.")
        }
    }
    
}
