//
//  ContentItemView.swift
//  SilverMoney
//
//  Created by Georgeus on 15.06.2023.
//

import SwiftUI
import CoreData





struct ContentItemView: View {


 	@Environment(\.managedObjectContext) private var viewContext
    @Environment(\.refresh) private var refresh
    @Environment(\.dismiss) var dismiss // для удаления кнопки назад
    

@Binding var gggg: String
@Binding var cccc: Int
    
    @AppStorage("periodRaschetText") var periodRaschetText: String = "Сегодня"
    @AppStorage("SummAllCategory") var summAllCategory: String = "0" // предел трат для всех категорий
    @AppStorage("SummAllCategoryTrigger") var summAllCategoryTrigger: Bool = false // включение предел трат для всех категорий
    @AppStorage("periodRaschet") var periodRaschet: Int = 0
    
    
    @AppStorage("summAllCategoryTriggerDay") var summAllCategoryTriggerDay: Bool = false
    @AppStorage("summAllCategoryTriggerWeek") var summAllCategoryTriggerWeek: Bool = false
    @AppStorage("summAllCategoryTriggerMotch") var summAllCategoryTriggerMotch: Bool = false
    
    @AppStorage("summAllCategoryDay") var summAllCategoryDay: String = "0"
    @AppStorage("summAllCategoryWeek") var summAllCategoryWeek: String = "0"
    @AppStorage("summAllCategoryMoutch") var summAllCategoryMoutch: String = "0"
    
            @AppStorage("categoryItemsG") var categoryItemsG: Int = 0

    
    //  @State	 var periodRaschet =  0
    @State	private var showingSheet = false
    @State	private	var categoryAll: Bool = true // выбор между показывать сумму по всем категориям или по одной
   // @State	private	var totalAmountAllCateg: Int32 = 0
    @State	private	var totalAmount3: Int32 = 0
    @State	private	var TextSummCatAllandCatOnly: String = "учтено по всем категориям:"
    @State  private	var tempText: String = ""
    @State  private	var predTextNcatTemp: String = ""
    @State	private var summCategList: Int32 = 0 //вывод суммы категории в списке смотреть расходы
    //  @State var summAllCategoryInt: Int = 10000000000
    
