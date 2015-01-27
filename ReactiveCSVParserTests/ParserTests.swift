//
//  ParserTests.swift
//  ReactiveCSVParser
//
//  Created by Romain Pouclet on 2015-01-27.
//  Copyright (c) 2015 Perfectly-Cooked. All rights reserved.
//

import Cocoa
import XCTest

class ParserTests: XCTestCase {
    var fixtureFile: String?
    
    override func setUp() {
        super.setUp()
        
        fixtureFile = NSBundle(forClass: self.dynamicType).pathForResource("characters", ofType: "csv", inDirectory: "Fixtures")
    }
    
    override func tearDown() {
        fixtureFile = nil
        
        super.tearDown()
    }

    func testParsing() {
        let parser = Parser(path: fixtureFile!)
        let signal = parser.parse()
        
        var success: ObjCBool = true
        var parsingError: NSError?
        
        let lines = signal.collect().asynchronousFirstOrDefault(nil, success: &success, error: &parsingError) as Array<String>
        println("Resulting lines \(lines)")
        
        XCTAssertNotNil(lines, "Completed signal should not result in nil variable")
        XCTAssertTrue(success, "Parsing should be a success")
        XCTAssertNil(parsingError, "Parsing shoud not raise any error")
        XCTAssertEqual(countElements(lines), 20, "Parsing should retrieve 20 lines")
    }
}
