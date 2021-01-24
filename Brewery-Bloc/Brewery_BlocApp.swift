//
//  Brewery_BlocApp.swift
//  Brewery-Bloc
//
//  Created by Bozidar Kokot on 16.01.21.
//

import SwiftUI

@main
struct Brewery_BlocApp: App {
    var body: some Scene {
        WindowGroup {
            BrewerySearchView(bloc: BreweryBloc())
        }
    }
}
