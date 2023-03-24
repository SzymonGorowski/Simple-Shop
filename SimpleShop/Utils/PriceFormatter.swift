import Foundation

final class PriceFormatter {
    /// convertPriceWithSeparator function is responsible for converting data received from API to price with separator and with currency format.
    /// - Parameters:
    /// - currencyCode: currency code has to be in ISO string format ie. "USD", "EUR" etc.
    /// - Returns: String with separator based on locale and proper currency code.
    static func convertPriceWithSeparator(_ price: Int, currencyCode: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        numberFormatter.currencyCode = currencyCode
        return numberFormatter.string(from: price as NSNumber)!
    }
}
