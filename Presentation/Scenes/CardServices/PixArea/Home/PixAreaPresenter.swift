import Foundation
import Domain

public final class PixAreaServicePresenter {
    private let router: PixAreaRoutingLogic
    
    public init (router: PixAreaRoutingLogic) {
        self.router = router
    }
}

extension PixAreaServicePresenter: ViewToPresenterPixAreaProtocol {
    public func getServicesCell() -> [Service] {
        let services = [Service(iconURL: Icons.Url.transfer, serviceName: "Transferir", serviceTag: 0),
                        Service(iconURL: Icons.Url.calendar, serviceName: "Programar", serviceTag: 1),
                        Service(iconURL: Icons.Url.copyPaste, serviceName: "Pix Copia e Cola", serviceTag: 2),
                        Service(iconURL: Icons.Url.qrCode, serviceName: "Ler QR code", serviceTag: 3)]
        return services
    }
    
    public func getNumberOfCells() -> Int {
        return 5
    }
    
    public func callPixServiceWith(tag: Int) {
        router.routeToServiceWith(tag: tag)
    }
}
