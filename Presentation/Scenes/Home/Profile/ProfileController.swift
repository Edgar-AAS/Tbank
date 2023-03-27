import UIKit

public final class ProfileController: UITableViewController  {
    var header: ProfileHeader?
    
    public override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseIdentifier)
        header = ProfileHeader(self)
        let path = getDocumentsDirectory().appendingPathComponent("userImage")
        header?.userPhotoImageView.image = UIImage(contentsOfFile: path.path)
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
    
    private func getDocumentsDirectory() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return url
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.width
    }
    
    let personInfos = ["Meu banco", "Meu número", "Meu email", "Dados pessoais", "Tarifas e taxas", "Meus endereços"]
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as? ProfileCell
        cell?.textLabel?.text = personInfos[indexPath.row]
        cell?.detailTextLabel?.text = "2211123"
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personInfos.count
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as?  UIImage {
            header?.userPhotoImageView.image = editedImage
            writeImage(image: editedImage, imageName: "userImage")
        } else if let originalImage = info[.originalImage] as? UIImage {
            header?.userPhotoImageView.image = originalImage
            writeImage(image: originalImage, imageName: "userImage")
        }
        dismiss(animated: true)
    }
    
    private func writeImage(image: UIImage, imageName: String) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = path.appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 1) {
            try? jpegData.write(to: imagePath)
        }
    }
}

extension ProfileController: ProfileHeaderDelegateProtocol {
    public func userPhotoImageDidTapped() {
        self.selectSource()
    }
}
