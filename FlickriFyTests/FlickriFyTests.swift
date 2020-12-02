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
        // on app launch , show loading indicator
        XCTAssertEqual(viewModel.isLoading, true)
        // on app launch , make the default photo limit = 20
        XCTAssertEqual(viewModel.numOfSelectedPhotos, 20)
        // on app launch , hide picker
        XCTAssertEqual(viewModel.isPhotoPickerVisible, false)
        XCTAssertEqual(viewModel.isFilterPickerVisible, false)
        // on app launch , make the filter start as view
        XCTAssertEqual(viewModel.filterSelected, FilterPicker.views)
        // on app launch , hide picker
        XCTAssertEqual(viewModel.isPickerVisible, false)
        // make sure the api key does not change
        let api_key = NetworkingManager.shared.api_key
        
        XCTAssertEqual(ProcessInfo.processInfo.environment["api_key"], api_key)
        
        
    }
}
