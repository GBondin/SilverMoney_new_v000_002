//
//  CategoryEditView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 2/2/23.
//

import SwiftUI
import CoreData

struct CategoryEditView: View {
	
	
	
	/*
	 @Environment(\.managedObjectContext) private var viewContext
	 
	 // подтягивание данных из файла
	 @FetchRequest(
	 sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)], animation: .default)
	 
	 private var category: FetchedResults<Category>
	 
	 @State var dataTemp: String = ""
	 
	 @State var aaa: String = ""
	 */
	
	var body: some View {
		
		Text(" убрать? ")
		/*
		 
		 
		 VStack{
		 
		 Section(header: Text("Изменение категории")
		 .font(.title3)
		 .multilineTextAlignment(.leading)) {
		 }
		 .padding(50.0)
		 .frame(height: 50.0)
		 //    let aaa = category.catShop!
		 Form {
		 TextField("ntrcn", text: $dataTemp)
		 
		 //      TextField("\(category.catShop!)", text: $dataTemp)
		 }
		 .frame(width: nil, height: 150.0)
		 Divider()
		 
		 //  let  showCheckSumm = category.catRashSumm
		 //  Section(header: Text("FILTER PREFERENCE")) {
		 /*        Toggle(isOn: $showCheckSumm) {
		  Text("Учитывать в общих расходах")
		  }
		  // }
		  .frame(width: 350.0, height: 150.0)
		  Divider()
		  */
		 /*       Button("Записать изменения") {
		  if dataTemp == "" {
		  dataTemp = aaa
		  }
		  
		  category.catShop = dataTemp
		  category.catRashSumm = showCheckSumm
		  try? viewContext.save()
		  dataTemp = ""
		  
		  
		  }
		  .padding(.vertical, 100.0)
		  .frame(width: 300.0, height: 50.0)
		  */
		 
		 }
		 .padding(.bottom, 400.0)
		 
		 
		 
		 
		 */
	}
}



struct CategoryEditView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryEditView().environment(\.managedObjectContext,  PersistenceController.preview.container.viewContext)
    }
}
