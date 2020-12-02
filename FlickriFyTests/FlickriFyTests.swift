//
//  FlickriFyTests.swift
//  FlickriFyTests
//
//  Created by Tariq Almazyad on 11/30/20.
//

import XCTest
@testable import FlickriFy

class FlickriFyTests: XCTestCase {

    func testPhotoViewModel(){
        let viewModel = PhotosViewModel()
        
        XCTAssertEqual(viewModel.isLoading, true)
        
        XCTAssertEqual(viewModel.numOfSelectedPhotos, 20)
        
        XCTAssertEqual(viewModel.isPhotoPickerVisible, false)
        
        XCTAssertEqual(viewModel.isFilterPickerVisible, false)
        
        XCTAssertEqual(viewModel.filterSelected, FilterPicker.views)
        
        XCTAssertEqual(viewModel.isPickerVisible, false)
        
        let api_key = NetworkingManager.shared.api_key
        
        XCTAssertEqual(ProcessInfo.processInfo.environment["api_key"], api_key)
        
        
    }
    
   
}
