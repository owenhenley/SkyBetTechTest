//
//  BaseViewControllerTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 19/05/2019.
//

import XCTest
@testable import SkyBetTechTestiOS

class BaseViewControllerTests: XCTestCase {

    private var baseVC: BaseViewController?

    override func setUp() {
        baseVC = BaseViewController()
    }

    override func tearDown() {
        baseVC = nil
    }
}

// MARK: - handleActivityIndicatior(_ activityIndicatior:) tests
extension BaseViewControllerTests {
    func testHandleActivityIndicatiorStartsActivityIndicatorAnimation() {
        // Given
        guard let baseVC = baseVC else {
            XCTFail("test not set up correctly.")
            return
        }

        let expectedIndicator = UIActivityIndicatorView()
        expectedIndicator.stopAnimating()

        // When
        baseVC.handleActivityIndicator(expectedIndicator)

        // Then
        XCTAssertTrue(expectedIndicator.isAnimating == true)
    }

    func testHandleActivityIndicatiorStopsAnimationWhenCurrentlyAnimating() {
        // Given
        guard let baseVC = baseVC else {
            XCTFail("test not set up correctly.")
            return
        }

        let expectedIndicator = UIActivityIndicatorView()
        expectedIndicator.startAnimating()

        // When
        baseVC.handleActivityIndicator(expectedIndicator)

        // Then
        XCTAssertTrue(expectedIndicator.isAnimating == false)
    }

    // test the vc has a child indicatior view
    // Would need mocks

    // test the vc removed a child indicatior view
    // Would need mocks
}

// MARK: - showAlert(title:, message:, actionTitle:) tests
extension BaseViewControllerTests {
    // Would need mocks
}
