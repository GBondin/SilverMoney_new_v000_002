//
//  AView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/21/23.
//

import SwiftUI
import CoreData



struct AView: View {

  @AppStorage("starterCategory") var starterCategory: Bool = false
	@AppStorage("IncomeTrue") var incomeTrue: Bool = false

    
// let persistenceController = PersistenceController.shared
  //  @Environment(\.managedObjectContext) private var viewContext

	var body: some View {
		
		
		if incomeTrue == true {
			
			
			VStack {
				
				TabView {
					
				MainView()
						.tabItem {
							Label("Внести Расходы", systemImage: "folder.badge.minus")
						}
					ContentView()
						.tabItem {
							Label("Смотреть (–)", systemImage: "doc.text.magnifyingglass")
						}
					
					IncomeView()
						.tabItem {
							Label("Доходы", systemImage: "folder.fill.badge.plus")
						}
					
					IncomeLookView()
						.tabItem {
							Label("Смотреть (+)", systemImage: "doc.text.magnifyingglass")
						}
					
					
					SettingView()
						.tabItem {
							Label("Настройки", systemImage: "doc.badge.gearshape")
								//	Label("Помощь", systemImage: "questionmark.circle")
						}
					
				}
					//.accentColor(Color("DarkYellow"))
				.accentColor(.gray)
				
				
				
				
					//.tabViewStyle(PageTabViewStyle())
					//.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
				
				
					//	.tabViewStyle(PageTabViewStyle())
				
				
				
				
				
			}
			
		}
		
		else {
			
			TabView {
				
/*				MainView()
					.tabItem {
						Label("Внести Расходы", systemImage: "folder.badge.minus")
						
					}
*/
				
/*				ContentView()
					.tabItem {
						Label("Расходы (–)", systemImage: "doc.text.magnifyingglass")
					}
*/
				
				MainView()
									.tabItem {
										Label("Внести Расходы", systemImage: "folder.badge.minus")
										
									}
				
				
				
				SettingView()
					.tabItem {
						Label("Настройки", systemImage: "doc.badge.gearshape")
							//	Label("Помощь", systemImage: "questionmark.circle")
					}
			}
		}
		
		
		
		
		
	}
	
	
	
	
	
	
	
}



struct AView_Previews: PreviewProvider {
    static var previews: some View {

        AView()
       .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
