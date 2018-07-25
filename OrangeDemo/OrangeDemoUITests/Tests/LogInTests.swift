//
//  LogInTests.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

class LogInTests: BaseTest {
    
    // retrieve raw value of any Log In error type that can be handled by automated tests
    enum LogInErrorTypes: String {
        case errorExpiredEnrollment = "Your enrollment has expired. To renew, please contact customer support at 1-800-555-HELP"
        case errorIncorrectUsernameOrPassword = "Incorrect username or password"
        case errorAccountLocked = "Your account has been locked for suspicious activity. Please check your email for a link to reset your password."
    }
    
    // verify that attempting to log in with an expired enrollment results in the display of the appropriate error
    func testExpiredEnrollmentLogIn() {
        let logInScreen = LogInScreen()
        .tapBtnLogIn()
            
        XCTAssertTrue(logInScreen.logInScreenIsDisplayed(app: app), "The 'Log In' screen is displayed")
            
        logInScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailExpired)
        .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordDefault)
        .dismissKeyboard(app: app)
        .tapBtnLogIn()

        XCTAssert(logInScreen.correctLogInErrorIsDisplayed(errorText: LogInErrorTypes.errorExpiredEnrollment.rawValue), "The expected error for an expired enrollment is displayed: '\(LogInErrorTypes.errorExpiredEnrollment.rawValue)'")
        testRanToCompletion = true
    }
    
    // verify that attempting to log in with an incorrect email or password results in the display of the appropriate error
    func testIncorrectEmailOrPasswordLogIn() {
        let logInScreen = LogInScreen()
            .tapBtnLogIn()
            
            XCTAssertTrue(logInScreen.logInScreenIsDisplayed(app: app), "The 'Log In' screen is displayed")
                
            logInScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailValid)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordDefault)
            .dismissKeyboard(app: app)
            .tapBtnLogIn()
        
        XCTAssert(logInScreen.correctLogInErrorIsDisplayed(errorText: LogInErrorTypes.errorIncorrectUsernameOrPassword.rawValue),  "The expected error for an incorrect email or password is displayed: '\(LogInErrorTypes.errorIncorrectUsernameOrPassword.rawValue)'")
        
            logInScreen.tapBtnLogIn()
            .enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailInvalid)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .dismissKeyboard(app: app)
            .tapBtnLogIn()
        
        XCTAssert(logInScreen.correctLogInErrorIsDisplayed(errorText: LogInErrorTypes.errorIncorrectUsernameOrPassword.rawValue),  "The expected error for an incorrect email or password is displayed: '\(LogInErrorTypes.errorIncorrectUsernameOrPassword.rawValue)'")
        testRanToCompletion = true
    }
    
    // verify that the 'Log In' button remains disabled if either the email field or the password field is empty
    func testLoginButtonNotEnabledIfEmailOrPasswordFieldIsEmpty() {
        let logInScreen = LogInScreen()
            .tapBtnLogIn()
            
            XCTAssertTrue(logInScreen.logInScreenIsDisplayed(app: app), "The 'Log In' screen is displayed")
                
            logInScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailValid)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: "")
            .dismissKeyboard(app: app)
            .tapBtnLogIn()
        
        XCTAssertFalse(app.buttons["btnLogIn"].isEnabled, "The 'Log In' button is disabled")
        
        logInScreen.tapBtnLogIn()
            .enterUserEmailInEmailTextField(app: app, userEmail: "")
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .dismissKeyboard(app: app)
            .tapBtnLogIn()
        
        XCTAssertFalse(app.buttons["btnLogIn"].isEnabled, "The 'Log In' button is disabled")
        testRanToCompletion = true
    }
    
    // verify that tapping the 'Back' button on the 'Log In' screen takes you back to the 'Log In / Create Account' page
    func testBackNavigationFromLogInScreenToLandingScreen() {
        LogInScreen().tapBtnLogIn()
        .tapBtnBack()

        XCTAssert(landingScreen.logInCreateAccountSceenIsDisplayed(), "The 'Log In / Create Account' screen is displayed after tapping the 'Back' button on the 'Log In' screen")
        testRanToCompletion = true
    }
}
