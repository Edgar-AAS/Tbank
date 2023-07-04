import UIKit
import Domain

public final class ProfileController: UITableViewController {
    public var header: ProfileHeader?
    
    public var presenter: ViewToProfilePresenterProtocol?
    private var personalDataViewModel: [PersonalDataViewModel] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewProperties()
        setupHeader()
        presenter?.fetchPersonalUserInfo()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    private func setupHeader() {
        header = ProfileHeader(self)
        header?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: HeaderHeights.large)
        header?.userPhotoImageView.loadImageWith(path: FileManagerPaths.getPathFor(pathType: .userImage))
        tableView.tableHeaderView = header
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
    
    private func setupTableViewProperties() {
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PersonalCell.self, forCellReuseIdentifier: PersonalCell.reuseIdentifier)
        tableView.backgroundColor = Colors.primaryColor
    }
}

//MARK: - UITableViewDataSource
extension ProfileController {
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Minha Conta"
        default:
            return ""
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = getPersonalDataCell(with: personalDataViewModel, indexPath: indexPath)
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalDataViewModel.count
    }
}

//MARK: - ProfileController Cells
extension ProfileController {
    func getPersonalDataCell(with viewModel: [PersonalDataViewModel], indexPath: IndexPath) -> PersonalCell {
        let personalCell = tableView.dequeueReusableCell(withIdentifier: PersonalCell.reuseIdentifier, for: indexPath) as! PersonalCell
        personalCell.configureCellWith(viewModel: viewModel[indexPath.row])
        return personalCell
    }
}

//MARK: - UITableViewDelegate
extension ProfileController {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as?  UIImage {
            header?.userPhotoImageView.image = editedImage
            writeImage(image: editedImage, imageName: FileManagerPaths.userImageName)
        } else if let originalImage = info[.originalImage] as? UIImage {
            header?.userPhotoImageView.image = originalImage
            writeImage(image: originalImage, imageName: FileManagerPaths.userImageName)
        }
        
        if let homeController = navigationController?.viewControllers.last(where: { $0 is HomeControllerProtocol}) {
            (homeController as? HomeControllerProtocol)?.isNeedUpdateProfile = true
        }
        dismiss(animated: true)
    }
    
    private func writeImage(image: UIImage, imageName: String) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = path.appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 1.0) {
            try? jpegData.write(to: imagePath)
        }
    }
}

//MARK: - Update Profile cells
extension ProfileController: UpdateProfileListCellsProtocol {
    public func updateProfileCellsWith(profileListDataSource: [PersonalDataViewModel], personalHeaderDataSource: ProfileInfoViewModel) {
        self.personalDataViewModel = profileListDataSource
        self.header?.configureHeaderWith(viewModel: personalHeaderDataSource)
        tableView.reloadData()
    }
}

//MARK: - Delegate actions
extension ProfileController: ProfileHeaderDelegateProtocol {
    public func userPhotoImageDidTapped() {
        self.selectSource()
    }
}
