import Foundation
import Domain

func makeUrl() -> URL {
    return URL(string: "any_url.com")!
}

func makeObjectCacheKey() -> String? {
    return "anyChacheKey"
}

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Edgar\"}".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeAccountModel() -> AccountModel {
    return AccountModel(accessToken: "any_token")
}

func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(email: "any_email@gmail.com", password: "any_password")
}

func makeUserModel() -> UserModel {
        return [UserModelElement(
        username: "Edgar",
        totalBalance: 3530.45,
        userImageURL: "https://anyUrl.com",
        balanceIsHidden: true,
        isNotifying: false
        , bankBranch: "",
        bankAccountNumber: "",
        bankNumber: "",
        corporateName: "",
        cards: [
            Card(name: "rodolfo",
                 isVirtual: true,
                 balance: 530,
                 cardFlag: "Mastercard",
                 cardTag: 1,
                 cardBrandImageURL: "anyImageUrl.com",
                 cardNumber: "3847890945671246",
                 cardExpirationDate: "2032-04-12 23:14:26",
                 cardFunction: "Débito e crédito",
                 cvc: "345"
            )],
        mainServices: [
            MainService(serviceIconURL: "anyIconUrl.com", serviceName: "Área pix", serviceTag: 0),
            MainService(serviceIconURL: "anyIconUrl.com", serviceName: "Depositar", serviceTag: 1)
        ],
        resources: [
            Resource(applogoURL: "anyUrl", resourceDescription: "Description 123 test"),
            Resource(applogoURL: "anyUrl", resourceDescription: "123 test Description")
        ]
    )]
}

func makePersonModel() -> PersonData {
    return PersonData(bankBranch: "", bankAccountNumber: "", bankNumber: "", corporateName: "", adresses: [])
}
