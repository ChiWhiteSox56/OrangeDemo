//
//  CreateAccountScreen.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

class CreateAccountScreen: BaseScreen {
    
    // must declare lazy variables here because property initializers run before 'self' is available
    lazy var buttons = findAll(.button)
    lazy var checkboxes = findAll(.checkBox)
    lazy var textFields = findAll(.textField)
    lazy var secureTextFields = findAll(.secureTextField)
    lazy var staticTexts = findAll(.staticText)
    
    lazy var btnBack = buttons["Back"].firstMatch
    lazy var txtFieldEmail = textFields["txtFieldEmail"].firstMatch
    lazy var txtFieldPassword = secureTextFields["txtFieldPassword"].firstMatch
    lazy var txtFieldConfirmPassword = secureTextFields["txtFieldConfirmPassword"].firstMatch
    lazy var btnCreateAccount = buttons["CREATE ACCOUNT"].firstMatch
    lazy var btnTermsOfService = buttons["btnTermsOfService"].firstMatch
    lazy var ckboxTermsOfService = buttons["ckboxTermsOfService"].firstMatch
    lazy var webviewHeader = buttons["URL"].firstMatch
    lazy var txtFieldMultipleErrorsNoPrefix = staticTexts["Please correct the following error(s)\n - Please enter a valid email address\n - Passwords do not match\n - You must agree to the Terms and Conditions"]

    let createAccountErrorPrefix: String = "Please correct the following error(s)  - "
    
    
    // verify that the 'Create Account' screen is displayed
    func createAccountScreenIsDisplayed() -> Bool {
        return waitForElementToAppear(waitForElement: btnTermsOfService) && waitForElementToAppear(waitForElement: btnCreateAccount)
    }
    
    // tap the 'Back' button; often at the end of a test sequence, hence 'discardableResult'
    @discardableResult func tapBtnBack() -> CreateAccountScreen {
        btnBack.tap()
        return self
    }
    
    // tap the 'Return' key to dismiss the keyboard
    @discardableResult func dismissKeyboard(app: XCUIApplication) -> CreateAccountScreen {
        app.buttons["return"].tap()
        return self
    }
    
    // verify that the correct sign up error is displayed
    func correctCreateAccountErrorIsDisplayed(errorText: String) -> Bool {
        // this method cannot be used to test strings of a length greater than 128 characters (in the case of our tests, testMultipleCreateAccountErrors())
        // use correctCreateAccountErrorIsDisplayedLongString() instead
        print(errorText)
        return waitForElementToAppear(waitForElement: staticTexts["\(errorText)"])
    }
    
    // MARK: Credit: https://stackoverflow.com/questions/24176605/using-predicate-in-swift
    // verify that the correct sign up error is displayed for strings of 128 characters or longer
    func correctCreateAccountErrorIsDisplayedMultipleErrors() -> Bool {
        let txtMultErrorsInvalidEmail = staticTexts.matching(NSPredicate(format: "label CONTAINS 'email address'")).element(boundBy: 0).isHittable
        let txtMultErrorsPasswords = staticTexts.matching(NSPredicate(format: "label CONTAINS 'Passwords'")).element(boundBy: 0).isHittable
        let txtMultErrorsTermsOfService = staticTexts.matching(NSPredicate(format: "label CONTAINS 'Terms and Conditions'")).element(boundBy: 0).isHittable
        return txtMultErrorsInvalidEmail && txtMultErrorsPasswords && txtMultErrorsTermsOfService
    }
    
    // enter user email in the 'Email' text field
    func enterUserEmailInEmailTextField(app: XCUIApplication, userEmail: String) -> CreateAccountScreen {
        
        // text field elements are covered by buttons if field is not or has not been active; activate field - if button exists - before interaction
        if app.otherElements["Email"].exists {
            app.otherElements["Email"].tap()
        }
        
        if waitForElementToAppear(waitForElement: txtFieldEmail) {
            txtFieldEmail.tap()
            txtFieldEmail.clearAndTypeText(text: userEmail)
        }
        return self
    }
    
    // enter user password in the 'Password' text field
    @discardableResult func enterUserPasswordInPasswordTextField(app: XCUIApplication, userPassword: String) -> CreateAccountScreen {
        
        // text field elements are covered by buttons if field is not or has not been active; activate field - if button exists - before interaction
        if app.buttons["Password"].exists {
            app.buttons["Password"].tap()
        }
        
        if waitForElementToAppear(waitForElement: txtFieldPassword) {
            txtFieldPassword.tap()
            txtFieldPassword.clearAndTypeText(text: userPassword)
        }
        return self
    }
    
    // enter password confirmation in the 'Confirm Password' text field
    func enterUserPasswordConfirmationInConfirmPasswordTextField(app: XCUIApplication, userPassword: String) -> CreateAccountScreen {
        
        // text field elements are covered by buttons if field is not or has not been active; activate field - if button exists - before interaction
        if app.buttons["Confirm Password"].exists {
            app.buttons["Confirm Password"].tap()
        }
        
        if waitForElementToAppear(waitForElement: txtFieldConfirmPassword) {
            txtFieldConfirmPassword.tap()
            txtFieldConfirmPassword.clearAndTypeText(text: userPassword)
        }
        return self
    }
    
    // tap the 'Terms and Conditions' checkbox
    @discardableResult func tapCkboxTermsOfService() -> CreateAccountScreen {
        ckboxTermsOfService.tap()
        return self
    }
    
    // tap the 'Terms and Conditions' link to go to the 'Terms and Conditions' webview
    @discardableResult func tapBtnTermsOfService() -> CreateAccountScreen {
        btnTermsOfService.tap()
        return self
    }
    
    // verify that 'Create Account' button is enabled
    func createAccountButtonIsEnabled() -> Bool {
        return btnCreateAccount.isEnabled
    }
    
    // tap the 'Create Account' button; often at the end of a test sequence, hence 'discardableResult'
    @discardableResult func tapBtnCreateAccount() -> CreateAccountScreen {
        btnCreateAccount.tap()
        return self
    }
    
    // verify whether 'Terms of Service' webview is displayed
    @discardableResult func TermsOfServiceWebviewIsDisplayed(app: XCUIApplication) -> Bool {
        return waitForElementToAppear(waitForElement: webviewHeader)
    }
    
    func termsOfServiceWebviewIsDisplayed(app: XCUIApplication) -> Bool {
        return waitForElementToAppear(waitForElement: app.otherElements.staticTexts["TERMS AND CONDITIONS"], waitForSeconds: 20)
    }
    
    // tap 'Done' button in 'Terms of Service' webview
    func tapWebviewBtnDone(app: XCUIApplication) {
        app.otherElements.buttons["Done"].tap()
    }
}
