//
//  LogInScreen.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

class LogInScreen: BaseScreen {
    
    // must declare lazy variables here because property initializers run before 'self' is available
    lazy var buttons = findAll(.button)
    lazy var textFields = findAll(.textField)
    lazy var secureTextFields = findAll(.secureTextField)
    lazy var staticTexts = findAll(.staticText)
    
    lazy var txtFieldEmail = textFields["txtFieldEmail"].firstMatch
    lazy var txtFieldPassword = secureTextFields["txtFieldPassword"].firstMatch
    lazy var btnLogIn = buttons["btnLogIn"].firstMatch
    lazy var btnBack = buttons["Back"].firstMatch
    
    
    // verify that the 'Log In' screen is displayed
    func logInScreenIsDisplayed(app: XCUIApplication) -> Bool {
        return waitForElementToAppear(waitForElement: btnRememberMe)
    }
    
    // verify that the correct log in error is displayed
    func correctLogInErrorIsDisplayed(errorText: String) -> Bool {
        
        if waitForElementToAppear(waitForElement: staticTexts[errorText]) {
            return true
        }
        return false
    }
    
    // tap the 'Back' button
    @discardableResult func tapBtnBack() -> LogInScreen {
        btnBack.tap()
        return self
    }
    
    // tap the 'Return' key to dismiss the keyboard
    @discardableResult func dismissKeyboard(app: XCUIApplication) -> LogInScreen {
        app.buttons["return"].tap()
        return self
    }
    
    // enter user email in the 'Email' text field
    @discardableResult func enterUserEmailInEmailTextField(app: XCUIApplication, userEmail: String) -> LogInScreen {
        
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
    @discardableResult func enterUserPasswordInPasswordTextField(app: XCUIApplication, userPassword: String) -> LogInScreen {
        
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
    
    // tap the 'Log In' button on the 'Log In' screen
    @discardableResult func tapBtnLogIn() -> LogInScreen {
        if waitForElementToAppear(waitForElement: btnLogIn) {
            btnLogIn.tap()
        }
        return self
    }
    
    // use this in all tests to log into the app using valid credentials
    func logInWithValidCredentials(app: XCUIApplication, userEmail: String, userPassword: String) {
        tapBtnLogIn()
        enterUserEmailInEmailTextField(app: app, userEmail: userEmail)
        enterUserPasswordInPasswordTextField(app: app, userPassword: userPassword)
        if !btnLogIn.isHittable {
            dismissKeyboard(app: app)
        }
        tapBtnLogIn()
    }
}
