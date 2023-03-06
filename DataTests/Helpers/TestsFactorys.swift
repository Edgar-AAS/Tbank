import Foundation
import Domain

func makeUrl() -> URL {
    return URL(string: "any_url.com")!
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

func makeLoginModels() -> [LoginModel] {
    return [LoginModel(email: "any_email@gmail.com", password: "123"),
            LoginModel(email: "any_email@gmail.com", password: "123"),
            LoginModel(email: "any_email@gmail.com", password: "123")]
}

func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(email: "any_email@gmail.com", password: "any_password")
}
