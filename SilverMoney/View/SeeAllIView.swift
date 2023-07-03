//
//  SeeAllIView.swift
//  SilverMoneyCoreData
//
//  Created by George Bondin on 4/18/23.
//

import SwiftUI

struct SeeAllIView: View {
	
	@Environment(\.dismiss) var dismiss // для удаления кнопки назад

    var body: some View {
		
		
Text ("dsjfhlah")
			
		/*
		
		TabView {
			MainView()
				.tabItem {
					Label("Расходы", systemImage: "folder.badge.minus")
				}
			
			
			IncomeView()
				.tabItem {
					Label("Доходы", systemImage: "folder.fill.badge.plus")
				}
		}
	.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
	//	.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
	//	.animation(.default, value: currentPage)

  NavigationStack {
	  NavigationLink("Tap me") {
		  Text("Destination")
	  }
  }
		
		
		
		
		
		NavigationView {
			VStack{
				HStack {
					NavigationLink(destination: ContentView()) {
						Text("Расходы")
							.frame(width: 150.0, height: 30.0, alignment: .leading)
					}

						//.navigationTitle("Navigation")

					NavigationLink(destination: IncomeView()) {
						Text("Доходы")
							.frame(width: 150.0, height: 30.0, alignment: .leading)
					}
						//.navigationTitle("Navigation")
					
				}
				Spacer()
				
				Text("графики расходов + напоминания")
				
			}
			
			

		}
		
		

		
		
		
		
		
		 */
		
		
		
    }
}

struct SeeAllIView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllIView()
    }
}
