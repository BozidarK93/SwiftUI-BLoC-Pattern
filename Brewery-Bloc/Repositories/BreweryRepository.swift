//
//  BreweryRepository.swift
//  Brewery-Bloc
//
//  Created by Bozidar Kokot on 16.01.21.
//

import Foundation
import Combine

protocol BreweryRepository {
    /// Fetch a  list of breweries in a given city area.
    /// - Parameters:
    /// - cityName: The city name for which we fetch the list of breweries .
    func fetchBreweries(with cityName: String)  -> AnyPublisher<[Brewery], Error>?
}

final class StandardBrewerRepository: BreweryRepository {

    func fetchBreweries(with cityName: String) -> AnyPublisher<[Brewery], Error>? {
        // This app's main focus is to demonstrate the usage of the Bloc pattern so the network call approach is rather primitive. If you want to check out how to create API client with Combine there is a good read at: https://medium.com/better-programming/upgrade-your-swift-api-client-with-combine-4897d6e408a0
        guard let encodedURLString = String(Constants.baseUrl + "?by_city=\(cityName)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        guard let url = URL(string: encodedURLString) else { return nil }
        let request = URLRequest(url: url)

        return URLSession.DataTaskPublisher(request: request, session:  URLSession.shared)
            .tryMap { data, response  in
                guard let decodedResponse = try? JSONDecoder().decode([Brewery].self, from: data) else { throw BreweryRepositoryErrors.parsingError }
                return decodedResponse
            }
            .tryCatch { error -> AnyPublisher<[Brewery], Error> in
                throw BreweryRepositoryErrors.requestError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

enum BreweryRepositoryErrors: Error {
    case parsingError
    case requestError
    case wrongURL
}
