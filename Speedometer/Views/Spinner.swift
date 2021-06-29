//
//  Spinner.swift
//  Speedometer
//
//  Created by Ryan Schefske on 1/30/21.
//

import SwiftUI

struct Spinner: View {
    var body: some View {
		ZStack {
			Color(.systemBackground).opacity(0.5)
				.edgesIgnoringSafeArea(.all)
			
			ProgressView()
				.progressViewStyle(CircularProgressViewStyle())
				.scaleEffect(2)
		}
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
