//
//  BaseScreen.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

// MARK: Credit: https://alexilyenko.github.io/xcuitest-page-object/
protocol BaseScreen {
}

extension BaseScreen {
    
    // MARK: Credit: https://alexilyenko.github.io/xcuitest-page-object/
    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        return XCUIApplication().descendants(matching: type)
    }
    
    // MARK: Credit: http://masilotti.com/xctest-waiting/
    // wait for a period of seconds (3 seconds is default) for an element to appear; can pass a timeout parameter to increase or decrease wait time
    @discardableResult func waitForElementToAppear(waitForElement element: XCUIElement, waitForSeconds timeout: TimeInterval = 3) -> Bool {
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: element)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
}
