//
//  BrewerySearchViewSnapshotTests.swift
//  Brewery-BlocTests
//
//  Created by Bozidar Kokot on 18.01.21.
//

import Foundation

import SnapshotTesting
import XCTest
@testable import Brewery_Bloc

class BrewerySearchViewSnapshotTests: XCTestCase {

    var bloc: BreweryBloc!

    override func setUp() {
        super.setUp()

        self.bloc = BreweryBloc(repository: BreweryRepositoryMock())
    }

    func testbreweriesFetchedViewStateRendered() {
        bloc.state = BrewerySearchStates.breweriesFetched([Brewery.fixture()])
        let view = BrewerySearchView(bloc: self.bloc)

        assertSnapshot(matching: view, as: .image(layout: .device(config: .iPhoneXr)))
    }

    func testNoBreweryTextShownWhenViewStateNoBreweryFound() {
        bloc.state = BrewerySearchStates.noBreweryFound
        let view = BrewerySearchView(bloc: self.bloc)

        assertSnapshot(matching: view, as: .image(layout: .device(config: .iPhoneXr)))
    }
}
