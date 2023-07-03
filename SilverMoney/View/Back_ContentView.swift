//
//  ContentView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/19/23.
//

import SwiftUI
import CoreData





var trigerOne: Bool = false





struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext
 // @Environment(\.refresh) private var refresh
    
 //   @State   var xxx:Int16 = 0


   @AppStorage("periodRaschet") var periodRaschet: Double = -36288000

    
    @State private var username: String = ""
    @State var showView = false
    @State var dataStrCat = ""
    
    @State var refreshPage = false

    @State var predTextNcatTemp: String = ""
    
    @State var predicateReka = NSPredicate()
    
    
 //  @Binding var periodRaschet: Double

    
  //  @Binding var periodRaschet: Double


//    @AppStorage("Preference") var periodRaschet: Double = -36288000


    
  //  @ObservedObject var category: Category

 /*   var gggg: Int
    init() {
        gggg = 0
    }
    
    */
  //   var predicate01: NSPredicate

   // let predicate01 = NSPredicate(format: "categoryItemID >= %i", 0 )
  //  init() {
    //    predicate01 = NSPredicate(format: "categoryItemID >= %i", 0 ),
   // }
    
//let request = Item.fetchRequest() as NSFetchRequest<Item>
    
                
 //   @Binding var periodRaschet: Double


    var currentDate = Date()
    
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestampData , ascending: true)],
  //  sortDescriptors: [],
  predicate: NSPredicate(format: "categoryItemID >= 0" ),
   // predicate: NSPredicate(format: "timestampData <= 2023-03-28 06:04:10 +0000"),
 //   sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestampData, ascending: false)],
 // predicate: NSPredicate(format: "mCatsData = %@ || mCatsData = %@", "товары", "услуги", "продукты"),
//   predicate: NSPredicate(format: "mCatsData = %@ || mCatsData = %@ || mCatsData = %@", "товары", "услуги", "продукты"),
 //   predicate: nil,
 //  predicate: NSPredicate(format: "categoryItemID >= %i", 1),
 // predicate: NSPredicate(format: "categoryItemID >= %i", 1 ),
    //  predicate: NSPredicate(format: "summData > %i", 500),

    //       predicate: predicate,
     animation: .default)

    private var items: FetchedResults<Item>
    
    
/*      @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestampData , ascending: true)],
       animation: .default)
      private var items2: FetchedResults<Item>
*/
    
    
    @FetchRequest(
  //      sortDescriptors: [])
       sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
       predicate: NSPredicate(format: "catRashSumm != false"),


       animation: .default)
//    private var category: FetchedResults<Category>
    var category: FetchedResults<Category>

    
    
    

    @FetchRequest(
     //   sortDescriptors: [])
      sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
predicate: NSPredicate(format: "catRashSumm != true"),
    //  predicate: predicate,
//    private var category: FetchedResults<Category>
      animation: .default)
    var category2: FetchedResults<Category>
    
    
//  var items: FetchedResults<Item, Category>
   
//    let query = "продукты"
//    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
//    let predicate = NSPredicate(format: "mCatsData = %@", "продукты")
    
//    fetchRequest.predicate = predicate
    
 @State   var fullText: String = ""


    var categoryAllSumm: Int = 0
    var allSumm: [Int] = []

 // подсчет всех трат
   var totalAmount: Int32 {
       
   //    let predicatesttt = NSPredicate(format: "catRashSumm != false" )
   //   category.nsPredicate = predicatesttt
        //   items.reduce(0) { $0 + $1.summData }
       return items.reduce(0) { $0 + $1.summData }
         }
    
/*    var totalAmount2: Int32 {
        return items2.reduce(0) { $0 + $1.summData }
          }
*/
    
