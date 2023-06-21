import Foundation
import Domain
import Data
import Presentation
import Infra

public let contactListFactory: (Double) -> ContactListToTransferController = { currencyValue in
    let localData = makeLocalFetchData(forResource: "contactList", withExtension: "json")
    let contactList = LocalFetchContactList(httpClient: localData)
    let controller = makeContactListControllerFactory(contactList: contactList, currencyValue: currencyValue)
    return controller
}
