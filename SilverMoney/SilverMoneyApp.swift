//
//  SilverMoneyApp.swift
//  SilverMoney
//
//  Created by George Bondin on 4/20/23.
//

import SwiftUI

@main
struct SilverMoneyApp: App {

    
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            

         
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
         
                       
          //  AView()
		//	MainView()
             //   .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
