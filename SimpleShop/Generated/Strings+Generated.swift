// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum CartView {
    /// Your cart is empty. 
    /// Please check our new stuff!
    public static let emptyCartLabelTitle = Strings.tr("Localizable", "CartView.EmptyCartLabelTitle", fallback: "Your cart is empty. \nPlease check our new stuff!")
    /// Order
    public static let orderButtonTitle = Strings.tr("Localizable", "CartView.OrderButtonTitle", fallback: "Order")
  }
  public enum ConfirmOrderView {
    public enum AddressLabel {
      /// Address
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.AddressLabel.Title", fallback: "Address")
    }
    public enum ConfirmButton {
      /// Confirm
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.ConfirmButton.Title", fallback: "Confirm")
    }
    public enum DeliveryMethodsLabel {
      /// Pick a delivery method:
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.DeliveryMethodsLabel.Title", fallback: "Pick a delivery method:")
    }
    public enum EmailLabel {
      /// Email
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.EmailLabel.Title", fallback: "Email")
    }
    public enum NameLabel {
      /// Name
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.NameLabel.Title", fallback: "Name")
    }
    public enum PaymentMethodsLabel {
      /// Pick a payment method:
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.PaymentMethodsLabel.Title", fallback: "Pick a payment method:")
    }
    public enum PhoneNumberLabel {
      /// Phone Number
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.PhoneNumberLabel.Title", fallback: "Phone Number")
    }
    public enum TableView {
      /// List of products:
      public static let header = Strings.tr("Localizable", "ConfirmOrderView.TableView.Header", fallback: "List of products:")
    }
    public enum UserDetailsLabel {
      /// User Details:
      public static let title = Strings.tr("Localizable", "ConfirmOrderView.UserDetailsLabel.Title", fallback: "User Details:")
    }
  }
  public enum ConfirmOrderViewController {
    /// Confirm Order
    public static let navigationTitle = Strings.tr("Localizable", "ConfirmOrderViewController.NavigationTitle", fallback: "Confirm Order")
  }
  public enum DashboardTabView {
    public enum AccountTab {
      /// Account
      public static let navigationTitle = Strings.tr("Localizable", "DashboardTabView.AccountTab.NavigationTitle", fallback: "Account")
    }
    public enum CartTab {
      /// Cart
      public static let navigationTitle = Strings.tr("Localizable", "DashboardTabView.CartTab.NavigationTitle", fallback: "Cart")
    }
    public enum CategoryTab {
      /// Categories
      public static let navigationTitle = Strings.tr("Localizable", "DashboardTabView.CategoryTab.NavigationTitle", fallback: "Categories")
    }
    public enum DiscountsTab {
      /// Discounts
      public static let navigationTitle = Strings.tr("Localizable", "DashboardTabView.DiscountsTab.NavigationTitle", fallback: "Discounts")
    }
  }
  public enum DeliveryMethod {
    public enum FastDelivery {
      /// Fast Delivery 🏎️
      public static let title = Strings.tr("Localizable", "DeliveryMethod.FastDelivery.Title", fallback: "Fast Delivery 🏎️")
    }
    public enum PersonalCollection {
      /// Personal Collection 📦
      public static let title = Strings.tr("Localizable", "DeliveryMethod.PersonalCollection.Title", fallback: "Personal Collection 📦")
    }
    public enum StandardDelivery {
      /// Standard Delivery 🚚
      public static let title = Strings.tr("Localizable", "DeliveryMethod.StandardDelivery.Title", fallback: "Standard Delivery 🚚")
    }
  }
  public enum OrderConfirmationView {
    public enum ConfirmButton {
      /// Close
      public static let title = Strings.tr("Localizable", "OrderConfirmationView.ConfirmButton.Title", fallback: "Close")
    }
    public enum ConfirmTextLabel {
      /// Order has been placed
      public static let title = Strings.tr("Localizable", "OrderConfirmationView.ConfirmTextLabel.Title", fallback: "Order has been placed")
    }
  }
  public enum OrderConfirmationViewController {
    /// Order placed!
    public static let navigationTitle = Strings.tr("Localizable", "OrderConfirmationViewController.NavigationTitle", fallback: "Order placed!")
  }
  public enum PaymentMethod {
    public enum BankTransfer {
      /// Bank Transfer
      public static let title = Strings.tr("Localizable", "PaymentMethod.BankTransfer.Title", fallback: "Bank Transfer")
    }
    public enum Blik {
      /// Blik 💸
      public static let title = Strings.tr("Localizable", "PaymentMethod.Blik.Title", fallback: "Blik 💸")
    }
    public enum Cash {
      /// Cash 💵
      public static let title = Strings.tr("Localizable", "PaymentMethod.Cash.Title", fallback: "Cash 💵")
    }
  }
  public enum PersonalDetailView {
    public enum Alert {
      /// OK
      public static let buttonTitle = Strings.tr("Localizable", "PersonalDetailView.Alert.ButtonTitle", fallback: "OK")
      /// Your data has been updated
      public static let message = Strings.tr("Localizable", "PersonalDetailView.Alert.Message", fallback: "Your data has been updated")
      /// Done
      public static let title = Strings.tr("Localizable", "PersonalDetailView.Alert.Title", fallback: "Done")
    }
    public enum UpdateButton {
      /// Update
      public static let title = Strings.tr("Localizable", "PersonalDetailView.UpdateButton.Title", fallback: "Update")
    }
  }
  public enum ProductDetailView {
    /// Add to cart
    public static let addToCartButtonTitle = Strings.tr("Localizable", "ProductDetailView.AddToCartButtonTitle", fallback: "Add to cart")
    /// Category: 
    public static let category = Strings.tr("Localizable", "ProductDetailView.Category", fallback: "Category: ")
    /// Description: 
    /// 
    public static let description = Strings.tr("Localizable", "ProductDetailView.Description", fallback: "Description: \n")
  }
  public enum UserDetailsView {
    /// User Details
    public static let navigationTitle = Strings.tr("Localizable", "UserDetailsView.NavigationTitle", fallback: "User Details")
    public enum AddressTextField {
      /// Address
      public static let placeholder = Strings.tr("Localizable", "UserDetailsView.AddressTextField.Placeholder", fallback: "Address")
    }
    public enum Alert {
      /// OK
      public static let buttonTitle = Strings.tr("Localizable", "UserDetailsView.Alert.ButtonTitle", fallback: "OK")
      /// Please fill data accordingly
      public static let message = Strings.tr("Localizable", "UserDetailsView.Alert.Message", fallback: "Please fill data accordingly")
      /// Error
      public static let title = Strings.tr("Localizable", "UserDetailsView.Alert.Title", fallback: "Error")
    }
    public enum CheckboxLabel {
      /// Confirmation of reading Privacy Policy
      public static let title = Strings.tr("Localizable", "UserDetailsView.CheckboxLabel.Title", fallback: "Confirmation of reading Privacy Policy")
    }
    public enum ContinueButton {
      /// Continue
      public static let title = Strings.tr("Localizable", "UserDetailsView.ContinueButton.Title", fallback: "Continue")
    }
    public enum EmailTextField {
      /// Email
      public static let placeholder = Strings.tr("Localizable", "UserDetailsView.EmailTextField.Placeholder", fallback: "Email")
    }
    public enum NameTextField {
      /// Name
      public static let placeholder = Strings.tr("Localizable", "UserDetailsView.NameTextField.Placeholder", fallback: "Name")
    }
    public enum PhoneTextField {
      /// Phone Number (8 digits)
      public static let placeholder = Strings.tr("Localizable", "UserDetailsView.PhoneTextField.Placeholder", fallback: "Phone Number (8 digits)")
    }
  }
  public enum UserInfoView {
    public enum NameLabel {
      /// Hello, %@
      public static func title(_ p1: Any) -> String {
        return Strings.tr("Localizable", "UserInfoView.NameLabel.Title", String(describing: p1), fallback: "Hello, %@")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
