//
//  BrewerySearchStates.swift
//  Brewery-Bloc
//
//  Created by Bozidar Kokot on 16.01.21.
//

import Foundation

enum BrewerySearchStates {
    case inputState(Bool)
    case loading
    case breweriesFetched([Brewery])
    case failure(Error)
    case noBreweryFound
}
