import UIKit

public final class ProfileController: UITableViewController  {
    var header: ProfileHeader?

    public override func viewDidLoad() {
        super.viewDidLoad()
        header = ProfileHeader(self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func selectSource() {
        let alert = UIAlertController(title: "Selecionar foto", message: "De onde você quer escolher a sua foto?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Tirar foto", style: .default, handler: { [weak self] _ in
                self?.selectPicture(sourceType: .camera)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Escolher na biblioteca", style: .default, handler: { [weak self] _ in
                self?.selectPicture(sourceType: .photoLibrary)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    private func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.width
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as?  UIImage {
            header?.userPhotoImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            header?.userPhotoImageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileController: ProfileHeaderDelegateProtocol {
    public func userPhotoImageDidTapped() {
        self.selectSource()
    }
}

