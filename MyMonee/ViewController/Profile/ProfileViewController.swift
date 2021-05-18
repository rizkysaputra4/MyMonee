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
        loadImage()
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
            let imageUrl = self.getImgUrlFromLocal()!
            userData.user.name = textField?.text ?? userData.user.name
            self.saveImgUrlToLocal(imgURL: imageUrl)
            self.viewDidLoad()
            self.hideOrShowBtn()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            encodeAndSaveToLocal(data: userData)
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
        
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let data = try? Data(contentsOf: imagePath) 
        self.photoProfile.image = UIImage(data: data!)
        
        saveImgUrlToLocal(imgURL: imagePath.absoluteString)
        
        dismiss(animated: true)
    }
    
    func loadImage() {
        
        guard let imgStringUrl = getImgUrlFromLocal() else {
            print("url from userdefault")
            return setDefaultPhotoProfile()
        }
        
        guard let imgUrl = URL(string: imgStringUrl) else {
            print("url parsing")
            return setDefaultPhotoProfile()
        }
        
        guard let data = try? Data(contentsOf: imgUrl) else {
            print("get image")
            return setDefaultPhotoProfile()
        }
        
        self.photoProfile.image = UIImage(data: data)
    }
    
    func getImgUrlFromLocal() -> String? {
        let persist = PersistData()
        let imgStringUrlOp: String? = persist.readValue(forKey: .avatarData, userID: userData.user.name)
        
        return imgStringUrlOp
    }
    
    func saveImgUrlToLocal(imgURL: String) {
        let persist = PersistData()
        persist.saveValue(forKey: .avatarData, value: imgURL, userID: userData.user.name)
    }
    
    func setDefaultPhotoProfile() {
        self.photoProfile.image = UIImage(named: "default_pp")
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
