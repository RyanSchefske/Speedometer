//
//  AppIconPickerVC.swift
//  Speedometer
//
//  Created by Ryan Schefske on 12/5/20.
//

import SwiftUI

struct AppIconPickerVC: View {
	@Binding var showingAppIconVC: Bool
	
    var body: some View {
		VStack {
			HStack {
				Spacer()
				
				Text("App Icons")
					.font(.title)
					.fontWeight(.medium)
				
				Spacer()
				
				Image(systemName: "xmark")
					.resizable()
					.frame(width: 20, height: 20)
					.onTapGesture(perform: {
						showingAppIconVC = false
					})
			}
			.padding(.horizontal)
			
			ScrollView(showsIndicators: false) {
				AppIconView(imageName: "original", appIconName: "Original", plistName: "Primary")
				AppIconView(imageName: "lightTheme", appIconName: "Light Theme", plistName: "LightTheme")
				AppIconView(imageName: "wave", appIconName: "Wave", plistName: "WaveIcon")
				AppIconView(imageName: "classic", appIconName: "Classic", plistName: "ClassicIcon")
			}
			
		}
    }
}

struct AppIconView: View {
	var imageName: String
	var appIconName: String
	var plistName: String
	
	@State var showingAlert: Bool = false
	
	let imageSize: CGFloat = 150
	
	var body: some View {
		VStack {
			Image(imageName)
				.resizable()
				.frame(width: imageSize, height: imageSize, alignment: .center)
				.cornerRadius(15)
				.padding(5)
				.onTapGesture {
					changeAppIcon(to: plistName)
				}
				.shadow(color: Color(.black).opacity(0.5), radius: 5, x: 0, y: 0)
			
			Text(appIconName)
		}
		.padding()
		.alert(isPresented: $showingAlert) { () -> Alert in
			Alert(title: Text("Oops!"), message: Text("Your device does not support this feature."), dismissButton: .default(Text("OK")))
		}
	}
	
	func changeAppIcon(to name: String) {
		guard UIApplication.shared.supportsAlternateIcons else {
			showingAlert = true
			return
		}
		
		if name == "Primary" {
			UIApplication.shared.setAlternateIconName(nil) { (error) in
				guard error == nil else {
					return
				}
			}
		} else {
			UIApplication.shared.setAlternateIconName(name) { (error) in
				guard error == nil else {
					return
				}
			}
		}
	}
}
