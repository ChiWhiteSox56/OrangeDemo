//
//  LandingScreen.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

class LandingScreen: BaseScreen {
    
    // strings
    let accIdLogInButton: String = "btnLogIn"
    let accIdCreateAccountButton: String = "btnCreateAccount"
    let accIdEmailTextField: String = "txtFieldEmail"
    let accIdPasswordTextField: String = "txtFieldPassword"
    
    let txtEmailExpired: String = "expired.enrollment@yahoo.com"
    let txtEmailValid: String = "valid.email@yahoo.com"
    let txtEmailValidRandom: String = "\(Int(arc4random_uniform(100000)))test@yahoo.com"
    let txtEmailIncorrect: String = "incorrect.email@yahoo.com"
    let txtEmailInvalid: String = "invalid@email."
    let txtEmailLockedOut: String = "locked.noaccess@yahoo.com"
    
    let txtPasswordDefault: String = "password123"
    let txtPasswordValid: String = "qwerty"
    let txtPasswordIncorrect: String = "asdf"

    
    // must declare lazy variables here because property initializers run before 'self' is available
    lazy var btnLogIn = buttons["btnLogIn"].firstMatch
    lazy var btnCreateAccount = buttons["btnCreateAccount"].firstMatch
    lazy var buttons = findAll(.button)
    
    
    // verify that Log In / Create Account screen is displayed
    func logInCreateAccountSceenIsDisplayed() -> Bool {
        return waitForElementToAppear(waitForElement: btnLogIn) && waitForElementToAppear(waitForElement: btnCreateAccount)
    }
    
    // tap the 'Log In' button on the Log In / Create Account screen
    @discardableResult func tapBtnLogIn() -> LandingScreen {
        if waitForElementToAppear(waitForElement: btnLogIn, waitForSeconds: 20) {
            btnLogIn.tap()
        }
        return self
    }
    
    // tap the 'Create Account' button on the Log In / Create Account screen
    @discardableResult func tapBtnCreateAccount() -> LandingScreen {
        if waitForElementToAppear(waitForElement: btnCreateAccount) {
            btnCreateAccount.tap()
        }
        return self
    }
}
