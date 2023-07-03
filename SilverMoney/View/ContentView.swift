//
//  ContentView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/19/23.
//

import SwiftUI
import CoreData

// MARK: разобраться
var trigerOne: Bool = false

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.refresh) private var refresh
    @Environment(\.dismiss) var dismiss // для удаления кнопки назад
    
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
    
    
    //  @State	 var periodRaschet =  0
    @State	private var showingSheet = false
    @State	private	var categoryAll: Bool = true // выбор между показывать сумму по всем категориям или по одной
    @State	private	var totalAmount5: Int32 = 0
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
    private var items: FetchedResults<Item>
    
    //"timeStampData > %@  AND (categoryItemID == 1000 \(predTextNcatTemp) )", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)], //\Item.summData
        predicate: NSPredicate(format: "categoryItemID >= 0 " ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
    private var itemsDay: FetchedResults<Item>
    
    
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
    private var category: FetchedResults<Category>
    
    @FetchRequest(
        //   sortDescriptors: [],
        //sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
        sortDescriptors: [sort1, sort2],
        predicate: NSPredicate(format: "categoryID >= 0 AND catRashSumm == 1"),
        animation: .default)
    private var category2: FetchedResults<Category>
    
    
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
 
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Расходы"  )
                    .font(.title)
                    .fontWeight(.bold)
                    .task{DayTimer(periodRaschetText)}
                  

                Text ("•")
                    .foregroundColor(Color.red)
                //Text ("•")
                //.font(.title3)
                //.fontWeight(.bold)
                Label("", systemImage: "arrow.down.to.line")
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
                
                ZStack{
                    Label("", systemImage: "gearshape.2")
                        .padding(.leading, 5.0)
                        .font(.title2)
                        .onTapGesture(perform: {
                            showingSheetCateg2.toggle()
                        })
                        .sheet(isPresented: $showingSheetCateg2) {
                            SettingView()
                        }
                    //	Text("i")
                    //		.font(.headline)
                    //		.foregroundColor(Color.white)
                    
                }
            }
            .padding(.horizontal, 20.0)
            .frame(height: 30.0, alignment: .leading)
            
            
            //	.task { test01() }
            //	.task {totalAmaunt4Raschet()}
            
            Divider()
                            .padding(.horizontal, 10.0)

            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("AccentColor")/*@END_MENU_TOKEN@*/)
                    .colorInvert()
                    .opacity(0.0)
                
                VStack(alignment: .leading) {
                    Text("\(TextSummCatAllandCatOnly)")
                        .fontWeight(.medium)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .dynamicTypeSize(.xxxLarge)
                    
                    
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
                        .onChange(of: periodRaschetText) { newValue in
                            hyhyhyh()
                        }

               

                    
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
                                Text ("\(totalAmount5)")
                                    .font(.subheadline)
                                   .foregroundColor(Color.green)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 0.0)
                                    .dynamicTypeSize(.xxxLarge)
                                    .task{predTextNcatTemp = ""
                                    }
                                Label("", systemImage: valutaSymbol)
                                // .foregroundColor(totalAmountColor)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        // показывает превышение установленного лимита
                        VStack(alignment: .trailing){
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
                            DayWeekMonthPredicate()
                        }
                        
                    }
                }
                .frame(alignment: .leading)
                .padding(.top, 10.0)
                            .padding(.horizontal, 20.0)

            }
            .frame(height: 160.0)
                       // .padding(.horizontal, 10.0)

            Divider()
                        .padding(.horizontal, 10.0)

            Spacer()

            // MARK: Будущий функционал
            // MARK: Block SORT START
            /*
             VStack{
             Text("Сортировать")
             
             HStack{
             Text("по порядку")
             .task{
             
             }
             Spacer()
             
             Text("по большей сумме трат")
             .task{
             
             }
             
             }
             }
             .frame(width: 350.0)
             
             */
            
            // MARK: Block LIST START
            
            NavigationView {
                List {
                    ForEach(category) {category in
                        if category.categoryID >= 1 {
                            
                            let categoryID = category.categoryID
                            
                            // подсчет суммы в категории
                            let summCategList = raschetSummCategList(category.categoryID, category.catRashSumm)
                            
                            //MARK: требует правки периода!
                            // выделение цветом мульки при превышении трат
                            let colorAmount2 = colorAmontF(summCategList, category.amountSpendingPerWeek, category.amountSpendingPerMonth ) //подсветка цветом суммы в строке категории
                            
                            // мулька в категории при превышении трат
                            var arrowOpacity: Double {
                                if category.monthThirtyDaysBack == true || category.weekSevenDayBack == true {
                                    return 1.0
                                }
                                else {
                                    return 0.15
                                }
                            }
                            
                            NavigationLink() {
                                NavigationView {
                                    List{
                                        ForEach(items) { item in   //ForEach(items, id:\.self)
                                            //  if item.categoryItemID == categoryID { // подбор чеков соответствующей категории
                                            NavigationLink(){
                                                Form {
                                                    TextEditor(text: $tempText)
                                                        .frame(height: 100.0)
                                                        .task{tempText=item.noteSummData!}
                                                    Text ("Комментарий к сумме: \(item.summData )")
                                                }
                                                .scrollContentBackground(.hidden)
                                                .navigationBarBackButtonHidden(true) // скрытие кнопки назад
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
                                                 //   .frame(height: 35.0)
                                                    .font(.body)
                                                    .onChange(of: totalAmount5) { newValue in
                                                        totalAmountTrigger = false
                                                        colorCategoryAmount = colorAmount2
                                                    }
                                                
                                                Spacer()
                                                
                                                Text(" \(item.summData )")
                                                    .frame(maxWidth: 200.0, alignment: .trailing)
                                                    .multilineTextAlignment(.trailing)
                                                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                                   // .frame(height: 35.0)
                                                    .font(.body)
                                                //  .padding(.all, 8.0)
                                                
                                                Image(systemName: valutaSymbol)
                                                    .frame(maxWidth: 30.0, alignment: .trailing)
                                                  //  .frame(height: 35.0)
                                                    .font(.body)
                                                
                                                    .multilineTextAlignment(.trailing)
                                                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                            }
                                            .font(.body)

                                        }
                                        .frame(alignment: .leading)

                                        }
                                        .onDelete(perform: deleteItems)

                                    }
                                    .scrollContentBackground(.hidden)
                                    .onAppear {selfCategorySummTimeShtamp(categoryID, colorAmount2)}
                                    .task { TextSummCatAllandCatOnly = "Категория \(category.catShop!)" }

                                }

                            }

                        label: {
                            HStack() {
                                Text("\(category.catShop!) " )
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(category.catRashSumm ? myColor.GBlue : .gray)
                                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xLarge/*@END_MENU_TOKEN@*/)
                                    .onChange(of: category.catRashSumm) { newValue in
                                       hyhyhyh()
                                    }
                                    //.task{category.catRashSumm ? hyhyhyh() : hyhyhyh()}
                                //							.task  {reka(category.catRashSumm, category.categoryID)
                                
                                //							}
                                Spacer()
                             
                                   Text("\(summCategList)")
                                        .fontWeight(.regular)
                                    Group{
                                 // Label("", systemImage: valutaSymbol)
                                  Image(systemName: valutaSymbol)
                                     //   .padding(.vertical, -10.0)
                                       //                        .frame(height: 10.0)

                                      //  .frame(width: 25.0)
                                    //    .padding(.trailing, -15.0)
                                  //      .foregroundColor(.gray)
                                      //  .fontWeight(.light)
                                    }
                                    Image(systemName: (colorAmount2 == .red) ? "arrow.up.circle" :  "smallcircle.filled.circle" )
                         //               .padding(.trailing, -15.0)
                         //               .foregroundColor(colorAmount2)
                          //              .opacity(arrowOpacity)
                              
                              //  .frame(height: 5.0)

                            }
                            .frame(height: 38.0)
                        }
                                           .padding(.horizontal, -10.0)

                            //						.refreshable (){
                        }
                    }
                   // .padding(.vertical, 6.0)
                    .scrollContentBackground(.hidden)
                    .task{ hyhyhyh() }
                }
            }
          //  .padding(.bottom, 5.0)
                .scrollContentBackground(.hidden)
            Divider()
            //          .padding(.bottom, 20.0)
                        .padding(.horizontal, 10.0)

        }
        .padding(.top, 20.0)
        .padding(.bottom, 5.0)
        
    }

    
    // расчет суммы внути категории с учетом заданного временного промежутка
    func selfCategorySummTimeShtamp (_ x:Int16, _ colorAmount2:Color)  {
        categoryAll = false
        let predicates = NSPredicate(format: "categoryItemID = %i AND timeStampData > %@", x, Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate)
        items.nsPredicate = predicates
        itemsC.nsPredicate = predicates
        totalAmount5 = totalAmount2
        totalAmountTrigger = false
        colorCategoryAmount = colorAmount2
        allAxcessView = false
        return
    }
 /*
    func test01 ()  {
        //categoryAll = false
        let predicates = NSPredicate(format: "catRashSumm == 1")
        category2.nsPredicate = predicates
        return
    }

*/
    // catRashSumm = true AND
    
    
    //MARK: Сортировка по максимальной сумме
    func  sortMaxSumm() {
        
        for category2 in category2 {
            predTextNcatTemp.append(" OR categoryItemID == \(category2.categoryID) ")
        }
        //    let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)]  //отвечает за сортировку при выводе чеков
        //    items.nsSortDescriptors = sortDescriptors
        //        let predicates = NSPredicate(format: "categoryItemID >=0" )
        //        items.nsPredicate = predicates
        let predicatesC2 = NSPredicate(format: "timeStampData > %@  AND (categoryItemID == 1000 \(predTextNcatTemp) )", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )//
        //    let predicatesR = NSPredicate(format: "timeStampData > %@",  Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate)
        //itemsC2.nsPredicate = predicatesR
        itemsC2.nsPredicate = predicatesC2
        predTextNcatTemp = ""
        totalAmount5 = totalAmount4
        TextSummCatAllandCatOnly = "По всем категориям:"
        //reka (
        return
    }
    
    
    func DayWeekMonthPredicate(){
        
        let date = Date()
        let calendar = Calendar.current
        
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
            //   let weekday = calendar.component(.weekdayOrdinal, from: date)
            // let day = calendar.component(.day, from: date)
            //  let weekOfYear = calendar.component(.weekOfYear, from: date)
        
        let periodDay = hour * 3600 + minute * 60
        let predicatesDay = NSPredicate(format: "timeStampData > %@ AND categoryItemID >= 0 ", Date().addingTimeInterval(TimeInterval(-periodDay)) as NSDate )//
        
        
        let periodWeek = (6 * 24)  * 3600  + hour * 3600 + minute * 60
        let predicatesWeek = NSPredicate(format: "timeStampData > %@ AND categoryItemID >= 0 ", Date().addingTimeInterval(TimeInterval(-periodWeek)) as NSDate )//
        
        let periodMontch = (29 * 24)  * 3600 +  hour * 3600 + minute * 60
        let predicatesMontch = NSPredicate(format: "timeStampData > %@ AND categoryItemID >= 0 ", Date().addingTimeInterval(TimeInterval(-periodMontch)) as NSDate )//
        
        itemsDay.nsPredicate = predicatesDay
        itemsWeek.nsPredicate = predicatesWeek
        itemsMontch.nsPredicate = predicatesMontch
        
    }
    
   
    //Рабочее
    // Нужно придумть название
    // расчет и вывод суммы трат по всем категориям
    // разобраться с предикатами
    func  hyhyhyh() {
        for category2 in category2 {
            predTextNcatTemp.append(" OR categoryItemID == \(category2.categoryID) ")
        }
        //	let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)]  //отвечает за сортировку при выводе чеков
        //	items.nsSortDescriptors = sortDescriptors
        //		let predicates = NSPredicate(format: "categoryItemID >=0" )
        //		items.nsPredicate = predicates
        let predicatesC2 = NSPredicate(format: "timeStampData > %@  AND (categoryItemID == 1000 \(predTextNcatTemp) )", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )//
        //	let predicatesR = NSPredicate(format: "timeStampData > %@",  Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate)
        //itemsC2.nsPredicate = predicatesR
        itemsC2.nsPredicate = predicatesC2
        predTextNcatTemp = ""
        
        totalAmount5 = totalAmount4
        TextSummCatAllandCatOnly = "По всем категориям:"
        allAxcessView = true
        
        
        
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
    
    // в зависимости от конкретной категории и времени?
    // Нужно придумть название
    // требуется пояснение для чего
    // разобраться с предикатами
   
   /*
    func reka( _ catRashSumm: Bool, _ nCat: Int16) {
        
        categoryAll = true //?
        
        if catRashSumm == true {
            predTextNcatTemp.append(" OR categoryItemID == \(nCat) ")
            //	print (nCat)
        }
        let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)]
        items.nsSortDescriptors = sortDescriptors
        let predicatesC2 = NSPredicate(format: "timeStampData > %@  AND (categoryItemID == 1000 \(predTextNcatTemp) )", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )//
        itemsC2.nsPredicate = predicatesC2
        totalAmount5 = itemsC2.reduce(0) { $0 + $1.summData }
        TextSummCatAllandCatOnly = "по всеМ категориям:"
        return
        
    }
    */
    
    // таймер для периода
    //MARK: требует проверки и доделки таймера!
    func DayTimer (_ period:String) {
        
        let date = Date()
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
       

        // Сегодня
        if period == periodRaschetM[0] {
            let timer = hour * 3600 + minute * 60
            //    periodRaschet = Double(-(hour * 3600 + minutes * 60))
            return  periodRaschet = Int(Double(-(timer)))
        }
        
        // неделя
    /*    else if period == periodRaschetM[1] {
            let timer = (6 * 24)  * 3600  + hour * 3600 + minute * 60
            return  periodRaschet = Int(Double(-(timer)))
        }
        
        // 2 недели
        else if period == periodRaschetM[2] {
            let timer = (7 * 24) * 3600 + ((6 * 24) * 3600) +  hour * 3600 + minute * 60
            return  periodRaschet = Int(Double(-(timer)))
        }
        
        //1 месяц
        else if period == periodRaschetM[3] {
            let timer = (29 * 24)  * 3600 +  hour * 3600 + minute * 60
            return   periodRaschet = Int(Double(-(timer)))
        }
        
        //1 год
        else if period == periodRaschetM[4] {
            let timer = (364 * 24)  * 3600 +  hour * 3600 + minute * 60
            return   periodRaschet = Int(Double(-(timer)))
        }
       */
        //С начала недели (необходимо проверить на другом регионе)
        else if period == periodRaschetM[1] {
            let timer = (weekday-1) * (24 * 3600) - 86400 +  (hour * 3600 + minute * 60)
            return   periodRaschet = Int(Double(-(timer)))
          
        }
        // С начала месяца
        else if period == periodRaschetM[2] {
            let timer = ((day - 1) * 24  * 3600) +  (hour * 3600 + minute * 60 )
            return   periodRaschet = Int(Double(-(timer)))
        }
        
        // С Начала года
        else if period == periodRaschetM[3] {
            let timer = weekOfYear + ((day - 1) * 24  * 3600) +  (hour * 3600 + minute * 60 )
            return  periodRaschet = Int(Double(-(timer)))
        }
        
        // За весь период
        else if period == periodRaschetM[4] {
            let timer = 100000000000
            return  periodRaschet = Int(Double(-(timer)))
        }
        
    }
    
    
    // MARK: Попробовать сделать через отсюда!
    func totalAmaunt4Raschet () {
        
        /*		for category in category {
         print(category.categoryID)
         
         
         let catRashSumm = category.catRashSumm
         let nCat = category.categoryID
         categoryAll = true //?
         
         
         if catRashSumm == true {
         predTextNcatTemp.append(" OR categoryItemID == \(nCat) ")
         //	print (nCat)
         
         }
         
         //\(predTextNcatTemp)
         
         print (predTextNcatTemp)
         let sortDescriptors = [NSSortDescriptor(keyPath: \Item.timeStampData , ascending: false)]
         items.nsSortDescriptors = sortDescriptors
         let predicatesC2 = NSPredicate(format: "timeStampData > %@  AND (categoryItemID == 1000 \(predTextNcatTemp) )", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )//
         
         // let predicatesC2 = NSPredicate(format: "timeStampData > %@ OR  categoryItemID == 0 OR categoryItemID == 1 OR categoryItemID == 2 ", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )//
         
         //	let predicatesC2 = NSPredicate(format: "categoryItemID == 0 OR categoryItemID == 1 ")
         itemsC2.nsPredicate = predicatesC2
         
         /*
          let predicatesC2 = NSPredicate(format: "timeStampData > %@ \(predTextNcatTemp) ", Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )//
          itemsC2.nsPredicate = predicatesC2
          */		//print (totalAmount4)
         //	print (totalAmount4)
         //totalAmount5 = totalAmount4
         totalAmount5 = itemsC2.reduce(0) { $0 + $1.summData }
         //let tre = itemsC2.reduce(0) { $0 + $1.summData }
         //print (tre)
         TextSummCatAllandCatOnly = "по всем категориям:"
         
         
         
         
         
         
         }
         */
    }
    
    
    // расчет суммы каждой категории в списке категорий
    func raschetSummCategList(_ nCat: Int16, _ catRashSumm: Bool) -> Int32 {
        
        let predicateSummCategList = NSPredicate(format: "categoryItemID = \(nCat) AND timeStampData > %@",  Date().addingTimeInterval(TimeInterval(periodRaschet)) as NSDate )
        ItemSummCategListPredicate.nsPredicate = predicateSummCategList
        
        let summCategList: Int32 = ItemSummCategListPredicate.reduce(0) { $0 + $1.summData}
        
        return summCategList
    }
    
    
    
    //MARK: ТРЕБУЕТ ПРАВКИ В ЗАВИСИМОСТИ ОТ ПЕРИОДА! ??
    // подсветка суммы категории в списке цветом, в зависимости от порога трат
    func colorAmontF(_ summCategList:Int32, _ amountSpendingPerWeek:Int32, _ amountSpendingPerMonth:Int32 ) -> Color{
        
        var colorsP = Color.gray
        if summCategList == 0 || amountSpendingPerWeek == 0 || amountSpendingPerMonth == 0 {
            colorsP = Color.gray
        }
        
        if periodRaschetText == periodRaschetM[1] {
            if summCategList < amountSpendingPerWeek  {
                colorsP = Color.green
            }
            else if summCategList > amountSpendingPerWeek {
                colorsP = Color.red
            }
        }
        
        if periodRaschetText == periodRaschetM[3] {
            if summCategList < amountSpendingPerMonth  {
                colorsP = Color.green
            }
            else if summCategList > amountSpendingPerMonth {
                colorsP = Color.red
            }
        }
        return colorsP
    }
    
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
        totalAmount5 = totalAmount2
        // colorCategoryAmount = colorAmount2
    }
    
    
    func writeNoteItems(_ fText:String){
        
        do {
            try viewContext.save()
            //   try viewContext.save()
        } catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}



