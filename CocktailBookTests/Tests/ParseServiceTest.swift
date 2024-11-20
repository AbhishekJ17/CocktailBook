//
//  ParseServiceTest.swift
//  CocktailBookTests
//
//  Created by Admin on 20/11/24.
//

import XCTest
@testable import CocktailBook

final class ParseServiceTest: XCTestCase {

    var parserStub: ParseServiceStub!
    
    override func setUpWithError() throws {
        super.setUp()
        parserStub = ParseServiceStub()
    }

    override func tearDownWithError() throws {
        parserStub = nil
        super.tearDown()
    }

    func testParse_withStubbedSuccess_returnsParsedData() throws {
        let expectedCocktails = [cockdetail1]
        parserStub.parseDataResult = .success(expectedCocktails)
        let result: [Cocktail] = try parserStub.parse(data: Data())
        XCTAssertEqual(result, expectedCocktails)
    }
    
    func testParse_withStubbedFailure_throwsParsingFailedError() {
        parserStub.parseDataResult = .failure(.parsingFailed)
        XCTAssertThrowsError(try parserStub.parse(data: Data()) as [Cocktail]) { error in
            XCTAssertEqual(error as? CocktailsAPIError, .parsingFailed)
        }
    }
    
}
