//
//  ProVC.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/26/20.
//

import SwiftUI
import StoreKit

struct ProVC: View {
	@State var productsArray: [SKProduct?] = []
	@State var showingUpgradeAlert = false
	
	@State private var isLoading = false
	@Binding var showingProVC: Bool
	
    var body: some View {
		ZStack {
			Colors.darkishGray
				.edgesIgnoringSafeArea(.all)
			
			VStack {
				HStack {
					Spacer()
					
					Text("Pro Version")
						.font(.title)
						.foregroundColor(.white)
					
					Spacer()
					
					Image(systemName: "xmark")
						.resizable()
						.frame(width: 20, height: 20)
						.foregroundColor(.white)
						.onTapGesture(perform: {
							showingProVC = false
						})
				}
				.padding(.horizontal)
				
				Image("ProMarketing")
					.resizable()
					.aspectRatio(contentMode: .fit)
				
				Button("Upgrade now!") {
					if PersistenceManager.shared.fetchProUser() {
						showingUpgradeAlert = true
					} else {
						guard let proVersion = productsArray[0] else { return }
						IAPHandler.shared.purchase(product: proVersion) { (alert, product, transaction) in }
					}
				}
				.padding(.all, 20)
				.foregroundColor(Colors.darkGray)
				.background(
					Capsule()
						.fill(LinearGradient(gradient: Gradients.tealGradient, startPoint: .leading, endPoint: .trailing))
				)
				.alert(isPresented: $showingUpgradeAlert, content: {
					Alert(title: Text("Oops"), message: Text("You're already a pro member!"), dismissButton: .default(Text("OK")))
				})
				
				Text("Already a pro member? Redeem here")
					.underline()
					.foregroundColor(.white)
					.font(.footnote)
					.onTapGesture(perform: {
						IAPHandler.shared.restorePurchase()
					})
			}
			
			if isLoading {
				Spinner()
			}
		}
		.navigationBarTitle("Pro Version")
		.onAppear { getIAPs() }
    }
	
	func getIAPs() {
		#if targetEnvironment(simulator)
		return
		#else
		isLoading = true
		IAPHandler.shared.setProductIds(ids: ["com.ryanschefske.Speedometer.Pro"])
		IAPHandler.shared.fetchAvailableProducts { products in
			self.productsArray = products
			isLoading = false
		}
		#endif
	}
}

//struct ProVC_Previews: PreviewProvider {
//    static var previews: some View {
//		ProVC(showingProVC: true)
//    }
//}
