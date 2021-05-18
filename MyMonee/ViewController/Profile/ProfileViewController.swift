//
//  ProfileViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editImgBtn: UIButton!
    @IBOutlet weak var editNameBtn: UIButton!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet weak var viewWrapper: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        photoProfile.layer.cornerRadius = photoProfile.frame.height / 2
        loadAll()
        hiddenComponent()
    }
    
    func loadAll() {
        userName.text = userData.user.name
        descriptionLabel.text = "Bagus, pengeluaranmu lebih sedikit dari pada pemasukan."
        self.viewWrapper.backgroundColor = UIColor.init(named: "main")
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
       hideOrShowBtn()
    }
    
    @IBAction func editNameBtnPressed(_ sender: Any) {

        let alert = UIAlertController(title: "Edit Name", message: .none, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.text = userData.user.name
        }
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            userData.user.name = textField?.text ?? userData.user.name
            self.viewDidLoad()
            self.hideOrShowBtn()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil))
        
    
        self.present( alert, animated: true, completion: nil)
    }
    
    func hideOrShowBtn() {
        if editBtn.titleLabel?.text == "Selesai" {
            hiddenComponent()
            editBtn.setTitle("Edit", for: .normal)
        } else {
            showHiddenComponent()
            editBtn.setTitle("Selesai", for: .normal)
        }
    }
    
    @IBAction func editImagePressed(_ sender: Any) {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self

            present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.photoProfile.image = image
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func hiddenComponent() {
        editImgBtn.isHidden = true
        editNameBtn.isHidden = true
    }
    
    func showHiddenComponent() {
        editImgBtn.isHidden = false
        editNameBtn.isHidden = false
    }

}
