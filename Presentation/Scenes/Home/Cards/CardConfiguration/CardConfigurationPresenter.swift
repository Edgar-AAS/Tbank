import Foundation
import Domain

public class CardConfigurationPresenter {
    public let validation: Validation
    public let addDigitalCard: AddCard
    public let alertView: AlertView
    public let loadingView: LoadingView
    public let router: CardConfigurationRouterLogic
    
    public init(validation: Validation, addDigitalCard: AddCard, alertView: AlertView, loadingView: LoadingView, router: CardConfigurationRouterLogic) {
        self.validation = validation
        self.addDigitalCard = addDigitalCard
        self.alertView = alertView
        self.loadingView = loadingView
        self.router = router
    }
    
    public func createDigitalCard(cardConfigurationRequest: CardConfigurationRequest) {
        if let message = validation.validate(data: cardConfigurationRequest.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.isLoading(viewModel: LoadingViewModel(isLoading: true))
            guard let name = cardConfigurationRequest.name else { return }
            let digitalCardModel = DigitalCardModel(id: nil, name: name,
                                                    cardNumber: CardGenerator.createCardNumber(),
                                                    cardExpirationDate: CardGenerator.createCardExpirationDate(),
                                                    cardFunction: CardGenerator.getCardFunction(cardFunction: .hybridCard),
                                                    cvc: CardGenerator.createCVC())
            addDigitalCard.add(cardModel: digitalCardModel) { [weak self] (result) in
                guard self != nil else { return }
                switch result {
                case .success:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self?.router.goToCardSuccessScreen(digitalCardModel: digitalCardModel)
                        self?.loadingView.isLoading(viewModel: LoadingViewModel(isLoading: false))
                    }
                case .failure(let error):
                    switch error {
                    case .unexpected:
                        self?.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na criação do cartão digital", message: "Tente novamente em instantes."))
                    default: return
                    }
                }
            }
        }
    }
}
