//
//  CategView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/23/23.
//

import SwiftUI
import CoreData





struct CategView: View {
// разобраться – см блокнот
    //  @Environment(\.dismiss) var dismiss
    

    @AppStorage("starterCategory") var starterCategory: Bool = false
    @AppStorage("periodRaschet") var periodRaschet: Double = -36288000
   
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.refresh) private var refresh
    
    // подтягивание данных из файла
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)], animation: .default)

  var category: FetchedResults<Category>
    

    var predicateReka = NSPredicate()
//@State var showCheckSumm: Bool = true

    var tempCat = Set<Int>()
    var initCategory: Bool?
    @State    var bbb: Bool = true
    @State var dataTemp: String = ""

//    @State var showCheckSumm: Bool = true
    
 //  var stIntCategory: Bool = false
    // записывает начальные категории при запуске
   

    var body: some View {
        
        

           
            VStack {
                Text("НАСТРОЙКИ")
                    .font(.title)
                 //   .font(.headline)
                    .fontWeight(.thin)
                  //  .multilineTextAlignment(.leading)
                    .multilineTextAlignment(.leading)

                    .padding(.top, 20.0)
                
                //  .position(x:155,y:20)
                    
                ScrollView {
                    // Label("Категории", systemImage: "42.circle")
                
                    VStack {
                        
                        NavigationView {
                            
                            List {
                                
                                Text("КАТЕГОРИИ РАСХОДОВ")
                                 //   .font(.headline)
                                    .fontWeight(.light)
                                  //  .multilineTextAlignment(.leading)
                                    .multilineTextAlignment(.leading)

                               
                                
                                //  .position(x:155,y:20)
                                ForEach(category) { categoryIndex in
                                    CategoryRow(category: categoryIndex)
                                }
                           //     .onDelete(perform: removeCategory)
                                
                                
                                // .frame(width: 400, height: 350)
                                
                                // .background(.white)
                                // .foregroundColor(.blue)
                                //  .colorMultiply(.white)
                                
                                
                                //    Divider()
                                
                                Text("ПЕРИОД ПОДСЧЕТА РАСХОДОВ")
                              //      .frame(width: 320, height: 50)
                                //    .background(.gray)
                                    .padding(.top, 30)
                                    .font(.headline)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.leading)
                                
                                //    .padding(10.0)
                                //  .position(x:155,y:10)
                                //    .background(.gray)
                                
                                
                                //       List {
                                Button("1 день") {
                                    
                                    let date = Date()
                                    let calendar = Calendar.current
                                    
                                    let hour = calendar.component(.hour, from: date)
                                    let minutes = calendar.component(.minute, from: date)
                                    
                                    let timer = -(hour * 3600 + minutes * 60)
                                    periodRaschet = Double(timer)
                                }
                                Button("1 неделя") {
                                    periodRaschet  = -15 //-36288000
                                }
                                
                                
                                
                                Button("2 недели") {
                                    periodRaschet  = -30 //-72576000
                                }
                                
                                
                                //   .foregroundColor(onoffee ? .blue :  .gray)
                                
                                
                                
                                Button("1 месяц") {
                                    periodRaschet  = -50 //-145152000
                                }
                                Button("1 год") {
                                    periodRaschet  = -1741824000
                                }
                                
                                Button("с даты...?") {
                                    //  periodRaschet  = 1
                                }
                                
                                //      }
                                
                                //  .defaultAppStorage(UserDefaults(suiteName: "custom_user_defaults")!)
                                //   .frame( height: 350.0)
                                
                                //  .border(Color(white: 0.75))
                                
                            //    Divider()
                                Text("УДАЛИТЬ ВСЕ ДАННЫЕ")
                                    .fontWeight(.light)
                                    .padding(.top, 20)
                                //     Button("Удалить все внесенные данные") {
                                //
                                //       }
                                //       .accentColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                                
                                
                              //  SeeView()
                            }
                        }
                }
                //  .border(Color(white: 0.75))
                  .frame( height: 900.0)
                  .padding(.bottom, 50.0)
                  .scrollContentBackground(.hidden)

                 }
        }




    }

 
    
    func removeCategory(at offsets: IndexSet) {
        for index in offsets {
            let categoryIndex = category[index]
            viewContext.delete(categoryIndex)
        }
    }
    
    private  func addItem2() {
        
            withAnimation {
            let newCategory = Category(context: viewContext)
            newCategory.catShop = "новая категория"
            newCategory.categoryID = Int16(category.count)
            // прдумать как при удалении категории переносить данные в удаленные данные (или как то так
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            }
    }
    
     func deleteItems2(offsets: IndexSet) {
            withAnimation {
            offsets.map { category[$0] }.forEach(viewContext.delete)
           do {
               try viewContext.save()
          } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          //      let nsError = error as NSError
           //     fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           }
            }
    }
    

