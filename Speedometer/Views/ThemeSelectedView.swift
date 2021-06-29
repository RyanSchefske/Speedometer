//
//  ThemeSelectedView.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/24/20.
//

import SwiftUI

struct ThemeSelectedView: View {
	var name: String
	@Binding var checked: Bool
	@Binding var trimValue: CGFloat
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.foregroundColor(Colors.lightGray.opacity(1))
			
			VStack {
				ZStack {
					Circle()
						.trim(from: 0.0, to: trimValue)
						.stroke(lineWidth: 2)
						.frame(width: 60, height: 60)
						.foregroundColor(checked ? .green : .clear)
					
					Circle()
						.trim(from: 0.0, to: 1.0)
						.frame(width: 50, height: 50)
						.foregroundColor(checked ? .green : .clear)
					
					if checked {
						Image(systemName: "checkmark")
							.foregroundColor(.white)
					}
				}
				.padding()
				.onAnimationCompleted(for: trimValue) {
					UINotificationFeedbackGenerator().notificationOccurred(.success)
				}
				
				Text("\(name) theme selected")
			}
			.padding()
		}
		.frame(width: 225, height: 225)
    }
}

//struct ThemeSelectedView_Previews: PreviewProvider {
//    static var previews: some View {
//		ThemeSelectedView(name: "Beach", checked: true, trimValue: 1)
//    }
//}
