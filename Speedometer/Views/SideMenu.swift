//
//  SideMenu.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/8/20.
//

import SwiftUI
import StoreKit

struct SideMenu: View {
	@ObservedObject var lm: LocationManager
	@State var index = Measurements.measurements.firstIndex(of: PersistenceManager.shared.fetchMeasurement())
	@State var isProUser = PersistenceManager.shared.fetchProUser()
	@State private var showingAlert = false
	
	@State private var showingProVC = false
	@State private var showingThemeVC = false
	@State private var showingMapVC = false
	@State private var showingAppIconVC = false
	@State private var showingTimeStampVC = false
	
	var body: some View {
		VStack {
			Picker(selection: Binding<Int>(
					get: { (self.index ?? 0) },
					set: {
						self.index = $0
						PersistenceManager.shared.setMeasurement(type: Measurements.measurements[self.index ?? 0])
					}), label: Text("Select your measurement:")) {
				ForEach(0..<Measurements.measurements.count) { index in
					Text(Measurements.measurements[index]).tag(index)
				}
			}
			.pickerStyle(SegmentedPickerStyle())
			.padding(.horizontal, 5)
			
			List {
				Section(header: Text("Settings")) {
					Text("Upgrade to Pro")
						.onTapGesture(perform: {
							showingProVC = true
						})
						.fullScreenCover(isPresented: $showingProVC, content: {
							ProVC(showingProVC: $showingProVC)
						})
					
					if PersistenceManager.shared.fetchProUser() {
						Text("Select Theme")
							.onTapGesture(perform: {
								showingThemeVC = true
							})
							.fullScreenCover(isPresented: $showingThemeVC, content: {
								ThemeSelectVC(showingThemeVC: $showingThemeVC)
							})
						
						Text("Show Map")
							.onTapGesture(perform: {
								showingMapVC = true
							})
							.fullScreenCover(isPresented: $showingMapVC, content: {
								MapVC(showingMapVC: $showingMapVC, lm: lm)
							})
						
						Text("Change App Icon")
							.onTapGesture {
								showingAppIconVC = true
							}
							.fullScreenCover(isPresented: $showingAppIconVC, content: {
								AppIconPickerVC(showingAppIconVC: $showingAppIconVC)
							})
						
						Text("Speed Log")
							.onTapGesture {
								showingTimeStampVC = true
							}
							.fullScreenCover(isPresented: $showingTimeStampVC, content: {
								TimeStampVC(lm: lm, showingTimeStampVC: $showingTimeStampVC)
							})
						
					} else {
						Text("Select Theme")
							.foregroundColor(Colors.lightGray)
							.onTapGesture {
								self.showingAlert = true
							}
							.alert(isPresented: $showingAlert) { () -> Alert in
								Alert(title: Text("Oops!"), message: Text("This feature is only available to pro users."), dismissButton: .default(Text("OK")))
							}
						
						Text("Show Map")
							.foregroundColor(Colors.lightGray)
							.onTapGesture {
								self.showingAlert = true
							}
							.alert(isPresented: $showingAlert) { () -> Alert in
								Alert(title: Text("Oops!"), message: Text("This feature is only available to pro users."), dismissButton: .default(Text("OK")))
							}
						
						Text("Change App Icon")
							.foregroundColor(Colors.lightGray)
							.onTapGesture {
								self.showingAlert = true
							}
							.alert(isPresented: $showingAlert) { () -> Alert in
								Alert(title: Text("Oops!"), message: Text("This feature is only available to pro users."), dismissButton: .default(Text("OK")))
							}
						
						Text("Speed Log")
							.foregroundColor(Colors.lightGray)
							.onTapGesture {
								self.showingAlert = true
							}
							.alert(isPresented: $showingAlert) { () -> Alert in
								Alert(title: Text("Oops!"), message: Text("This feature is only available to pro users."), dismissButton: .default(Text("OK")))
							}
					}
				}
				
				Section(header: Text("Other")) {
					Text("Rate Speedometer")
						.onTapGesture(perform: {
							if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
								SKStoreReviewController.requestReview(in: scene)
							}
						})
					
					Text("Privacy Policy")
						.onTapGesture(perform: {
							if let url = URL(string: "https://ryanschefske.wixsite.com/home/blank-page-3") {
								UIApplication.shared.open(url, options: [:], completionHandler: nil)
							}
						})
					
					Text("Our Apps")
						.onTapGesture(perform: {
							if let url = URL(string: "itms-apps://apps.apple.com/kw/developer/ryan-schefske/id1359871123") {
								UIApplication.shared.open(url, options: [:], completionHandler: nil)
							}
						})
				}
			}
			.listStyle(GroupedListStyle())
			.accentColor(.secondary)
		}
		.frame(width: 250)
		.background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
		.navigationBarTitle("")
		.navigationBarHidden(true)
	}
}