    @State   var includedTotalExpenses: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)], //\Item.summData
        predicate: NSPredicate(format: "categoryItemID >= 0 " ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
      var items8: FetchedResults<Item>
     
      @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)], //\Item.summData
        predicate: NSPredicate(format: "categoryItemID >= 0 " ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
      var items9: FetchedResults<Item>
 
 @State var yyyyy = false

var itemsCtegL: Int16 = 0



/*
 
 
    //"timeStampData > %@  AND (categoryItemID == 1000 \(predTextNcatTemp) )", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)], //\Item.summData
        predicate: NSPredicate(format: "categoryItemID >= 0 " ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
     var itemsDay: FetchedResults<Item>
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)], //\Item.summData
        predicate: NSPredicate(format: "categoryItemID >= 0 " ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
    private var itemsWeek: FetchedResults<Item>
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)], //\Item.summData
        predicate: NSPredicate(format: "categoryItemID >= 0 " ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
    private var itemsMontch: FetchedResults<Item>
    
    @FetchRequest(
        //   sortDescriptors: [],
        //sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
        sortDescriptors: [sort1, sort2],
        predicate: NSPredicate(format: "categoryID >= 0"),
        animation: .default)
     var category: FetchedResults<Category>
    
    @FetchRequest(
        //   sortDescriptors: [],
        //sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
        sortDescriptors: [sort1, sort2],
        predicate: NSPredicate(format: "categoryID <= 0 AND catRashSumm == 1"),
        animation: .default)
     var category2: FetchedResults<Category>
    
    
    // используется для подсчета  суммы категориях
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.summData , ascending: true)],
        predicate: NSPredicate(format: "categoryItemID >= 0" ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
    private var itemsC: FetchedResults<Item>
    
    
    // используется для подсчета общей суммы
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.summData , ascending: false)],
        predicate: NSPredicate(format: "categoryItemID >=0" ),
        animation: .default)
    private var itemsC2: FetchedResults<Item>
    
    
    // используется для расчета суммы по каждой категории в списке категорий
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.summData , ascending: false)],
        predicate: NSPredicate(format: "categoryItemID == 0" ),
        animation: .default)
    private var ItemSummCategListPredicate: FetchedResults<Item>
    
    
    //подсчет суммы в категории
    private	var	totalAmount2: Int32 {
        return itemsC.reduce(0) { $0 + $1.summData }
    }
    
    // подсчет общей суммы
    private	var	totalAmount4: Int32 {
        return itemsC2.reduce(0) { $0 + $1.summData }
        
    }
    
    var temp03: Bool {
        showingSheet ? true : false
    }
    
    @State var ytre: Bool = true
    
    
    
    //   @State var arrowOpacity: Double = 1.0  // отвечает за появеление указателя превышения суммы, зависит от красного цвета!
    
    @State	private var showingSheetCateg2 = false
    
    @State var totalAmountTrigger: Bool = true   // если true - подсвечивает сумму по всем категориям, если false - по конкретной категории
    
    @State var colorTotalAmount: Color = Color.gray
    @State var colorCategoryAmount: Color = Color.gray
    
    @State var pendingPerPeriod = 1000000000
    
    @State var allAxcessView: Bool = true // по всем категогиям / конкретная категория
    
    @State var trigger89 = false
    
    @State var itemsCtegL: Int16 = 0
    
    
    @State var predicatesC9 = NSPredicate(format: "categoryItemID >= 0" )
    
    
    var totalAmountColor: Color {
        if totalAmountTrigger == true {
            return  colorTotalAmount
        }
        if totalAmountTrigger == false {
            return colorCategoryAmount
        }
        else {
            return Color.gray
        }
    }
    // возможно будет убрать ?? проверяй
    var arrowOpacity2: Double {
        if colorCategoryAmount == Color.red {
            return 1.0
        }
        else {
            return 0.5
        }
        
        
        //  return 0.0
    }
    
    
        //  -------------------------- подсветка цветом д / н/ м/ напротив суммы
    var allCategoryLimitDay: Bool {
        if summAllCategoryTriggerDay == true {
            if totalAmountDay >= Int(summAllCategoryDay) ?? 0 {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    var allCategoryLimitWeek: Bool {
        if summAllCategoryTriggerWeek == true {
            if totalAmountWeek >= Int(summAllCategoryWeek) ?? 0  {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    var allCategoryLimitMotch: Bool {
        if summAllCategoryTriggerMotch == true {
            if totalAmountMontch >= Int(summAllCategoryMoutch) ?? 0  {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
   //var firstDayOfWeek: Locale()
        //.Weekday
        //.Weekday.firstDayOfWeek
    //   --------------------------
    
  //  var weekdaySymbol: Date = Date()
 //   var oo: Date =  weekdaySymbol
    
  //  let date = Date()
 //  let myCalendar = Calendar(identifier: .gregorian)
   // let ymd = myusCalendar.components([.year], from: Date())
   // let fff = calendar(.firstWeekday)
    // let year
    // let month = calendar.component(.month, from: date)
    //  let weekday = calendar.component(.weekday, from: date) //(.oneDigit)
    // let day = calendar.component(.day, from: date)
  //  let hour = calendar.component(.hour, from: date)
  //  let minute = calendar.component(.minute, from: date)
    

 
    var totalAmountDay: Int32 {
        return itemsDay.reduce(0) { $0 + $1.summData }
    }
    
        var totalAmountWeek: Int32 {
            return itemsWeek.reduce(0) { $0 + $1.summData }
        }
    
    var totalAmountMontch: Int32 {
        return itemsMontch.reduce(0) { $0 + $1.summData }
    }

   
   
   
   */

   
   @State var showingSheetCateg3 = false
   
   @State var trigger99 = false
   
   @State var trigger89 = false

   
      @State   var itemsCtegoryToContentItems: Int16 = 0
        // @State var ggg:Int16 = 1
      
//   var ggg: Int16

var totalAmountAllCateg: Int32 {
return items9.reduce(0) { $0 + $1.summData }
}
    

    var body: some View {



VStack{

            HStack{
                Text("Расходы"  )
                    .font(.title)
                    .fontWeight(.bold)

                Text ("•")
                    .foregroundColor(Color.red)
                //Text ("•")
                //.font(.title3)
                //.fontWeight(.bold)
                       .task{  reca2(Int16(categoryItemsG))}
                       
//.task{  reca2(gggg)}
                Label("", systemImage: "arrow.down.to.line")
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
                
             ZStack{
                    Label("", systemImage: "gearshape.2")
                        .padding(.leading, 5.0)
                        .font(.title2)
                        .onTapGesture(perform: {
                           showingSheetCateg3.toggle()
                        })
                        .sheet(isPresented: $showingSheetCateg3) {
                            SettingView()
                       }
                    //	Text("i")
                    //		.font(.headline)
                    //		.foregroundColor(Color.white)
 
                }
     
            }
            
            .frame(width: 360.0, height: 30.0, alignment: .leading)
            
            
            //	.task { test01() }
            //	.task {totalAmaunt4Raschet()}
            
            Divider()
                .frame(width: 360.0)
            
            ZStack {
            
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("AccentColor")/*@END_MENU_TOKEN@*/)
                    .colorInvert()
                    .opacity(0.0)
                
                VStack(alignment: .leading) {
                HStack{
                /*
                    Text("Категория ")
                   .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .dynamicTypeSize(.xxxLarge)
                        .padding(.top, 1.0)
                       */
                        
                    
                   Text("\(gggg)")
                       .fontWeight(.medium)
                       .font(.title3)
                        .foregroundColor(Color.green)
                        .dynamicTypeSize(.xxxLarge)
                        
                //        Text("\(cccc)")
                  //     .fontWeight(.medium)
                  //     .font(.title3)
                   //     .foregroundColor(Color.green)
                   //     .dynamicTypeSize(.xxxLarge)
                        
               
                    }
                    Spacer()
                    Text("Период:")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .dynamicTypeSize(.xxxLarge)
                        .padding(.top, 1.0)
                    
                    
                    Text ("\(periodRaschetText)")
                        .fontWeight(.medium)
                        .font(.subheadline)
                        .foregroundColor(Color.green)
                        .dynamicTypeSize(.xxxLarge)
                       
     //    Text("\(gggg)")


                    
                    Spacer()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Сумма: ")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                                .padding(.top, 1.0)
                                .dynamicTypeSize(.xxxLarge)
                            
                            HStack{
                                Text ("\(totalAmountAllCateg)")
                                    .font(.subheadline)
                                   .foregroundColor(Color.green)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 0.0)
                                    .dynamicTypeSize(.xxxLarge)
   //                                 .task{predTextNcatTemp = ""
  //                                  }
                                Label("", systemImage: valutaSymbol)
                                // .foregroundColor(totalAmountColor)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        // показывает превышение установленного лимита
  /*                      VStack(alignment: .trailing){
                            HStack{
                            Text("день")
                            .foregroundColor(.gray)
                                Label("", systemImage: allCategoryLimitDay ? "arrow.up.circle" : "smallcircle.filled.circle")
                              //  Spacer()
                                

                            }
                            .foregroundColor(allCategoryLimitDay ? .red : .green)
                            .opacity(summAllCategoryTriggerDay ? 0.7 : 0.0)

                            
                            HStack{
                            Text("неделя")
                                                        .foregroundColor(.gray)

                                Label("", systemImage: allCategoryLimitWeek ? "arrow.up.circle" : "smallcircle.filled.circle")
                              //  Spacer()
                                
                            }
                            .foregroundColor(allCategoryLimitWeek ? .red : .green)
                            .opacity(summAllCategoryTriggerWeek ? 0.7 : 0.0)
                            
                            HStack{
                            Text("месяц")
                                                        .foregroundColor(.gray)

                                Label("", systemImage: allCategoryLimitMotch ? "arrow.up.circle" : "smallcircle.filled.circle")
                             //   Spacer()
                                
                            }
                            .foregroundColor(allCategoryLimitMotch ? .red : .green)
                            .opacity(summAllCategoryTriggerMotch ? 0.7 : 0.0)
                                                        
                        }
                        //.padding(.trailing, 2.0)
                        .frame(width: 110.0, height: nil)
                        .opacity(allAxcessView ? 1.0 : 0.0)
                        .font(.callout)

                        .task {
 //                           DayWeekMonthPredicate()
                        }
                       
                       
  */
                       
                    }
                }
                .frame(width: 360.0,  alignment: .leading)
                .padding(.top, 10.0)
                
            }
            .frame(width: 360.0, height: 160.0)

            Divider()
            
                         NavigationView {

                                    List{

                                       ForEach(items9) { item in   //ForEach(items, id:\.self)
                                            //  if item.categoryItemID == categoryID { // подбор чеков соответствующей категории
                                            NavigationLink(){
                                           
                                                Form {
                                               
                                                    TextEditor(text: $tempText)
                                                        .frame(height: 100.0)
                                                        .task{tempText=item.noteSummData!}
                                                    HStack{
                                                        Text ("Комментарий к сумме: \(item.summData )")
                                                        Label("", systemImage: valutaSymbol)
                                            }
                                                    .font(.body)

                                                }
                                // .foregroundColor(totalAmountColor)
                                    .foregroundColor(.gray)
                                                .scrollContentBackground(.hidden)
                                               // .navigationBarBackButtonHidden(true) // скрытие кнопки назад
                                                // записываем изменения при выходе из формы (при нажатии кнопки назад)
                                                .onDisappear(perform: {if tempText != "" {
                                                    item.noteSummData = self.tempText
                                                    try? self.viewContext.save()
                                                    tempText = ""
                                                }
                                                })
                                              
                                            }

                                        label: {
                                            HStack(alignment: .top)  {
                                                
                                                Text(item.timeStampData!,  style: .date)
                                                // для OC 16             .fontWeight(.light)
                                                    .foregroundColor(Color.gray)
                                                    .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(1)
                                                    .frame(maxWidth: 120.0, alignment: .leading)
                                                    .frame(height: 35.0)
                                                    .font(.body)

//                                                    .onChange(of: totalAmount5) { newValue in
 //                                                       totalAmountTrigger = false
//                                                        colorCategoryAmount = colorAmount2
//                                                    }
                                                                                                              
                                                Spacer()
                                                
                                                Text(" \(item.summData )")
                                                    .frame(maxWidth: 200.0, alignment: .trailing)
                                                    .multilineTextAlignment(.trailing)
                                                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                                    .frame(height: 35.0)
                                                    .font(.body)
                                                //  .padding(.all, 8.0)
                                                
                                                Label("", systemImage: valutaSymbol)
                                                    .frame(maxWidth: 30.0, alignment: .trailing)
                                                    .frame(height: 35.0)
                                                    .font(.body)
                                                
                                                    .multilineTextAlignment(.trailing)
                                                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                            }
                                            .font(.body)
                                        }
                                        .frame(width: 320.0, alignment: .leading)
                                        }
                              //          }
 //                                       .onDelete(perform: deleteItems)
                                    }
                                    .scrollContentBackground(.hidden)

//                                    .onAppear {selfCategorySummTimeShtamp(categoryID, colorAmount2)}
  //                                  .task { TextSummCatAllandCatOnly = "Категория \(category.catShop!)" }
                                }
                         //  .task{reca2(ggg)}     



Spacer()


            Divider()

            //          .padding(.bottom, 20.0)
        }
        .padding(.top, 20.0)
        .padding(.bottom, 5.0)
        .task{yyyyy = true}
		

            //  .task{print("reca2")}