/*    ForEach(category) {category in
// проверка категории      Button("\(category.catShop!) \(category.categoryID)") {

    Button("\(category.catShop!)") {
  //   dataStrCat = Data().calcShop("\(category.catShop!)")
        categPredicate (category.categoryID)
  }
     .buttonStyle(.bordered)
     .accentColor(category.catRashSumm ? .blue : /*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
     //        let fred = category.categoryID
    //         let ftor = category.catRashSumm

 }
}
*/
    // выборка по фильтру не работает нужно разбираться
//    var filtr:  Int32   {
//        items.filter { $0 + $1.summData < 500 }
//    }

   @State var summCategory: Int = 0
    var ooo = 0
    
    var yyyy: [Int16] = []
   
    var freddy: [Int16] = []
  //  var freddy = freddy.append(16)
    
 // var predTextNcat = ""


    
    var body: some View {


        VStack{
            
    //        Text("тут,для начала, будем выводить список с категорией и суммой")
   //             .padding(60.0)
         
            Text("РАСХОДЫ")
                .font(.title)
                .fontWeight(.thin)
            
     /*      NavigationView {
                 List{
                        ForEach(items, id:\.self) { item in
                            NavigationLink() {     //destination:
                                Text("\(item.summData)  \(category[Int(item.categoryItemID)].catShop!)")
                                Form {
                                TextField("\(item.noteSummData!)", text: $fullText)
                                }
                              //  item.noteSummData = $fullText
                             //   try? viewContext.save()
                              //  $fullText = ""
                            }
                        label: {
                            HStack(alignment: .top)  {
                                Text(item.timestampData!,  style: .date)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.gray)
                                    .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .frame(maxWidth: 130.0, alignment: .leading) //130
                                
                                Text("\(category[Int(item.categoryItemID)].catShop!)")
                                    .frame(maxWidth: 100.0, alignment: .leading)
                                //.frame(alignment: .leading)
                                //  .multilineTextAlignment(.leading)
                                //     Spacer()

                                // \(String(item.catRashSummBool))
                                Text("\(item.summData)")
                                    .frame(maxWidth: 70.0, alignment: .trailing)
                                    .font(.body)
                                    .multilineTextAlignment(.trailing)
                                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                // .padding(.leading, 0.0)
                                //   Spacer()
                                //  Text("\(item.mCatsData!)")
                                // проверка категории     Text("\(item.categoryItemID)")
                            }
                        }
                        }
                    .onDelete(perform: deleteItems)
                    // addItem()

                }

                //  .frame(height: 400.0)
                .frame(maxHeight: 300.0)
                .background(.white)

                .refreshable {
                    addItem() }
                //  .padding(10.0)
                //   .frame(width: 320.0, height: 300.0)

                 }
         */
            Divider()
            
            
            NavigationView {
                List {
                    ForEach(category) {category in
                    let   categoryID = category.categoryID
     
                       NavigationLink() {
                          Text("траты по категории \(category.catShop!) \(summCategory)")
                           
 //                          ContentCategoryView()
                         NavigationView {
                                     List{
                                            ForEach(items, id:\.self) { item in
                                                if item.categoryItemID == categoryID { // подбор чеков соответствующей категории
                                                NavigationLink()
                                                    {     //destination:

                                                //    Text("\(item.summData)  \(category[Int(item.categoryItemID)].catShop!)")
                                                    Form {
                                                    TextField("\(item.noteSummData!)", text: $fullText)
                                                            .task {
                                                                  summDataCatfunc(-999999999)
                                                            }
                                                    }
                                                 
                                                  //  item.noteSummData = $fullText
                                                 //   try? viewContext.save()
                                                  //  $fullText = ""
                                                }
                                                    
                                            label: {
                                                

                                               HStack(alignment: .top)  {
                                                  //  Text("\(item.categoryItemID)") // номер категории
                                                  //  Text("\(categoryID)")
                                                    
                                                    Text(item.timestampData!,  style: .date)
                                                        .fontWeight(.light)
                                                        .foregroundColor(Color.gray)
                                                        .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                                                        .multilineTextAlignment(.leading)
                                                        .lineLimit(1)
                                                        .frame(maxWidth: 200.0, alignment: .leading) //130
                                                    
                                              //      Text("\(category[Int(item.categoryItemID)].catShop!)")
                                                        .frame(maxWidth: 200.0, alignment: .leading)
                                                    //.frame(alignment: .leading)
                                                    //  .multilineTextAlignment(.leading)
                                                    //     Spacer()

                                                    // \(String(item.catRashSummBool))
                                                    
                                                    Text("Rub: \(item.summData)")
                                                        .frame(maxWidth: 100.0, alignment: .trailing)
                                                        .font(.body)
                                                        .multilineTextAlignment(.trailing)
                                                        .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                                        .task {
                                                       //     let summDataCat = item.summData
                                                         summDataCatfunc(item.summData)
                                                        }
                                                    // .padding(.leading, 0.0)
                                                    //   Spacer()
                                                    //  Text("\(item.mCatsData!)")
                                                    // проверка категории     Text("\(item.categoryItemID)")
                                                }

                                            }
                                            }
                                            }
                                     .onDelete(perform: deleteItems)
                                        
                                        // addItem()
                   
                                    }

                                    //  .frame(height: 400.0)
//                                      .frame(maxHeight: 600.0)
//                                      .background(.white)

                       //           .refreshable {
                        //                summDataCatfunc(-999999999)}
                                   //     addItem() }
                                    //  .padding(10.0)
                                    //   .frame(width: 320.0, height: 300.0)

                                     }

  
                        }

 label: {
                            HStack() {
                            Text("\(category.catShop!)")
                             .foregroundColor(category.catRashSumm ? .blue : /*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                             .task {
                                  summDataCatfunc(-999999999)
                                 //    .predCateg(1)
                                 categPredicate (category.categoryID)
                            }
                                
                                Text("")
                                    .foregroundColor(.gray)

                        }
                            //        let fred = category.categoryID
                           //         let ftor = category.catRashSumm
                            
                            
                        }
 

 
                    }
                }
            }
            
            
            
            Divider()
            


            
            
            
              //  .padding(50.0)

          // блок горизонталь

              // категории трат
              
          //  var temp: String = ""
              
// ВЫРЕЗАЕМ НИЖНИЙ БЛОК ОТ ПРЕДЫДУЩЕЙ ВЕРСИИ
/*
 
 ScrollView (.horizontal) {
                 HStack() {
                        ForEach(category) {category in
// проверка категории      Button("\(category.catShop!) \(category.categoryID)") {
                 
                        Button("\(category.catShop!)") {
                      //   dataStrCat = Data().calcShop("\(category.catShop!)")
                            categPredicate (category.categoryID)
                      }

                         .buttonStyle(.bordered)
                         .accentColor(category.catRashSumm ? .blue : /*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                         //        let fred = category.categoryID
                        //         let ftor = category.catRashSumm
                         .task {
                           //  if category.catRashSumm != true {
                                 // let nCat = Int(category.categoryID)
                               //   let nCat = category.categoryID
                                 let nCat = category.categoryID
                               //  reka(nCat)
                             reka(category.catRashSumm ?  Int16(1000) : nCat)                         //  }
                         }
                            
                     }

                  }
                 .padding(5.0)


          }
        //  .padding(.horizontal, 40.0)
          .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
          .frame(width: 320.0)
          // конец блока горизонталь

         Divider()
            
            
             .padding(.bottom, 5.0)
           // categoryItemID >= %i &&
            HStack {
                Button("ПО ВСЕМ КАТЕГОРИЯМ") {
                    
               hyhyhyh()
                }
                .frame(width: 320.0, height: 40.0)
                .background(Color("downgray"))
                .cornerRadius(3.0)
            }
            .font(.title3)

            Divider()
                .padding(.bottom, 25.0)
 */
 
/*              Text("""
                РАСХОДЫ
                по категории:
                \(totalAmount2)
                """)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(Color.purple)
              //
               // .padding(15.0)
                .multilineTextAlignment(.center)
                .frame(width: 550.0, height: 100.0)
             //   .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("downgray")/*@END_MENU_TOKEN@*/)
                .cornerRadius(3.0)
                .padding(.top, 5.0)
                .task {
                    let predicatesX = NSPredicate(format: "categoryItemID == 1" )
                    items2.nsPredicate = predicatesX
                }
*/
            
            Text("""
                РАСХОДЫ
                по всем категориям:
                \(totalAmount)
                """)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(Color.purple)
              //
               // .padding(15.0)
                .multilineTextAlignment(.center)
                .frame(width: 550.0, height: 100.0)
             //   .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("downgray")/*@END_MENU_TOKEN@*/)
                .cornerRadius(3.0)
                .padding(.top, 5.0)
                .task {
                        summDataCatfunc(-999999999)
                }
        }
   //     .padding(.top, 10.0)
        

    }

    
   func categPredicate (_ x:Int) -> FetchedResults<Item> {
        let predicates = NSPredicate(format: "categoryItemID >= %i", x )
        items.nsPredicate = predicates
        return items
    }

    func summDataCatfunc(_ x:Int32) -> Void {


         summCategory += (Int(x))
         if x == -999999999 {
             summCategory = 0
         }
    }
    
    func predicate03() {
       
    }
    
    func iuyt() {
        
    }
    
    func categPredicate (_ x:Int16)  {
        let predicates = NSPredicate(format: "categoryItemID = %i", x )
        items.nsPredicate = predicates
        return
    }
    
    private  func  hyhyhyh() {
      //  var f: Int
     //   f = 0
     //   refreshPage = true

      let formatter = DateIntervalFormatter()
          formatter.dateStyle = .short
          formatter.timeStyle = .none
         let startDate = Date()
          let endDate = Date(timeInterval: periodRaschet, since: startDate)
        let predicates = NSPredicate(format: "timestampData > %@", endDate as NSDate )
}


        func reka2() {
        
     let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestampData , ascending: true)]
        items.nsSortDescriptors = sortDescriptors
        
        let predicates = NSPredicate(format: "categoryItemID >=0" )
        items.nsPredicate = predicates
        

       // items.nsPredicate = predicateReka
        }
    
    
    func reka(_ nCat: Int16)  {
        
      predTextNcatTemp.append(" AND categoryItemID != \(nCat)")

       let formatter = DateIntervalFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
        let startDate = Date()
         let endDate = Date(timeInterval: periodRaschet, since: startDate)

      let predicates = NSPredicate(format: "timestampData > %@ \(predTextNcatTemp) ", endDate as NSDate )
       
       items.nsPredicate = predicates
    //    predicateReka = predicates

   }
    

    


     func catRashPredicate(_ x:Int16) {
         let yyyy = 5
        print(yyyy)
       // return
    }

    func addItem() {
           let newItem = Item(context: viewContext)
           newItem.mCatsData = dataStrCat
           newItem.timestampData = Date()
           newItem.summData = 100
           newItem.noteSummData = "info"
        //newItem.catRashSummBool = category.
           
           do {
               try viewContext.save()
                trigerOne = true
                   dataStrCat = ""
               print ("Запись сделали")
           }
           catch {

               let nsError = error as NSError
               fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           }
   }
    
    
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {

                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
    //    summDataCatfunc(-10)
    }
 /*   func AllSumm(_ summ: Int) -> Int{
        categoryAllSumm = categoryAllSumm + summ
return categoryAllSumm
    }
*/
/*   func rrrr() ->Int32 {
        items.summData.forEach {
            summAll += $0
        }
       return summAll

    }
*/
    
}




/*
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
*/


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
         //  .environment(\.managedObjectContext, periodRaschet)

    }
}


