//
//  BaseTest.swift
//
//  Modified by Cindy Michalowski on 7/24/18.
//  Copyright © 2018
//

import XCTest

class BaseTest: XCTestCase {
    
    let app = XCUIApplication()
    
    // page objects
    let logInScreen = logInScreen()
    let createAccountScreen = CreateAccountScreen()
    let landingScreen = LandingScreen()

    // common components
    let alert = AlertComponent()

    // if test fails, this flag is false and application exit is handled by TearDown()
    var testRanToCompletion: Bool = false
    
    
    override func setUp() {
    
        // use to track whether test ran to completion; saves time during tear down in cases where test fails
        testRanToCompletion = false
        
        // if an assertion fails in the course of running a test, test will stop
        continueAfterFailure = false
        
        // launch the app under test
        app.launch()
        
        // if the 'Back' button is displayed after launching app, Enrollments Page is displayed and previous test failed or user never logged out
        if navMenu.btnLogOutIsDisplayed() {
            navMenu.tapBtnLogOut()
            alert.tapButtonOnAlert(buttonText: "Yes")
        }
    }
    
    override func tearDown() {
        
        // if test fails, capture screenshot at point of failure; delete tearDown screenshot if test passes
        let screenshot = XCUIScreen.main.screenshot()
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
        fullScreenshotAttachment.lifetime = .deleteOnSuccess
        add(fullScreenshotAttachment)
        
        // in the event of a test failure, app needs to be exited gracefully to prevent all other tests from failing
        if testRanToCompletion == false {
            
            // if an external link warning is displayed, close it before attempting log out
            if wait(forElement: externalLinkWarning.btnGoBack, waitTimeout: 5) {
                externalLinkWarning.tapBtnGoBack()
            }
            
            // if 'Settings' screen is not reachable, tap the 'Back' button to make it accessible
            if wait(forElement: navMenu.btnBack, waitTimeout: 3) {
                navMenu.tapBtnBack()
            }
        
            // try to access 'Settings' screen first, then try to log out from 'Enrollments' screen
            if wait(forElement: navMenu.btnNavMenu, waitTimeout: 3) {
                navMenu.tapBtnNavMenu()
                    .btnSettings.tap()
                settingsScreen.tapBtnLogOut()
                alert.tapButtonOnAlert(buttonText: "Yes")
            }
        
            // before logging out from 'Enrollments' screen, back up from the 'Main Menu' screen if necessary
            if wait(forElement: mainMenuScreen.btnBack, waitTimeout: 3) {
                mainMenuScreen.tapMainMenuBackBtn()
            }
        
            if wait(forElement: enrollmentsScreen.btnLogOut, waitTimeout: 3) {
                if !enrollmentsScreen.enrollmentsScreenIsDisplayed(app: app) {
                    mainMenuScreen.tapMainMenuBackBtn()
                }
                enrollmentsScreen.logOutOfAppFromEnrollmentsScreen()
            }
        }
        
        // terminate app
        app.terminate()
    }
    
    
    // Enrollment Object Repository
    let enrollmentSampleCourseOne = SampleCourseOne()
    let enrollmentSampleCourseTwo = SampleCourseTwo()
    let enrollmentSampleCourseThree = SampleCourseThree()

    
    struct SampleCourseOne {
        let courseTitle: String = "Gardening for Beginners"
        let mainMenuLessonPlan: String = "Welcome!"
        let LessonPlanMenuContents: [String] = ["Get Started", "Choose Your Garden Location", "Balcony Gardening", "Upside-Down Gardening", "Rooftop Gardening", "Gardening Laws and Ordinances", "Vegetable Gardening Basics"]
    }
    
    struct SampleCourseTwo {
        let courseTitle: String = "Advanced Algorithms for Developers"
        let mainMenuLessonPlan: String = "Lesson Plan"
        let LessonPlanMenuContents: [String] = ["Sort Algorithms", "Search Algorithms", "Hashing", "Dynamic Programming", "String Matching and Parsing", "Exponentiation by Squaring"]
    }
    
    struct SampleCourseThree {
        let courseTitle: String = "Woodworking: A Beginners Guide"
        let mainMenuLessonPlan: String = "Schedule"
        let LessonPlanMenuContents: [String] = ["Before You Start", "Chopping Board / Serving Tray", "Shoe Organizer", "Wooden Bench", "Magazine Storage Boxes", "Spice Rack", "Knife Block", "Step Stool"]
    }
}
