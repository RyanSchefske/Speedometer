//
//  CheckboxView.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/14/20.
//

import SwiftUI

struct CheckboxView: View {
    var body: some View {
		ZStack {
			Circle()
				.trim(from: 0.0, to: 1)
				.stroke(lineWidth: 2)
				.frame(width: 60, height: 60)
				.foregroundColor(.green)
			
			Circle()
				.trim(from: 0.0, to: 1.0)
				.frame(width: 50, height: 50)
				.foregroundColor(.green)
			
			Image(systemName: "checkmark")
				.foregroundColor(.white)
		} 
    }
}

//struct CheckboxView_Previews: PreviewProvider {
//    static var previews: some View {
//		CheckboxView(checked: Binding<true>, trimValue: 1.0)
//    }
//}
