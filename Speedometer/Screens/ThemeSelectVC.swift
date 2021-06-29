//
//  ThemeSelectVC.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/12/20.
//

import SwiftUI

struct ThemeSelectVC: View {
	let models = Gradients.allModels
	
	@State var selectedTheme = "Teal"
	@State var alertOpacity: Double = 0
	
	@Binding var showingThemeVC: Bool
	
	@State var checked = false
	@State var trimValue: CGFloat = 0
	
	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	var body: some View {
		ZStack {
			VStack {
				HStack {
					Spacer()
					
					Text("Theme Select")
						.font(.title)
						.fontWeight(.medium)
					
					Spacer()
					
					Image(systemName: "xmark")
						.resizable()
						.frame(width: 20, height: 20)
						.onTapGesture(perform: {
							showingThemeVC = false
						})
				}
				.padding(.horizontal)
				
				ScrollView {
					Text("Color")
						.font(.title)
					
					LazyVGrid(columns: columns, spacing: 20) {
						ForEach(0..<models.count) { index in
							VStack {
								Circle()
									.fill(LinearGradient(gradient: models[index].gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
									.frame(width: 65, height: 65)
								
								Text(models[index].name)
									.font(.subheadline)
									.fontWeight(.medium)
							}
							.padding()
							.background(
								RoundedRectangle(cornerRadius: 10)
									.stroke(Colors.lightGray, lineWidth: 2)
							)
							.onTapGesture(perform: {
								PersistenceManager.shared.setColor(to: models[index].key)
								selectedTheme = models[index].name
								withAnimation(Animation.easeIn(duration: 0.3)) {
									alertOpacity = 1
								}
							})
						}
						.padding(.bottom, 5)
					}
					.padding([.horizontal, .bottom])
					
					Text("Meters")
						.font(.title)
					
					LazyVGrid(columns: columns, spacing: 20) {
						ForEach(Themes.allThemes, id: \.id) { theme in
							VStack {
								switch theme.theme {
									case Themes.original:
										OldMeterCell()
										Text(theme.theme)
									case Themes.classic:
										ClassicMeterCell()
										Text(theme.theme)
									case Themes.wave:
										WaveMeterCell()
										Text(theme.theme)
									default:
										ClassicMeterCell()
										Text("Original")
								}
							}
							.padding()
							.background(
								RoundedRectangle(cornerRadius: 10)
									.stroke(Colors.lightGray, lineWidth: 2)
							)
							.onTapGesture(perform: {
								PersistenceManager.shared.setTheme(to: theme.theme)
								selectedTheme = theme.theme
								withAnimation(Animation.easeIn(duration: 0.3)) {
									alertOpacity = 1
								}
							})
						}
						.padding(.vertical, 5)
					}
					.padding()
				}
				.listStyle(GroupedListStyle())
				.environment(\.defaultMinListRowHeight, 100)
				.navigationBarTitle("Theme Select")
			}
			
			ThemeSelectedView(name: selectedTheme, checked: $checked, trimValue: $trimValue)
				.opacity(alertOpacity)
				.onAnimationCompleted(for: alertOpacity) {
					if alertOpacity == 1 {
						withAnimation(Animation.easeIn(duration: 0.5)) {
							checked = true
							trimValue = 1
						}
					} else {
						checked = false
						trimValue = 0
					}
					withAnimation(Animation.easeOut(duration: 0.4).delay(1.5)) {
						alertOpacity = 0
					}
				}
		}
	}
}

struct ThemeSelectVC_Previews: PreviewProvider {
	@State static var value = true
	
	static var previews: some View {
		ThemeSelectVC(showingThemeVC: $value)
	}
}
