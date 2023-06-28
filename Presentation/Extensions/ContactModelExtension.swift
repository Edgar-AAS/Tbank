import Foundation
import Domain

extension ContactModel {
    var getContactModelFormatted: ContactModel {
        .init(name: name,
              cpf: cpf.formatCPF(),
              cnpj: cnpj,
              email: email,
              phoneNumber: phoneNumber,
              bankAccountNumber: bankAccountNumber,
              bankBranch: bankBranch)
    }
}
