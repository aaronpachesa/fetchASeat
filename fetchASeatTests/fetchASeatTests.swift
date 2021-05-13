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
        let result = MV.eventViewModel.events[0].id
        
        print(result)
        
        XCTAssertEqual(result, as? Int)
    }

}
