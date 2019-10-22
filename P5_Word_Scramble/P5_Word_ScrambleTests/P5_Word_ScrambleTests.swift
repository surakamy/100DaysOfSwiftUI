//
//  P5_Word_ScrambleTests.swift
//  P5_Word_ScrambleTests
//
//  Created by Dmytro Kholodov on 10/22/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import XCTest
import SwiftUI

@testable import P5_Word_Scramble

class P5_Word_ScrambleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let sut = ContentView().body
        XCTAssertEqual(sut, Text("Hello World"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
