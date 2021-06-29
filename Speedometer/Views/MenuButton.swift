//
//  MenuButton.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/6/20.
//

import SwiftUI

struct MenuButton: View {
    var body: some View {
		Image(systemName: "line.horizontal.3")
			.renderingMode(.template)
			.foregroundColor(Color(.label))
			.frame(width: 60, height: 60, alignment: .center)
			.background(Colors.lightGray)
			.cornerRadius(30)
			.shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 0)
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton()
    }
}
