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

func makeDigitalCardModel() -> DigitalCardModel {
    return DigitalCardModel(id: "any_id",
                            name: "any_name",
                            cardNumber: "any_name",
                            cardExpirationDate: "any_date",
                            cardFunction: "any_funtion",
                            cvc: "any_cvc")
}


func makeUserDataReponse() -> UserData {
    return [
        UserDataModel(username: "Edgar Arlindo",
                      totalBalance: 42569.6,
                      userImageURL: "any_url.com",
                      balanceIsHidden: true,
                      isNotifying: false,
                      bankBranch: "0008",
                      bankAccountNumber: "345876989",
                      bankNumber: "512",
                      corporateName: "IT Soluções bancarias S.A",
                      services: [
                        Service(serviceIconURL: "anyIconUrl.com", serviceName: "Área pix", serviceTag: 0),
                        Service(serviceIconURL: "anyIconUrl.com", serviceName: "Depositar", serviceTag: 1)
                      ],
                      resources: [
                        Resource(applogoURL: "anyUrl", resourceDescription: "Description 123 test", resourceId: "1"),
                        Resource(applogoURL: "anyUrl", resourceDescription: "123 test Description", resourceId: "2")
                      ],
                      adresses: [
                        Adress(streetAddress: "Rua dos bobos", city: "Sao Paulo", state: "SP", number: "0", zipCode: "12345678")
                      ])
    ]
}

func makeUserCardsResponse() -> UserCards {
    return [
        UserCard(isVirtual: true,
                     balance: 530,
                     cardFlag: "Mastercard",
                     cardTag: 1,
                     cardBrandImageURL: "anyImageUrl.com",
                     cardNumber: "1234 1234 1234 1246",
                     cardExpirationDate: "2032-07-15 06:34:22",
                     cardFunction: "Débito e crédito",
                     cvc: "345",
                     id: "any_id",
                     name: "any_name")
    ]
}
