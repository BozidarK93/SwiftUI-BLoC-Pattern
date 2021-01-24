//
//  BreweryRepositoryMock.swift
//  Brewery-BlocTests
//
//  Created by Bozidar Kokot on 18.01.21.
//

import Foundation
import Combine
@testable import Brewery_Bloc

class BreweryRepositoryMock: BreweryRepository {

    var didCallFetchBreweries = false

    func fetchBreweries(with withCityName: String) -> AnyPublisher<[Brewery], Error>? {
        didCallFetchBreweries = true
        return nil
    }
}
