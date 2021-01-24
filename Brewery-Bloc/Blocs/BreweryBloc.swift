//
//  BreweryBloc.swift
//  Brewery-Bloc
//
//  Created by Bozidar Kokot on 16.01.21.
//

import Foundation
import Combine

class BreweryBloc: ObservableObject {

    // MARK: - View streams

    @Published var state: BrewerySearchStates = BrewerySearchStates.inputState(true)

    var event: BrewerySearchEvents? {
        didSet {
            self.handleViewEvent(event: event)
        }
    }

    // MARK: - Data providers
    
    private var cancellable: AnyCancellable?
    private let repository: BreweryRepository

    init(repository: BreweryRepository = StandardBrewerRepository()) {
        self.repository = repository
    }

    // MARK: - View handling

    private func handleViewEvent(event: BrewerySearchEvents?) {

        switch event {
        case .cityNameSubmitted(let cityName):
            state = BrewerySearchStates.loading
            cancellable = repository.fetchBreweries(with: cityName)?
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.state = BrewerySearchStates.failure(error)
                    }
                }, receiveValue: { breweries in
                    self.state = breweries.count > 0 ? BrewerySearchStates.breweriesFetched(breweries) : BrewerySearchStates.noBreweryFound
                })
        case .cityTextFieldChanged(let cityName):
            state = cityName.isNumeric ? BrewerySearchStates.inputState(false) :  BrewerySearchStates.inputState(true)
        case .none:
            print("Event subject recieved nil event")
        }
    }
}
