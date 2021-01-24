//
//  BreweryFixture.swift
//  Brewery-BlocTests
//
//  Created by Bozidar Kokot on 18.01.21.
//

import Foundation

@testable import Brewery_Bloc

extension Brewery {

    static func fixture() -> Brewery {
        Brewery(id: 123, name: "Test brewery")
    }
}