func addItemDef () {
        // запись первой строки – инициализация для превью
        let newItem = Item(context: viewContext)
        newItem.timestampData = Date()
        newItem.noteSummData = "info"
        newItem.mCatsData = "пример"
        newItem.summData = 0
        
        // инициализация начальных данных категорий для превью
        let mCatInit: [String] = ["продукты", "товары", "услуги", "рестораны", "развлечения", "комм. платежи", "здоровье", "другое"]

    
//нужно начинать не с 0 категории, а с 1! 0 резеврируем для удаления?, но пока остается с 0
        var mCatInd: Int16 = 0
        for mCats in mCatInit {
            let newCategory = Category(context: viewContext)
            newCategory.catShop = mCats
            newCategory.categoryID = mCatInd
          newCategory.categoryItemID = mCatInd
            newCategory.catUUID = UUID()
            newCategory.catNote = ""
            newCategory.onRemove = false
            newCategory.catRashSumm = true

            mCatInd += 1

        }
        
        // запись файла
        do {
            try viewContext.save()
            // отработка ошибок
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
     starterCategory = true
    }
    

}

        struct CategView_Previews: PreviewProvider {
            static var previews: some View {
              //  CategView().environment(\.managedObjectContext,  PersistenceController.preview.container.viewContext)
                CategView().environment(\.managedObjectContext,  PersistenceController.preview.container.viewContext)
            }
        }






struct CategoryRow: View {
   @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var category: Category
    
   // @Binding var category:
    
    
@State var dataTemp: String = ""
    var body: some View {

         NavigationLink () {
         //     CategoryEditView()
         // рабочий блок
             VStack(alignment: .leading){
         Section(header: Text("Изменить название категории")) {
         }
         .padding(.top, 25.0)
         .frame(height: 50.0)

                Text(category.catShop!)
                     .padding(.top, 5.0)
                //.foregroundColor(emailFieldIsFocused ? .red : .blue)
                Form {
                    TextField("\(category.catShop!)", text: $dataTemp)
          }
         // .padding(.top, 20.0)
       .frame(width: nil, height: 130.0)
        .padding(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, -20.0)

         
         
         //  let  showCheckSumm = category.catRashSumm
         //Section(header: Text("FILTER PREFERENCE")){
                 
                Toggle(isOn: self.$category.catRashSumm ) {
                    Text("Учитывать в общих расходах")
                }
                     // }
                .frame(width: 300.0, height: 300.0)
                .padding(.vertical, 20.0)
                .task {saveCateg()
                }
                 
                 
             //    }
                 
                 
                 
         Divider()
         
  /*       Button("Записать изменения") {
         saveCateg ()
         }
         .padding(.vertical, 100.0)
        //  .padding(.vertical, 100.0)
         .frame(width: 350.0, height: 50.0)
        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
        .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
   
   */
         }
             .padding(.bottom, 200.0)
             .padding(/*@START_MENU_TOKEN@*/.all, 25.0/*@END_MENU_TOKEN@*/)
         }
     
    label: {
        // TextField("\(category.catShop!)", text: $dataTemp)
        Text("\(category.catShop!)")
        .foregroundColor(category.catRashSumm ? .blue : /*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
    }


//.onDelete(perform: CategView.deleteItems2)

        
    }

func saveCateg () {
    if dataTemp == "" {
    dataTemp = category.catShop!
    }
    category.catShop = dataTemp
    category.catRashSumm = category.catRashSumm
    try? viewContext.save()
    dataTemp = ""
    
    }

}



