//
//  ClearPoolWaterUITestsLaunchTests.swift
//  ClearPoolWaterUITests
//
//  Created by Stanimir Hristov on 9.10.24.
//

import XCTest

final class ClearPoolWaterUITestsLaunchTests: XCTestCase {

    //    override class var runsForEachTargetApplicationUIConfiguration: Bool {
    //      true
    //    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testNestedView() throws {
        let app = XCUIApplication()
        app.launch()

        //Executes the action of tapping the button
        let goToNestedViewLink = app.buttons["NestedViewLink"]
        XCTAssertTrue(goToNestedViewLink.exists)
        goToNestedViewLink.tap()

        // Checks if you've navigated to the AboutUsView
        let aboutUsViewTitle = app.staticTexts["Nested"]
        XCTAssertTrue(aboutUsViewTitle.waitForExistence(timeout: 5))

        // Take screenshot ot NestedView
        let nestedViewAttachment = XCTAttachment(screenshot: app.screenshot())
        nestedViewAttachment.name = "Nested View"
        nestedViewAttachment.lifetime = .keepAlways
        add(nestedViewAttachment)

        // Go to back to main screen
        let backButton = app.buttons["Back"]
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        // Take screenshot ot Main screen
        let mainViewAttachment = XCTAttachment(screenshot: app.screenshot())
        mainViewAttachment.name = "Main View"
        mainViewAttachment.lifetime = .keepAlways
        add(mainViewAttachment)
    }
}