//.task{print(ggg)}

      //  .task{print(itemsCtegL)}
//.task{ContentItem().reca()}
//.task{print(itemsCtegoryToContentItems)}

    }




     func reca1 (_ rrr:Int16) -> Void  {
     //ggg = rrr
   //  print("изменился")
    // print(ggg)
  
 //  reca2(rrr)
 
     trigger99 = true
return
}

func reca()  {

}

func reca2(_ itemsCteg:Int16)  { //_ itemsCteg:Int16

  
        //	let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)]  //отвечает за сортировку при выводе чеков
        //	items.nsSortDescriptors = sortDescriptors
        //		let predicates = NSPredicate(format: "categoryItemID >=0" )
        //		items.nsPredicate = predicates
        //let predicatesC7 = NSPredicate(format: "categoryItemID == \(itemsCteg) " )//, itemsCteg
// let predicatesC9 = NSPredicate(format: "categoryItemID == %@ ", itemsCteg as NSNumber) //\(itemsCteg)
//let predicatesC7 = NSPredicate(format: "categoryItemID >= 0 " )//

        //	let predicatesR = NSPredicate(format: "timeStampData > %@",  Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate)
let predicatesC91 = NSPredicate(format: "categoryItemID >= 0 ")
items9.nsPredicate = predicatesC91


let predicatesC92 = NSPredicate(format: "categoryItemID == %@ AND timeStampData > %@", itemsCteg as NSNumber, Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate) 
items9.nsPredicate =  predicatesC92
//	if trigger99 == true {
//	items9.nsPredicate = predicatesC8
//    }
	//	items9.nsPredicate = predicatesC8
	// items9.nsPredicate =  predicatesC92
	trigger89 = true

//print(itemsCteg)
             //     Task {
           //     await refresh?()
       //    }
        // ПРОВЕРИТЬ ЭТО НУЖНО?
        /*
         totalAmountTrigger = true
         if (totalAmount5 <= summAllCategoryInt) || (totalAmount5 < pendingPerPeriod) {
         colorTotalAmount = Color.green
         }
         if (totalAmount5 > summAllCategoryInt) || (totalAmount5 >= pendingPerPeriod){
         colorTotalAmount = Color.red
         }
         else {
         colorTotalAmount = Color.green
         }
         
         
         //  colorTotalAmount = Color.green
         
         */
        //reka (
      return
    }