/*
struct test01 {
    
    //	@ObservedObject var category2: category2
    
    func test2() {
        //	print (category2)
    }
    //	for category2 in category
}
*/


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        //  .environment(\.managedObjectContext, periodRaschet)
        
    }
}



/*
 //  @ObservedObject var item: Item
 //  @Environment(\.managedObjectContext) var periodRaschet
 //  @AppStorage("periodRaschet") var periodRaschet: Double = -10.0
 
 
 @FetchRequest(
 sortDescriptors: [NSSortDescriptor(keyPath: \Item.summData , ascending: true)],
 predicate: NSPredicate(format: "categoryItemID >=0" ),
 animation: .default)
 private var itemsCategoryID: FetchedResults<Item>
 
 @FetchRequest(
 // sortDescriptors: [])
 //sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
 sortDescriptors: [sort1, sort2],
 predicate: NSPredicate(format: "catRashSumm != false"),
 animation: .default)
 var category2: FetchedResults<Category>
 
 */
//    private var currentDate = Date() // требует проверки
// @State    private    var SummCategRasch: [Int16:Int32] = [0:0]

//    @State  private var showView = false
//    @State  private var dataStrCat = ""
//    @State  private var refreshPage = false
//    @State    private var username: String = ""
//    @State private  var predicateReka = NSPredicate()
//  @Binding var periodRaschet: Double
//  @Binding var periodRaschet: Double
//  @AppStorage("Preference") var periodRaschet: Double = -36288000
//  @ObservedObject var category: Category
//    @Binding var periodRaschet: Double
//    @State    var colorAmontVar = Color.gray
//  var items: FetchedResults<Item, Category>
//  let query = "продукты"
//  let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
//  let predicate = NSPredicate(format: "mCatsData = %@", "продукты")
//  fetchRequest.predicate = predicate
//  @State  var tempText: String = ""
//  @Binding    var tempText: String
//    var categoryAllSumm: Int = 0
//    var allSumm: [Int] = []


// MARK: подсчет трат
// подсчет всех трат
//   var totalAmount: Int32 {
//   return items.reduce(0) { $0 + $1.summData }
//         }

// MARK: разбираться
//   var yyyy: [Int16] = []

/*    struct rrrrr {
 @Binding var tempText: String
 init(tempText: Binding<String>){
 self._tempText = tempText}
 //    .onChange(of: tempText, perform: { _ in
 //    if self.context.hasChanges {
 //    try? self.context.save()
 //    }
 }
 */


// отключаю временно для проверки
/*
 private   var  summCateg: Int32 {
 //    let predicatesttt = NSPredicate(format: "catRashSumm != false" )
 //   category.nsPredicate = predicatesttt
 //   items.reduce(0) { $0 + $1.summData }
 return itemsCategoryID.reduce(0) { $0 + $1.summData }
 }
 */
