//
//  CreateAccountTests.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

class CreateAccountTests: BaseTest {
    
    // retrieve raw value of any Log In error type that can be handled by automated tests
    enum CreateAccountErrorTypes: String {
        case errorExistingAccount = "An account with this email address already exists"
        case errorInvalidEmail = "Please enter a valid email address"
        case errorMismatchedPasswords = "Passwords do not match"
        case errorUncheckedTOC = "You must agree to the Terms and Conditions"
    }
    
    // verify that entering valid credientials and agreeing to TOC, then tapping 'Create Account', takes user to the 'Enrollments' screen
    func testCreateAccountIsSuccessfulWithValidUserCredentials() {
        landingScreen.tapBtnCreateAccount()
        
        createAccountScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailValidRandom)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordDefault)
            .enterUserPasswordConfirmationInConfirmPasswordTextField(app: app, userPassword: landingScreen.txtPasswordDefault)
            .tapCkboxTermsOfService()
            .dismissKeyboard(app: app)
            .tapBtnCreateAccount()
        
        XCTAssert(mainMenuScreen.mainMenuScreenIsDisplayed(selection: enrollmentSampleCourseTwo.mainMenuStudyPlan), "The 'Main Menu' screen is displayed after the user successfully creates an account")
        
        mainMenuScreen.tapMainMenuBackBtn()
        enrollmentsScreen.logOutOfAppFromEnrollmentsScreen()
        testRanToCompletion = true
    }
    
    // verify that valid email and valid password (no confirmation password) activates 'Create Account' button
    func testCreateAccountButtonEnabledWithValidEmailAndPassword() {
        landingScreen.tapBtnCreateAccount()
        
        XCTAssertFalse(createAccountScreen.createAccountButtonIsEnabled(), "The 'Create Account' button is disabled when no fields have been populated")
        
        createAccountScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailValidRandom)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordDefault)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordDefault)
        
        XCTAssert(createAccountScreen.createAccountButtonIsEnabled(), "The 'Create Account' button is enabled when the 'Email' and 'Password' fields have been populated")
        testRanToCompletion = true
    }
    
    // verify that tapping the 'Terms of Service' button displays the 'Terms of Service' webview
    func testTermsOfServiceOpensAppropriateWebview() {
        landingScreen.tapBtnCreateAccount()
        
        createAccountScreen.tapBtnTermsOfService()
        
        XCTAssert(createAccountScreen.termsOfServiceWebviewIsDisplayed(app: app), "The 'Terms of Service' web content is displayed on the screen")
        
        createAccountScreen.tapWebviewBtnDone(app: app)
        XCTAssert(createAccountScreen.createAccountScreenIsDisplayed(), "The 'Create Account' screen is displayed")
        testRanToCompletion = true
    }
    
    // enter invalid email, matching valid passwords, checked Terms of Service; verify that the following error is displayed:
    // - Please enter a valid email address
    func testInvalidEmailAddress() {
        landingScreen.tapBtnCreateAccount()
        
        let createAccountScreen = CreateAccountScreen()
            .enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailInvalid)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .enterUserPasswordConfirmationInConfirmPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .tapCkboxTermsOfService()
            .dismissKeyboard(app: app)
            .tapBtnCreateAccount()
        
        XCTAssert(createAccountScreen.correctCreateAccountErrorIsDisplayed(errorText: "\(createAccountScreen.createAccountErrorPrefix)\(CreateAccountErrorTypes.errorInvalidEmail.rawValue)"), "The expected error for an invalid email address is displayed: '\(CreateAccountErrorTypes.errorInvalidEmail.rawValue)'")
        testRanToCompletion = true
    }
    
    // enter valid email, mismatched passwords, checked Terms of Service; verify that the following error is displayed:
    // - Passwords do not match
    func testMismatchedPasswords() {
        landingScreen.tapBtnCreateAccount()
        
        createAccountScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailValid)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .enterUserPasswordConfirmationInConfirmPasswordTextField(app: app, userPassword: landingScreen.txtPasswordIncorrect)
            .tapCkboxTermsOfService()
            .dismissKeyboard(app: app)
            .tapBtnCreateAccount()
        
        XCTAssert(createAccountScreen.correctCreateAccountErrorIsDisplayed(errorText: "\(createAccountScreen.createAccountErrorPrefix)\(CreateAccountErrorTypes.errorMismatchedPasswords.rawValue)"), "The expected error for an expired enrollment is displayed: '\(CreateAccountErrorTypes.errorMismatchedPasswords.rawValue)'")
        testRanToCompletion = true
    }
    
    // enter invalid email, matching valid passwords, checked Terms of Service; verify that the following error is displayed:
    // - You must agree to the Terms and Conditions
    func testTermsAndConditionsUnchecked() {
        landingScreen.tapBtnCreateAccount()
        
        createAccountScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailValid)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .enterUserPasswordConfirmationInConfirmPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .dismissKeyboard(app: app)
            .tapBtnCreateAccount()
        
        XCTAssert(createAccountScreen.correctCreateAccountErrorIsDisplayed(errorText: "\(createAccountScreen.createAccountErrorPrefix)\(CreateAccountErrorTypes.errorUncheckedTOC.rawValue)"), "The expected error for an expired enrollment is displayed: '\(CreateAccountErrorTypes.errorUncheckedTOC.rawValue)'")
        testRanToCompletion = true
    }
    
    // enter invalid email, mismatched passwords, unchecked Terms of Service; verify that the following errors are displayed:
    // - Please enter a valid email address
    // - Passwords do not match
    // - You must agree to the Terms and Conditions
    func testMultipleCreateAccountErrors() {
        landingScreen.tapBtnCreateAccount()
        
        createAccountScreen.enterUserEmailInEmailTextField(app: app, userEmail: landingScreen.txtEmailInvalid)
            .enterUserPasswordInPasswordTextField(app: app, userPassword: landingScreen.txtPasswordValid)
            .enterUserPasswordConfirmationInConfirmPasswordTextField(app: app, userPassword: landingScreen.txtPasswordIncorrect)
            .dismissKeyboard(app: app)
            .tapBtnCreateAccount()
        
        XCTAssertTrue(createAccountScreen.correctCreateAccountErrorIsDisplayedMultipleErrors(), "The expected error for an expired enrollment is displayed: '\(CreateAccountErrorTypes.errorInvalidEmail.rawValue)\(CreateAccountErrorTypes.errorMismatchedPasswords.rawValue)\(CreateAccountErrorTypes.errorUncheckedTOC.rawValue)'")
        testRanToCompletion = true
    }
}
