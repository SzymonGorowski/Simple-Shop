import Foundation

final class UserDetailsViewViewModel {
    @Published var isChecked = false
    
    func saveCustomerDataInKeychain(_ customer: Customer) {
        let keychain = CustomerDataKeychain()
        do {
            try keychain.store(customer)
            print("✅: Customer data stored in the Keychain")
        } catch {
            print("❌: Error when storing in the Keychain -> \(error.localizedDescription)")
        }
    }
    
    func isEmailValid(_ email: String?) -> Bool {
        guard let email else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func areNameAndAddressNotEmpty(_ name: String?, _ address: String?) -> Bool {
        guard let name,
              let address else {
            return false
        }
        
        return !name.isEmpty && !address.isEmpty
    }
    
    func isPhoneNumberValid(_ number: String?) -> Bool {
        guard let number else { return false }
        return number.count >= 8 && number.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil
    }
}
