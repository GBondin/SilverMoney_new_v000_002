//
//  CategoryRowView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 2/5/23.
//

import SwiftUI



struct CategoryRowView: View {
    
    @State var totalAmount4:Int = 0

   var body: some View {
      Text ("\(totalAmount4 )")
    }
}

/*
struct CategoryRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.refresh) private var refresh
    
    // подтягивание данных из файла
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.catID , ascending: true)], animation: .default)
    
private var category: FetchedResults<Category>
    @State var showCheckSumm: Bool = true
    
    @State var dataTemp: String = ""
    var body: some View {

        
         NavigationLink () {
         
         //     CategoryEditView()
         // рабочий блок
         VStack{
         Section(header: Text("Изменение категории")) {
         }
         .padding(.top, 50.0)
         .frame(height: 50.0)
         let aaa = category.catShop!
         //  var Lazy: showCheckSumm  = category.catRashSumm
         TextField(
         "\(category.catShop!)",
         text: $dataTemp
         )
         .frame(height: 50.0)
         //    .focused($emailFieldIsFocused)
         .onSubmit {
         //    validate(name: username)
         }
         .textInputAutocapitalization(.never)
         .disableAutocorrection(true)
         //   .border(.secondary)
         
         //    Text($dataTemp)
         //        .foregroundColor(emailFieldIsFocused ? .red : .blue)
         
         /*        Form {
          TextField("\(category.catShop!)", text: $dataTemp)
          }
          .padding(.top, 50.0)
          .frame(width: nil, height: 150.0)
          */          Divider()
         
         //  let  showCheckSumm = category.catRashSumm
         //  Section(header: Text("FILTER PREFERENCE")) {
         Toggle(isOn: $showCheckSumm) {
         Text("Учитывать в общих расходах")
         }
         // }
         .frame(width: 300.0, height: 20.0)
         .padding(.top, 20.0)
         
         Divider()
         
         Button("Записать изменения") {
         if dataTemp == "" {
         dataTemp = aaa
         }
         
         category.catShop = dataTemp
         category.catRashSumm = showCheckSumm
         try? viewContext.save()
         dataTemp = ""
         
         
         }
         // .padding(.vertical, 100.0)
         .frame(width: 200.0, height: 50.0)
         
         }
         .padding(.bottom, 150.0)
         
         }
         
     
    label: {
        // TextField("\(category.catShop!)", text: $dataTemp)
        Text("\(category.catShop!)")
        //let  aaa = category.catShop!
        //let dataTemp = category.catShop!
        //TextField(aaa,
        //  "\(category.catShop!)",
        //    text: $dataTemp)
        
    }
    }
    

}

*/

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView()
    }
}
