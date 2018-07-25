# OrangeDemo
Demo of XCUITest code; no accompanying app code to protect intellectual property

All UI Tests are in the following folder: https://github.com/ChiWhiteSox56/OrangeDemo/tree/master/OrangeDemo/OrangeDemoUITests

The following code is a variation of an XCUITest test suite that I wrote for an app that ultimate did not launch. The initial test suite was much larger, but for the sake of simplicity I included only the following: 
- Base Test (SetUp, TearDown, Object Repository)
- Base Screen (findAll, waitForElementToAppear)
- A common component class (alert)
- Test classes for Log In and Create Account
- Page classes for Log In, Create Account, and landing page with both options 

All credits attributed to an individual or company's code are preceded by "//MARK : " in the code base. They are listed below as well:

1. Alex Ilyenko's Blog
- "Page Object in XCTest UI Tests"
- Concept of Base Screen protocol with findAll extension

2. Masilotti.com
- "Waiting in XCTest"
- http://masilotti.com/xctest-waiting/
- Code for waiting for an element to appear on screen

3. stackoverflow.com
- "Using Predicates in Swift"
- https://stackoverflow.com/questions/24176605/using-predicate-in-swift
- Tactic for locating elements when identifying them by label or accessibility identifier is impossible or inconvenient
- Use in cases where text to be returned for comparison is longer than 128 characters
