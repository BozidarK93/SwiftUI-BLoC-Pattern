//
//  ContentView.swift
//  Brewery-Bloc
//
//  Created by Bozidar Kokot on 16.01.21.
//

import SwiftUI

struct BrewerySearchView: View {

    @StateObject var bloc: BreweryBloc

    @State private var cityName: String = ""

    var body: some View {
        Group {
            switch bloc.state {
            case .inputState(let isValid):
                VStack(alignment: .center) {
                    TextField("Enter city name", text: $cityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: cityName) { _ in bloc.event = BrewerySearchEvents.cityTextFieldChanged(cityName) }

                    Text("Input field invalid")
                        .foregroundColor(Color.red)
                        .font(.caption)
                        .isHidden(isValid).frame(maxWidth: .infinity, alignment: .leading)

                    Button("Search", action: { bloc.event = BrewerySearchEvents.cityNameSubmitted(cityName) })
                        .disabled(!isValid)
                }.padding()

            case .loading:
                ProgressView()
            case .breweriesFetched(let breweries):
                ScrollView {
                    LazyVStack {
                        ForEach(breweries) { brewery in
                            Text(brewery.name)
                        }
                    }
                }.padding()
            case .failure(let error):
                Text(error.localizedDescription)
            case .noBreweryFound:
                Text("No breweries found")
            }
        }
    }
}

struct BrewerySearchView_Previews: PreviewProvider {
    static var previews: some View {

        
        let bloc = BreweryBloc()
        bloc.state = BrewerySearchStates.noBreweryFound
        return BrewerySearchView(bloc: bloc)
    }
}
