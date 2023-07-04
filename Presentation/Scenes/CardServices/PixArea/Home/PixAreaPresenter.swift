import Foundation
import Domain

public final class PixAreaServicePresenter {
    private let router: PixAreaRoutingLogic
    private weak var cellsDataSource: UpdatePixAreaListCellsProtocol?
    
    public init (router: PixAreaRoutingLogic, cellsDataSource: UpdatePixAreaListCellsProtocol) {
        self.router = router
        self.cellsDataSource = cellsDataSource
    }
}

extension PixAreaServicePresenter: ViewToPresenterPixAreaProtocol {
    public func fetchPixServices() {
        let sendServiceViewModels: [ServiceViewModel] = [
            .init(iconURL: Icons.Url.transfer, serviceName: "Transferir", serviceTag: 0),
            .init(iconURL: Icons.Url.calendar, serviceName: "Programar", serviceTag: 1),
            .init(iconURL: Icons.Url.copyPaste, serviceName: "Pix Copia e Cola", serviceTag: 2),
            .init(iconURL: Icons.Url.qrCode, serviceName: "Ler QR code", serviceTag: 3)
        ]
        
        let receiveServiceViewModels: [ServiceViewModel] = [
            .init(iconURL: Icons.Url.demand, serviceName: "Cobrar", serviceTag: 0),
            .init(iconURL: Icons.Url.deposit, serviceName: "Depositar", serviceTag: 1)
        ]
        
        let pixAreaListCellDataSource: [PixAreaCellsType] = [
            .pixAreaDescription,
            .sendTitle,
            .sendServices(sendServiceViewModels),
            .receiveTitle,
            .receiveServices(receiveServiceViewModels)
        ]
        
        cellsDataSource?.updatePixAreaCellsWith(dataSource: pixAreaListCellDataSource)
    }
    
    public func callPixServiceWith(tag: Int) {
        router.routeToServiceWith(tag: tag)
    }
}
