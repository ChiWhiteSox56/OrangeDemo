//
//  AlertComponent.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

class AlertComponent: BaseScreen {
    
    // must declare lazy variables here because property initializers run before 'self' is available
    lazy var alerts = findAll(.alert)
    lazy var buttons = findAll(.button)
    
    // check whether an alert is currently displayed
    func alertIsDisplayed(buttonText: String) -> Bool {
        return waitForElementToAppear(waitForElement: alerts.buttons[buttonText], waitForSeconds: 3)
    }
    
    // interact with an alert by tapping a specific button
    func tapButtonOnAlert(buttonText: String) {
        alerts.buttons[buttonText].firstMatch.tap()
    }
}
