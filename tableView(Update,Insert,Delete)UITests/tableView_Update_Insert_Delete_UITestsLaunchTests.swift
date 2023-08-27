//
//  tableView_Update_Insert_Delete_UITestsLaunchTests.swift
//  tableView(Update,Insert,Delete)UITests
//
//  Created by Ahmed Fathi on 31/07/2023.
//

import XCTest

final class tableView_Update_Insert_Delete_UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
