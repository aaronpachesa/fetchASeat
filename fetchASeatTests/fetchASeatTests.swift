//
//  fetchASeatTests.swift
//  fetchASeatTests
//
//  Created by Aaron Pachesa on 5/13/21.
//

import XCTest
@testable import fetchASeat


class loadTest: XCTestCase {
    
    func testLoadIt() {
        
        let EVM = EventViewModel()
        let MV = MainView()
        
        EVM.loadIt()
        
//        let result = EVM.events
//        let result = [Event]()
        var result = MV.eventViewModel.events.count
        print("result is \(result)")
        if result > 0 {
            result = 1
        }
        
        print(result)
        
        XCTAssertEqual(result, 1)
    }

}
