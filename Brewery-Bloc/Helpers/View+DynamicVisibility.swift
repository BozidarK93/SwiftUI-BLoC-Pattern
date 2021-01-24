//
//  View+DynamicVisibility.swift
//  Brewery-Bloc
//
//  Created by Bozidar Kokot on 20.01.21.
//

import Foundation
import SwiftUI
extension View {

    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}
