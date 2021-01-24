//
//  Brewery_BlocTests.swift
//  Brewery-BlocTests
//
//  Created by Bozidar Kokot on 16.01.21.
//

import XCTest
@testable import Brewery_Bloc

class BreweryBlocTests: XCTestCase {

    var bloc: BreweryBloc!
    var repository: BreweryRepositoryMock!

    override func setUp() {
        super.setUp()

        self.repository = BreweryRepositoryMock()
        self.bloc = BreweryBloc(repository: self.repository)
    }

    func testFetchBreweriesCalledOnCityNameEnteredEvent() {
        bloc.event = BrewerySearchEvents.cityNameSubmitted("Test city")
        XCTAssertTrue(repository.didCallFetchBreweries)
    }
}
