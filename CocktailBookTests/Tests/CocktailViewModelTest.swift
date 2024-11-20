//
//  CocktailViewModelTest.swift
//  CocktailBookTests
//
//  Created by Admin on 20/11/24.
//

import XCTest
@testable import CocktailBook
import Combine

final class CocktailViewModelTest: XCTestCase {
    
    var viewModel: CocktailViewModel!
    var parserMock: ParseServiceStub!
    var apiMock: CocktailsAPIMock!
    
    override func setUpWithError() throws {
        parserMock = ParseServiceStub()
        apiMock = CocktailsAPIMock()
        viewModel = CocktailViewModel(parserService: parserMock,
                                      cocktailsAPI: apiMock)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        parserMock = nil
        apiMock = nil
        super.tearDown()
    }
    
    func testGetCocktailList_withValidData_populatesAllCocktailList() async {
        let cocktails = [cockdetail1, cockdetail2]
        let jsonData = try! JSONEncoder().encode(cocktails)
        apiMock.fetchCocktailsResult = .success(jsonData)
        parserMock.parseDataResult = .success(cocktails)
        
        await viewModel.getCocktailList()
        
        XCTAssertEqual(viewModel.allCocktailList[.allCocktail], cocktails)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testGetCocktailList_withFetchError_setsErrorMessage() async {
        apiMock.fetchCocktailsResult = .failure(.unavailable)
        
        await viewModel.getCocktailList()
        
        XCTAssertEqual(viewModel.error, CocktailsAPIError.unavailable.localizedDescription)
        XCTAssertTrue(viewModel.filteredCocktailList.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testMapCocktails_categorizesCocktailsCorrectly() {
        let cocktails = [cockdetail1, cockdetail2]

        viewModel.mapCocktails(cocktails: cocktails)
        
        XCTAssertEqual(viewModel.allCocktailList[.alcoholicCocktails], [cockdetail1])
        XCTAssertEqual(viewModel.allCocktailList[.nonAlcoholicCocktails], [cockdetail2])
        XCTAssertEqual(viewModel.allCocktailList[.allCocktail], cocktails)
        XCTAssertEqual(viewModel.filteredCocktailList, cocktails)
    }
    
    func testFilterCocktail_filtersCorrectlyBasedOnSelectedType() {
        let cocktails = [cockdetail1, cockdetail2]
        viewModel.mapCocktails(cocktails: cocktails)
        
        viewModel.selectedCocktailType = .alcoholicCocktails
        viewModel.filterCocktail()
        
        XCTAssertEqual(viewModel.filteredCocktailList, [cockdetail1])
        
        viewModel.selectedCocktailType = .nonAlcoholicCocktails
        viewModel.filterCocktail()
        
        XCTAssertEqual(viewModel.filteredCocktailList, [cockdetail2])
        
        viewModel.selectedCocktailType = .allCocktail
        viewModel.filterCocktail()
        
        XCTAssertEqual(viewModel.filteredCocktailList, cocktails)
    }
    
}
