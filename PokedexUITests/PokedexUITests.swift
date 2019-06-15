//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Marielle Wronka on 15/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import XCTest

class PokedexUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UITests"]
        app.launch()
    }

    func testExample() {
        let cells = app.descendants(matching: .cell)
        let firstCell = cells.firstMatch
        firstCell.tap()
        
        XCTAssertTrue(app.otherElements["detailsView"].waitForExistence(timeout: 1))
    }

}