func reca3() {

        //	let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)]  //отвечает за сортировку при выводе чеков
        //	items.nsSortDescriptors = sortDescriptors
        //		let predicates = NSPredicate(format: "categoryItemID >=0" )
        //		items.nsPredicate = predicates
       //    let predicatesC7 = NSPredicate(format: "categoryID >= 0")//

        //	let predicatesR = NSPredicate(format: "timeStampData > %@",  Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate)
 // category.nsPredicate = predicatesC7
     //  print(3)
        
        
        
        // ПРОВЕРИТЬ ЭТО НУЖНО?
        /*
         totalAmountTrigger = true
         if (totalAmount5 <= summAllCategoryInt) || (totalAmount5 < pendingPerPeriod) {
         colorTotalAmount = Color.green
         }
         if (totalAmount5 > summAllCategoryInt) || (totalAmount5 >= pendingPerPeriod){
         colorTotalAmount = Color.red
         }
         else {
         colorTotalAmount = Color.green
         }
         
         
         //  colorTotalAmount = Color.green
         
         */
        //reka (
     //  return
    }


}


struct ContentItem {


func reca(_ itemsCteg:Int16) {


// let predicatesC8 = NSPredicate(format: "categoryItemID == \(itemsCteg) " )
//let predicatesC7 = NSPredicate(format: "categoryItemID >= 0 " )//

        //	let predicatesR = NSPredicate(format: "timeStampData > %@",  Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate)
	//ContentItemView().itemsDay.nsPredicate = predicatesC8
        
        
        // ПРОВЕРИТЬ ЭТО НУЖНО?
        /*
         totalAmountTrigger = true
         if (totalAmount5 <= summAllCategoryInt) || (totalAmount5 < pendingPerPeriod) {
         colorTotalAmount = Color.green
         }
         if (totalAmount5 > summAllCategoryInt) || (totalAmount5 >= pendingPerPeriod){
         colorTotalAmount = Color.red
         }
         else {
         colorTotalAmount = Color.green
         }
         
         
         //  colorTotalAmount = Color.green
         
         */
        //reka (
    //   return
    }
    
    func reca2() {

        //	let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)]  //отвечает за сортировку при выводе чеков
        //	items.nsSortDescriptors = sortDescriptors
        //		let predicates = NSPredicate(format: "categoryItemID >=0" )
        //		items.nsPredicate = predicates
        //    let predicatesC0 = NSPredicate(format: "categoryID >= 0" )//

        //	let predicatesR = NSPredicate(format: "timeStampData > %@",  Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate)
 //ContentItemView().category2.nsPredicate = predicatesC0
   //     print(predicatesC0)
        
        
        
        // ПРОВЕРИТЬ ЭТО НУЖНО?
        /*
         totalAmountTrigger = true
         if (totalAmount5 <= summAllCategoryInt) || (totalAmount5 < pendingPerPeriod) {
         colorTotalAmount = Color.green
         }
         if (totalAmount5 > summAllCategoryInt) || (totalAmount5 >= pendingPerPeriod){
         colorTotalAmount = Color.red
         }
         else {
         colorTotalAmount = Color.green
         }
         
         
         //  colorTotalAmount = Color.green
         
         */
        //reka (
     //  return
    }



}

struct ContentItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContentItemView(gggg: .constant(""), cccc: .constant(Int()))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


