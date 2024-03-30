import XCTest
@testable import SwiftRouting

final class SwiftRoutingTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }

    // MARK: - Testing string extensions

    func testAddingQueryPrams() {
        let path = "/home"
        XCTAssert(path.addQueryParams(params: ["param": "value"]) == "/home?param=value", 
                  "not adding params correctly")
    }

    func testRemovingQueryParams() {
        let fullPath = "/home?param=value"
        XCTAssert("/home" == fullPath.removeQueryParams(), "not removing query params")
    }

    func testGettingParams() {
        let fullPath = "/home?param=value"
        XCTAssertEqual(fullPath.getQueryParams(), ["param": "value"], "not correctly getting query params")
    }

    func testIsValidURL() {
        let goodURL = "www.google.com"
        let badURL = "this is not a url"
        XCTAssertTrue(goodURL.isValidURL, "Not validating good urls correctly")
        XCTAssertFalse(badURL.isValidURL, "not validating bad urls correctly")
    }

    func testingOptionalStringExtension() {
        var testOpt: String?
        XCTAssertTrue(testOpt.isNilOrEmpty, "Not correctly assessing nil string")
        XCTAssertEqual(testOpt.orEmpty, "", "Not correctly returning emptyp for nil")
        testOpt = testOpt.orEmpty
        XCTAssertTrue(testOpt.isNilOrEmpty, "Not correctly assesing empty string")
        testOpt = "a non empty string"
        XCTAssertFalse(testOpt.isNilOrEmpty, "Not assesing full string correcly")
        XCTAssertEqual(testOpt.orEmpty, "a non empty string", "Not returning the correct value")
    }

}
