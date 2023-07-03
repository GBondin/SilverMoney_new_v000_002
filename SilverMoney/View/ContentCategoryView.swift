//
//  ContentCategoryView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 4/1/23.
//

import SwiftUI
import CoreData





struct ContentCategoryView: View {
    


    
    @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: true)],
    //  sortDescriptors: [],
    predicate: NSPredicate(format: "categoryItemID >=0" ),
     // predicate: NSPredicate(format: "timeStampData <= 2023-03-28 06:04:10 +0000"),
    //   sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData, ascending: false)],
    // predicate: NSPredicate(format: "mCatsData = %@ || mCatsData = %@", "товары", "услуги", "продукты"),
    //   predicate: NSPredicate(format: "mCatsData = %@ || mCatsData = %@ || mCatsData = %@", "товары", "услуги", "продукты"),
    //   predicate: nil,
    //  predicate: NSPredicate(format: "categoryItemID >= %i", 1),
    // predicate: NSPredicate(format: "categoryItemID >= %i", 1 ),
      //  predicate: NSPredicate(format: "summData > %i", 500),

      //       predicate: predicate,
       animation: .default)

      private var items: FetchedResults<Item>

      @FetchRequest(
    //sortDescriptors: [])
         sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
       //  predicate: NSPredicate(format: "categoryID >= 0"),
         animation: .default)
    //    private var category: FetchedResults<Category>
      var category: FetchedResults<Category>
    //   @FetchRequest(entity: [Item.entity(), Category.entity()],
    //                 sortDescriptors: [])
    
    
    @State var summCategory: Int = 0

    @State   var fullText: String = ""

    
    
    var body: some View {
        


        
        
 //    NavigationView {
 //       List {
 //               ForEach(category) {category in
  //                  let categoryID = 1//category.categoryID

  //                NavigationLink() {
 //                     Text("траты по категории \(category.catShop!) \(summCategory)")
                        

 //                        NavigationView {
       //                             List{

                                           ForEach(items, id:\.self) { item in
                           //                    if item.categoryItemID == categoryID { // подбор чеков соответствующей категории
                                            NavigationLink()
                                                   {     //destination:

                                                  Text("\(item.summData)  \(category[Int(item.categoryItemID)].catShop!)")
                        //                           Form {
                        //                           TextField("\(item.noteSummData!)", text: $fullText)
                         //                                  .task {
                         //                                          summDataCatfunc(-999999999)
                         //                                  }
                        //                           }
                                                
                                                 //  item.noteSummData = $fullText
                                                //   try? viewContext.save()
                                                 //  $fullText = ""
                                               }
                                                 
                                           label: {
 //                                              HStack(alignment: .top)  {
                                               HStack()  {
                                                 //  Text("\(item.categoryItemID)") // номер категории
                                                 //  Text("\(categoryID)")

                    Text("траты по категории ")
                                              Text(item.timeStampData!,  style: .date)
// для OC 16                                                       .fontWeight(.light)
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
                               
                                                   // .padding(.leading, 0.0)
                                                   //   Spacer()
                                                   //  Text("\(item.mCatsData!)")
                                                   // проверка категории     Text("\(item.categoryItemID)")
   

                                               }
   
   
   

                                           }
                                           }
                                           }
//                                       .onDelete(perform: deleteItems)
                                       
                                       // addItem()
                  
    
    func predCateg() {
        
        let predicates = NSPredicate(format: "categoryItemID =@%, 1" )
         
         items.nsPredicate = predicates

    }
    
    
    
    
                                   }

                                   //  .frame(height: 400.0)
//           .frame(maxHeight: 600.0)
//          .background(.white)

                      //           .refreshable {
                       //                summDataCatfunc(-999999999)}
                                  //     addItem() }
                                   //  .padding(10.0)
                                   //   .frame(width: 320.0, height: 300.0)

// if                            }
//                    }
/*                   label: {
                        HStack() {
                        Text("\(category.catShop!)")
 //                        .foregroundColor(category.catRashSumm ? .blue : /*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                         .task {
                                 summDataCatfunc(-999999999)
                         }
                            Text("")
                                .foregroundColor(.gray)

                    }
                        //        let fred = category.categoryID
                       //         let ftor = category.catRashSumm
                        
                        
                  }
 */
                    
    

    
    
    
 //               }
  //          }
 //       }
//    }
    








//}







struct ContentCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentCategoryView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
