//
//  SettingView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/23/23.
//

import SwiftUI
import CoreData
import UserNotifications

var valutaSymbolLable: Label = Label("", systemImage: valutaSymbol)

// let periodRaschetM = ["Сегодня", "1 неделя", "2 недели", "1 месяц", "1 год", "С начала недели", "С начала месяца", "С начала года", "За весь период" ]

let periodRaschetM = ["Сегодня", "С начала недели", "С начала месяца", "С начала года", "За весь период" ]
// "1 неделя", "2 недели", "1 месяц", "1 год",

struct SettingView: View {
    // разобраться – см блокнот
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.refresh)  var refresh
    
    // @State  var  periodRaschet: Int = 0
    
    
    @AppStorage("starterCategory") var starterCategory: Bool = false
    @AppStorage("periodRaschetText") var periodRaschetText: String = "Сегодня"
    @AppStorage("periodRaschet") var periodRaschet: Int = 0
    @AppStorage("detourTrigger") var detourTrigger: Bool = true  // подсказка при входе
    @AppStorage("notificationMessageTrigger") var notificationMessageTrigger: Bool = false // уведомления
    
    @AppStorage("SummAllCategory") var summAllCategory: String = "0" // предел трат для всех категорий
    
    // предел трат для всех категорий
    @AppStorage("SummAllCategoryTrigger") var summAllCategoryTrigger: Bool = false
    
    @AppStorage("summAllCategoryTriggerDay") var summAllCategoryTriggerDay: Bool = false
    @AppStorage("summAllCategoryTriggerWeek") var summAllCategoryTriggerWeek: Bool = false
    @AppStorage("summAllCategoryTriggerMotch") var summAllCategoryTriggerMotch: Bool = false
    
    @AppStorage("summAllCategoryDay") var summAllCategoryDay: String = "0"
    @AppStorage("summAllCategoryWeek") var summAllCategoryWeek: String = "0"
    @AppStorage("summAllCategoryMoutch") var summAllCategoryMoutch: String = "0"
    
    
    
    @AppStorage("IncomeTrue") var incomeTrue: Bool = false  //  разрешить вести учет доходов
                                                            // @AppStorage("periodRaschet") var periodRaschet: Double = -30.0
                                                            //  @State var periodRaschet: Double = -30.0
    
    @State var dataTemp: String = ""
    
    // подтягивание данных из файла
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
        predicate: NSPredicate(format: "categoryID >= 0"),
        animation: .default)
    var category4: FetchedResults<Category>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.summData , ascending: true)],
        predicate: NSPredicate(format: "categoryItemID >= 0" ),
        //  predicate: NSPredicate(format: "categoryItemID == 1" ),
        animation: .default)
    var items: FetchedResults<Item>
    
    @State   var includedTotalExpenses: Bool = false
    
    //init
    //	var trebo: Bool {
    //	return includedTotalExpenses ? true : false
    //	}
    
    //@State var includedTotalExpenses: Bool = true
    
    //   var predicateReka = NSPredicate()
    //@State var showCheckSumm: Bool = true
    
    //   var tempCat = Set<Int>()
    //   var initCategory: Bool?
    //    @State    var bbb: Bool = true
    //    @State var showCheckSumm: Bool = true
    //  var stIntCategory: Bool = false
    // записывает начальные категории при запуске
    
    
    // MARK: Добавлено для переноса
    
    @State var ColorToggleRedGray = Color.gray
    
    @State  var categoryDeleteToggle: Bool = false  // MARK: разбираться что - то связано с ??
    
    //var buttonConfirmacion = "Подтвердить изменения для категории"
    //		buttonConfirmacion = "Удалить категорию"
    
    // false - 7 дней назад / c первого дня недели
    @State var weekSevenDayBackORStartWeekTrigger: Bool = true
    
    // false - 30 дней назад / c первого дня месяуа
    @State var monthThirtyDaysBackORStartMounthTrigger: Bool = true
    var buttonConfirmacion: String {
        return categoryDeleteToggle ?  "Удалить категорию" : "Подтвердить изменения для "
    }
    
    
    
    @FocusState private var nameIsFocused: Bool // для скрытия и показа всплывающей клавиатуры
                                                ///	@State var dataTemp: String = ""
                                                //@State var dataTemp: String = ""
    
    //	@State var IncomeTrue: Bool = false
    /*
     struct BindigStructCateg {
     @Binding var dataTemp: String
     init(tempText: Binding<String>){
     self._dataTemp = dataTemp}
     //           .onChange(of: tempText, perform: { _ in
     //               if self.context.hasChanges {
     //                   try? self.context.save()
     //               }
     }
     */
    @State private var categPriority = 5.0
    @State private var isEditing = false
    
    @State  var amountSpendingPerWeekAsString: String = ""
    @State var amountSpendingPerMonthAsString: String = ""
    @State var amountSpendingPerPeriodAsString: String = ""
    
    @FocusState var pendingPerWeek : Bool
    @FocusState var pendingPerMonth : Bool
    //  @FocusState var pendingPerPeriod : Bool  //  для всех категорий за выбранный период
    @FocusState var pendingPerAllCalDay : Bool
    @FocusState var pendingPerAllCalWeek : Bool
    @FocusState var pendingPerAllCalMontch : Bool
    
    
    // получение кол-ва записей
    var count:  Int  {
        return category.count
    }
    
    // все активные категории (используется при удалении и добавлении новой категории)
    @State var catMaxArr: [Int] = []
    //let trtr: Int = Category.value(forKey: "categoryID") as! Int
    
    
    
    @State var hidenNotificationText: Double = 0.0 // скрывает и показывает текс о выключенных уведомлениях
                                                   //   @State var notificationMessageTrigger = true  // уведомления
    
    
    
    var body: some View {
        
        
        
        
        
        VStack {
            
            HStack {
                
                Text("Настройки")
                //.padding(.leading, 5.0)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text ("•")
                    .foregroundColor(Color.red)
                //	Text ("[!]")
                //	.foregroundColor(Color.red)
                Label("", systemImage: "arrow.down.to.line")
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
                
                //MARK: Показ справки – пока отключено
                /*					Button {
                 //сделать всплывающее меню
                 } label: {
                 Text(Image(systemName: "questionmark.circle"))
                 .font(.title)
                 .padding(.bottom, 5.0)
                 .fontWeight(.thin)
                 //	.padding(.leading, 8.0)
                 .frame(width: 50.0,  alignment: .trailing)
                 
                 }
                 */
                
            }
            
            .frame(width: 350.0, height: 30.0, alignment: .leading)
            
            Divider()
            NavigationView {
                VStack {
                    List {
                        
                        Text("РЕДАКТИРОВАТЬ КАТЕГОРИИ РАСХОДОВ")
                            .foregroundColor(.green)
                        //   .font(.headline)
                        // для OC 16                      .fontWeight(.light)
                        //  .multilineTextAlignment(.leading)
                        //  .position(x:155,y:20)
                        //  ForEach(category, id:\.self) { categoryIndex in
                        
                        ForEach(category) {category in
                            
                            // не выводим 0 категорию (добавить новую категорию)
                            let categoryID = category.categoryItemID   //category.categoryID
                            if category.categoryID >= 1 {
                                NavigationLink () {
                                    
                                    //     CategoryEditView()
                                    // рабочий блок
                                    ScrollView {
                                        VStack(){
                                            VStack(alignment: .leading){
                                                Text("КАТЕГОРИЯ")
                                                
                                                    .font(.subheadline)
                                                //    .foregroundColor(Color.green)
                                                    .fontWeight(.bold)
                                                //.frame(width: 350.0, alignment: .leading)
                                                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxLarge/*@END_MENU_TOKEN@*/)
                                                
                                                Text("\(category.catShop!)")
                                                    .foregroundColor(myColor.ColorPesok)
                                                    .dynamicTypeSize(.xLarge)
                                                
                                                
                                                /*   Text("(что бы изменения вступили в силу, подтвердите  )")
                                                 .fontWeight(.regular)
                                                 .foregroundColor(Color.gray)
                                                 .dynamicTypeSize(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                                 */
                                            }
                                            .frame(width: 350.0, alignment: .leading)
                                            .padding(.top, 30.0)
                                            
                                            
                                            Divider()
                                                .padding(.vertical, 5.0)
                                            
                                            Text("Изменить название категории")
                                                .multilineTextAlignment(.leading)
                                                .frame(width: 350.0, alignment: .leading)
                                                .task {
                                                    nameIsFocused = false
                                                }
                                            
                                            Text("(введите новое название в поле ниже, и выберите подтвердить изменения для ... )")
                                                .fontWeight(.regular)
                                                .foregroundColor(Color.gray)
                                                .multilineTextAlignment(.leading)
                                                .dynamicTypeSize(.medium)
                                                .frame(width: 350.0, alignment: .leading)
                                            
                                            
                                            TextField("\(category.catShop!)", text: $dataTemp )
                                                .padding(.leading, 15.0)
                                                .foregroundColor(myColor.GBlue)
                                                .frame(width: 350.0, height: 40.0, alignment: .leading)
                                                .background(Color("downgray"))
                                                .cornerRadius(6.0)
                                                .onChange(of: dataTemp) { newValue in
                                                    category.catShop = dataTemp
                                                    try? viewContext.save()
                                                }
                                            
                                            VStack(alignment: .leading){
                                                //$includedTotalExpenses
                                                Toggle(isOn: $includedTotalExpenses   ) {  //Toggle(isOn: self.$category.catRashSumm ) {
                                                    Text("Учитывать в общих расходах")
                                                    
                                                        .onAppear(perform: {
                                                            //        cat(category.catRashSumm)
                                                        })
                                                    //{
                                                    // includedTotalExpenses = cate true// {
                                                    //try? viewContext.save()
                                                    
                                                    //    }
                                                    
                                                    //}
                                                    
                                                }
                                                
                                                .padding(.vertical, 15.0)
                                                .frame(width: 350.0, alignment: .leading)
                                                //                .task { includedTotalExpenses ? (category.catRashSumm = false) : (category.catRashSumm = true)
                                                //                    try? viewContext.save()
                                                //                }
                                                
                                                Text("Приоритет показа категории")
                                                    .task {
                                                        categPriority = category.categoryPriority
                                                    }
                                                Text("(0 – самый низкий, 10 – самый высокий)")
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color.gray)
                                                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                                
                                                Slider(
                                                    value: $categPriority,
                                                    in: 0...10,
                                                    step: 0.5
                                                )
                                                {
                                                    //Text("Speed")
                                                } minimumValueLabel: {
                                                    Text("0")
                                                        .foregroundColor(Color.red)
                                                    
                                                } maximumValueLabel: {
                                                    //    Text("100")
                                                    
                                                    Text("\(Int(categPriority))")
                                                        .foregroundColor(Color.green)
                                                    
                                                    
                                                } onEditingChanged: { editing in
                                                    isEditing = editing
                                                }
                                                
                                                //    Text("\(speed)")
                                                //    .foregroundColor(isEditing ? .red : .blue)
                                            }
                                            .padding(.top, 5.0)
                                            .frame(width: 350.0,  alignment: .leading)
                                            
                                            //    Text("объединить с категорией")
                                            //    .frame(width: 320.0, height: 20.0, alignment: .leading)
                                            //    .task {
                                            //    }
                                            /*    Toggle(isOn: self.$category.catRashSumm ) {
                                             Text("Учитывать в общих расходах")
                                             .task {
                                             //saveCateg()
                                             }
                                             }
                                             .frame(width: 320.0, alignment: .leading)
                                             .padding(.vertical, 10.0)
                                             */
                                            
                                            Divider()
                                                .padding(.vertical, 15.0)
                                            
                                            Text ("""
                                            ПРЕВЫШЕНИЕ ТРАТ
                                            для категории \(category.catShop!)
                                            """)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(3)
                                            .padding(.bottom, 2.0)
                                            .frame(width: 345.0, alignment: .leading)
                                            .task {
                                                amountSpendingPerWeekAsString = String(category.amountSpendingPerWeek)
                                                amountSpendingPerMonthAsString = String(category.amountSpendingPerMonth)
                                            }
                                            VStack(alignment: .leading){
                                                //GroupBox{
                                                
                                                /*    Text("(введите сумму, при превшении этой суммы, цвет изменится на красный)")
                                                 .fontWeight(.regular)
                                                 .foregroundColor(Color.gray)
                                                 .dynamicTypeSize(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                                 .padding(.bottom, 4.0)
                                                 */
                                                
                                                GroupBox{
                                                    VStack(alignment: .leading){
                                                        //   Text ("Предел трат в неделю")
                                                        Toggle(isOn: $weekSevenDayBackORStartWeekTrigger) {
                                                            Text("Предел трат в неделю")
                                                                .font(.subheadline)
                                                            //   .onChange(of: weekSevenDayBackORStartWeekTrigger, perform: {
                                                            //       {category.weekSevenDayBack = weekSevenDayBackORStartWeekTrigger}
                                                            //   })
                                                        }
                                                        .padding(.top, 10.0)
                                                        .onAppear(perform: {
                                                            weekSevenDayBackORStartWeekTrigger = category.weekSevenDayBack
                                                        })
                                                        
                                                        HStack{
                                                            TextField("\(category.amountSpendingPerWeek)", text: $amountSpendingPerWeekAsString)
                                                                .foregroundColor(myColor.GBlue)
                                                                .keyboardType(.numberPad)
                                                                .padding(.leading, 5.0)
                                                                .focused($pendingPerWeek)
                                                                .frame(height: 35.0)
                                                                .background(myColor.GSilver)
                                                                .cornerRadius(4.5)
                                                                .onChange(of: amountSpendingPerWeekAsString) { _ in
                                                                    let checked = amountSpendingPerWeekAsString.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
                                                                    amountSpendingPerWeekAsString = checked
                                                                    
                                                                    if amountSpendingPerWeekAsString == "0" {
                                                                        amountSpendingPerWeekAsString = ""
                                                                    }
                                                                    
                                                                    category.amountSpendingPerWeek = Int32(amountSpendingPerWeekAsString) ?? 0
                                                                        
                                                                        saveData()
                                                                    
                                                                /*    if amountSpendingPerWeekAsString != "" {
                                                                        // amountSpendingPerWeekAsString = "0"
                                                                        
                                                                        category.amountSpendingPerWeek = Int32(amountSpendingPerWeekAsString) ?? 0
                                                                        
                                                                        saveData()
                                                                        
                                                                    }
                                                                    else {
                                                                        amountSpendingPerWeekAsString = "0"
                                                                        category.amountSpendingPerWeek = Int32(amountSpendingPerWeekAsString)!
                                                                        saveData()
                                                                        
                                                                    }
                                                                   */
                                                                }
                                                         
                                                            /*     .onChange(of: weekSevenDayBackORStartWeekTrigger) { newValue in
                                                             (category.weekSevenDayBack = weekSevenDayBackORStartWeekTrigger)
                                                             try? viewContext.save()
                                                             }
                                                             */
                                                            
                                                            Spacer()
                                                            Button("Ok") {
                                                                if pendingPerWeek {
                                                                    pendingPerWeek = false
                                                                }
                                                            }
                                                            .frame(width: 50.0, height: 35.0)
                                                            .accentColor(.white)
                                                            .background(.gray)
                                                            .cornerRadius(16.0)
                                                        }
                                                        .opacity(weekSevenDayBackORStartWeekTrigger ? 1.0 : 0.15)
                                                    }
                                                    .onChange(of: weekSevenDayBackORStartWeekTrigger) { newValue in
                                                        category.weekSevenDayBack = weekSevenDayBackORStartWeekTrigger
                                                    }
                                                }
                                                
                                                GroupBox {
                                                    VStack(alignment: .leading){
                                                        //   Text ("Предел трат в месяц")
                                                        Toggle(isOn: $monthThirtyDaysBackORStartMounthTrigger) {
                                                            Text("Предел трат в месяц")
                                                                .font(.subheadline)
                                                                .padding(.leading, 5.0)
                                                                .onAppear(perform: {
                                                                    monthThirtyDaysBackORStartMounthTrigger = category.monthThirtyDaysBack
                                                                })
                                                            
                                                            /*   .onChange(of: monthThirtyDaysBackORStartMounthTrigger) { newValue in
                                                             category.monthThirtyDaysBack = monthThirtyDaysBackORStartMounthTrigger
                                                             try? viewContext.save()
                                                             }
                                                             */
                                                        }
                                                        .padding(.top, 10.0)
                                                        HStack{
                                                            TextField("\(category.amountSpendingPerMonth)", text: $amountSpendingPerMonthAsString)
                                                                .foregroundColor(myColor.GBlue)
                                                                .keyboardType(.numberPad)
                                                                .focused($pendingPerMonth)
                                                                .frame(height: 35.0)
                                                                .background(myColor.GSilver)
                                                                .cornerRadius(4.5)
                                                                .onChange(of: amountSpendingPerMonthAsString) { _ in
                                                                    let checked = amountSpendingPerMonthAsString.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
                                                                    amountSpendingPerMonthAsString = checked
                                                                    
                                                                    if amountSpendingPerMonthAsString == "0" {
                                                                    amountSpendingPerMonthAsString = ""
                                                                    }
                                                                    
                                                                    category.amountSpendingPerMonth = Int32(amountSpendingPerMonthAsString) ?? 0
                                                                    
                                                                    saveData()
                                                                }
                                                            
                                                            Spacer()
                                                            
                                                            Button("Ok") {
                                                               // if amountSpendingPerMonthAsString == "" {
                                                               //     amountSpendingPerMonthAsString = "0"
                                                              //  }
                                                                if pendingPerMonth {
                                                                    pendingPerMonth = false
                                                                }
                                                            }
                                                            .frame(width: 50.0, height: 35.0)
                                                            .accentColor(.white)
                                                            .background(.gray)
                                                            .cornerRadius(16.0)
                                                        }
                                                        .opacity(monthThirtyDaysBackORStartMounthTrigger ? 1.0 : 0.15)
                                                    }
                                                    .onChange(of: monthThirtyDaysBackORStartMounthTrigger) { V in
                                                        category.monthThirtyDaysBack = monthThirtyDaysBackORStartMounthTrigger
                                                    }
                                                    //   .frame(width: 320.0, alignment: .leading)
                                                }
                                            }
                                            //  }
                                            // .padding(.leading, -10.0)
                                            .frame(width: 350.0)
                                            .onTapGesture() {
                                                nameIsFocused = false
                                            }
                                            
                                            VStack{
                                                
                                                Divider()
                                                    .padding(.vertical, 5.0)
                                                
                                                Toggle(isOn: $categoryDeleteToggle ) {
                                                    
                                                    VStack(alignment: .leading){
                                                        Text("Удалить категорию")
                                                            .foregroundColor(Color.red)
                                                        //   .foregroundColor(categoryDeleteToggle ?   .red : .gray)
                                                        Text("\(category.catShop!)")
                                                            .foregroundColor(myColor.ColorBoloto)
                                                    }
                                                    .padding(.trailing)
                                                }
                                                .padding(.trailing, 10.0)
                                                .frame(width: 340.0)
                                                .tint(.red)
                                                
                                                Text ("Удаление категории приведет к удалению связанных с ней данных. Вы можете переименовать категорию.")
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                
                                                    .foregroundColor(.gray)
                                                    .lineLimit(4)
                                                    .frame(width: 345, height: 75.0, alignment: .leading)
                                                    .padding(.bottom, 10.0)
                                                    .padding(.leading, 5.0)
                                                
                                                //	MARK: перенести в функцию
                                                Button(buttonConfirmacion + " \r " + "\(category.catShop!)") {
                                                    nameIsFocused = false
                                                    if dataTemp == "" {
                                                        dataTemp = category.catShop!
                                                    }
                                                    
                                                    //    category.catShop = dataTemp
                                                    //     category.catRashSumm = includedTotalExpenses
                                                    //    category.categoryPriority = categPriority
                                                    //     category.amountSpendingPerWeek =  Int32(amountSpendingPerWeekAsString)!
                                                    //     category.amountSpendingPerMonth = Int32(amountSpendingPerMonthAsString)!
                                                    
                                                    try? viewContext.save()
                                                    dataTemp = ""
                                                    
                                                    if categoryDeleteToggle == true {
                                                        categoryDelete(categoryID)
                                                    }
                                                    dismiss()
                                                    //										saveCateg ()
                                                    //	deleteItems3(offsets: indexSet)
                                                }
                                                //.foregroundColor(categoryDeleteToggle ?   .red : .gray)
                                                .frame(width: 350.0, height: 60.0)
                                                .accentColor(.white)
                                                .background(categoryDeleteToggle ?   .red : .green)
                                                .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                                                .padding(.bottom, 40.0)
                                                .opacity(categoryDeleteToggle ? 1.0 : 0.0)
                                                
                                            }
                                            .frame(width: 350.0, alignment: .leading)
                                            //.scrollContentBackground(.hidden) // для OC 16
                                        }
                                        //	.padding(.leading, 45.0)
                                        .frame(width: 380.0, alignment: .leading)
                                        .padding(.top, 5.0)
                                        .onAppear(){
                                            includedTotalExpenses = category.catRashSumm
                                        }
                                        .onDisappear() {
                                            category.catRashSumm = includedTotalExpenses
                                            category.categoryPriority = categPriority
                                            try? viewContext.save()
                                        }
                                        //	 .scrollContentBackground(.hidden) // для OC 16
                                    }
                                    
                                }
                                
                            label: {
                                //	TextField("\(category.catShop!)", text: $dataTemp)
                                Text("\(category.catShop!) ") //category.categoryItemID
                                    .foregroundColor(category.catRashSumm ?   myColor.GBlue : .gray)
                                
                            }
                                // .task(){CategoryMaxArr(category.categoryID)}
                            .contextMenu {
                                
                                Button(action: {
                                    //	deleteItems2(offsets: IndexSet)	// delete the selected restaurant
                                }) {
                                    HStack {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }}
                                
                            }  // для if
                            
                        }
                        //	.onDelete(perform: deleteItems2)
                        
                        Text("ДОБАВИТЬ НОВУЮ КАТЕГОРИЮ")
                        //	.padding(.top, 30)
                            .font(.caption)
                        // для OC 16                    .fontWeight(.light)
                            .foregroundColor(myColor.ColorPesok) //Color.purple
                            .multilineTextAlignment(.leading)
                            .onTapGesture(perform: addItemDefTemp)
                        
                            .task {
                                catMaxArr = []
                            }
                        
                        Text("ПЕРИОД ПОДСЧЕТА РАСХОДОВ")
                            .padding(.top, 30)
                        // для OC 16                    .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.green)
                        
                        ForEach (periodRaschetM, id: \.self) {period in
                            Button(period) {
                                periodRaschetText = period
                                ContentView().DayTimer(periodRaschetText)
                            }
                            .foregroundColor(periodRaschetText != period ? .gray : myColor.GBlue)
                            
                        }
                        
                        
                        
                        //
                        // MARK: предел трат за выбранный период
                        VStack(alignment: .leading){
                            Text("""
                                     ПРЕДЕЛ ТРАТ
                                     ДЛЯ ВСЕХ КАТЕГОРИЙ
                                     """)
                            .lineLimit(2)
                            .padding(.top, 15)
                            // для OC 16                        .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.green)
                            .frame(height: 80.0)
                            .padding(/*@START_MENU_TOKEN@*/.leading, 5.0/*@END_MENU_TOKEN@*/)
                            
                            GroupBox() {
                                Toggle(isOn: $summAllCategoryTriggerDay) {
                                    Text("За 1 день (Д)")
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    TextField("\(summAllCategoryDay)", text: $summAllCategoryDay)
                                        .foregroundColor(myColor.GBlue)
                                        .padding(.leading, 5.0)
                                        .frame(width: 270.0, height: 35.0)
                                        .keyboardType(.numberPad)
                                        .focused($pendingPerAllCalDay)
                                        .background(myColor.GSilver)
                                        .cornerRadius(4.5)
                                        .onChange(of: summAllCategoryDay) { _ in
                                            let checked = summAllCategoryDay.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
                                            summAllCategoryDay = checked
                                            
                                            if summAllCategoryDay == "0" {
                                            summAllCategoryDay = ""
                                        }
                                            
                                        }
                                    Spacer()
                                    
                                    Button("Ok") {
                                        
                                        if pendingPerAllCalDay {
                                            pendingPerAllCalDay = false
                                        }
                                    }
                                    .frame(width: 50.0, height: 35.0)
                                    .accentColor(.white)
                                    .background(.gray)
                                    .cornerRadius(16.0)
                                    
                                }
                                // .padding(.vertical, 50.0)
                                .frame(height: 60.0)
                                .opacity(summAllCategoryTriggerDay ? 1.0 : 0.15)
                                //+ valutaSymbolLable
                                /*                                  Text("Предел трат установлен "  +  " за период: " + periodRaschetText)
                                 .font(.caption)
                                 .foregroundColor(myColor.GBlue)
                                 .multilineTextAlignment(.leading)
                                 */
                                
                                //   }
                            }
                            
                            GroupBox() {
                                Toggle(isOn: $summAllCategoryTriggerWeek) {
                                    Text("За 1 неделю (Н)")
                                        .foregroundColor(.gray)
                                    
                                }
                                //  if summAllCategoryTriggerWeek == true {
                                HStack{
                                    TextField("\(summAllCategoryWeek)", text: $summAllCategoryWeek)
                                        .foregroundColor(myColor.GBlue)
                                        .frame(width: 270.0, height: 35.0)
                                        .padding(.leading, 5.0)
                                        .keyboardType(.numberPad)
                                        .focused($pendingPerAllCalWeek)
                                        .background(myColor.GSilver)
                                        .cornerRadius(4.5)
                                        .onChange(of: summAllCategoryWeek) { _ in
                                            let checked = summAllCategoryWeek.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
                                            summAllCategoryWeek = checked
                                            
                                            if summAllCategoryWeek == "0" {
                                            summAllCategoryWeek = ""
                                        }
                                        }
                                    Spacer()
                                    Button("Ok") {
                                      //  if summAllCategoryWeek == "" {
                                       //     summAllCategoryWeek = "0"
                                      //  }
                                        if pendingPerAllCalWeek {
                                            pendingPerAllCalWeek = false
                                        }
                                    }
                                    .frame(width: 50.0, height: 35.0)
                                    .accentColor(.white)
                                    .background(.gray)
                                    .cornerRadius(16.0)
                                }
                                // .padding(.vertical, 50.0)
                                .frame(height: 60.0)
                                .opacity(summAllCategoryTriggerWeek ? 1.0 : 0.15)
                            }
                            //    }
                            
                            GroupBox() {
                                Toggle(isOn: $summAllCategoryTriggerMotch) {
                                    Text("За 1 месяц (М)")
                                        .foregroundColor(.gray)
                                }
                                //    if summAllCategoryTriggerMotch == true {
                                HStack{
                                    
                                    TextField("\(summAllCategoryMoutch)", text: $summAllCategoryMoutch)
                                        .frame(width: 270.0, height: 35.0)
                                        .foregroundColor(myColor.GBlue)
                                        .padding(.leading, 5.0)
                                        .keyboardType(.numberPad)
                                        .focused($pendingPerAllCalMontch)
                                        .background(myColor.GSilver)
                                        .cornerRadius(4.5)
                                        .onChange(of: summAllCategoryMoutch) { _ in
                                            let checked = summAllCategoryMoutch.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
                                            summAllCategoryMoutch = checked
                                            
                                            if summAllCategoryMoutch == "0" {
                                            summAllCategoryMoutch = ""
                                        }
                                            
                                            
                                            
                                        }
                                    Spacer()
                                    Button("Ok") {
                                    //    if summAllCategoryMoutch == "" {
                                     //       summAllCategoryMoutch = "0"
                                     //   }
                                        
                                        if pendingPerAllCalMontch {
                                            pendingPerAllCalMontch = false
                                        }
                                    }
                                    .frame(width: 50.0, height: 35.0)
                                    .accentColor(.white)
                                    .background(.gray)
                                    .cornerRadius(16.0)
                                }
                                // .padding(.vertical, 50.0)
                                .frame(height: 60.0)
                                .opacity(summAllCategoryTriggerMotch ? 1.0 : 0.15)
                                //  }
                                
                            }
                        }
                        // .padding(.top, 15.0)
                        
                        // MARK: включатель уведомлений нужно сделать!
                        VStack{
                            Toggle(isOn: $notificationMessageTrigger) {
                                Text("ВКЛЮЧИТЬ УВЕДОМЛЕНИЯ")
                                    .foregroundColor(.green)
                                
                                //  .foregroundColor(Color.gray)
                                
                                //     if notificationMessageTrigger == true {
                                //        task{ addNotificationRequest()}
                                //       task{notificationMessage2()}
                                //     }
                                //   else {
                                //       task{ removeNotificationRequest()}
                                //     }
                            }
                            //.padding(.top, 5.0)
                            .onChange(of: notificationMessageTrigger) {newValue in
                                // addNotificationRequest()
                                notificationMessage()
                            }
                            Text("Уведомления выключены в настройках системы. Сначала разрешите приложению отправлять Вам уведомления. Для этого перейдите в общие настройки.")
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, -10.0)
                            //  .opacity(hidenNotificationText)
                        }
                        .padding(.top, 20.0)
                        
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                        // MARK: нужно сделать
                        Toggle(isOn: $detourTrigger) {
                            Text("Показать первый экран запуска")
                                .foregroundColor(Color.gray)
                        }
                        .padding(.top, 20.0)
                        
                        // вести учет доходов
                        /*	Toggle(isOn: $incomeTrue) {
                         Text("ВЕСТИ УЧЕТ ДОХОДОВ")
                         }
                         .padding(.top, 30)
                         .foregroundColor(.green)
                         
                         
                         // удалить все данные
                         Text("удалить все данные")
                         .padding(.top, 30)
                         // для OC 16                                 .fontWeight(.light)
                         .multilineTextAlignment(.leading)
                         .foregroundColor(.black)
                         */
                    }
                }
                
            }
            //	.padding(.top, 25.0)
            
            //	.refreshable (){
            //	addItemDefTemp()  // Разбираться отсюда!
            //	}
            .dynamicTypeSize(.xLarge)
            .padding(.bottom, 5.0)
            // для OC 16          .scrollContentBackground(.hidden)
            
        }
        .padding(.top, 25.0)
        .padding(.bottom, 20.0)
    }
    
    /*  вроде ни где не используется
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
     */
    
    func CategoryMaxArr(_ categoryID:Int16){
        catMaxArr.append(Int(categoryID))// [Int(categoryID)]
    }
    
    //                        .task(){CategoryMaxArr2()}
    
    func CategoryMaxArr2(){
        
    }
    
    // MARK: Нужно разбираться
    // расчет временного интервала в зависимости от установленного в настройках
    
    
    
    // MARK: глобально разбираться!
    func categoryDelete(_ categoryItemID: Int16) {
        
        // удаляем данные из items указанной категории
        let predicatesDelItemCat = NSPredicate(format: "categoryItemID = %i", categoryItemID )
        items.nsPredicate = predicatesDelItemCat
        for index in items {
            viewContext.delete(index)
        }
        
        // удаляем данные из category указанной категории
        
        // правильнее следать придать этой категории знак "-", она останется в списке, но не будет показываться
        let predicatesCat = NSPredicate(format: "categoryID = %i", categoryItemID )
        category.nsPredicate = predicatesCat
        // не получается удалять через индекс нужно удалять конкретное
        let categoryIndex = category[0] //[Int(categoryItemID)] //category[0]
                                        // viewContext.delete(categoryIndex)
        
        //  let сategory = Category(context: viewContext)
        
        //MARK: сделано через присвоение удаленной категории значения -1, в этом случае она не показывается в списке доступных категорий
        categoryIndex.categoryItemID = -1
        categoryIndex.categoryID = -1
        try?  viewContext.save()
        
        MainView().trigerAddItem = false
        categoryDeleteToggle = false
        
        let predicatesItem = NSPredicate(format: "categoryItemID >= 0" )
        items.nsPredicate = predicatesItem
        
        let predicatesCat2 = NSPredicate(format: "categoryID > 0" ) // ? было >=0
        category.nsPredicate = predicatesCat2
        
        
    }
    
    func removeCategory(offsets : IndexSet) -> Void  {
        //	for index in offsets {
        //	let categoryIndex2 = category[index]
        //	viewContext.delete(categoryIndex)
        //	try?  viewContext.save()
        //	}
    }
    
    //	expenses.items.remove(atOffsets: offsets)
    
    func deleteItems2(offsets: IndexSet) {
        withAnimation {
            offsets.map { category[$0] }.forEach(viewContext.delete)
            //	do {
            //	print ("офсет", offsets)
            //	viewContext.delete(category)
            //	viewContext.update()
            //	try? viewContext.save()
            
            //	let predicates = NSPredicate(format: "categoryItemID >= 0" )
            //	category.nsPredicate = predicates
            //  } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //	let nsError = error as NSError
            //	fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            //   }
        }
    }
    
    func cat(_ catRashSumm:Bool) {
        includedTotalExpenses = catRashSumm
    }
    func saveCateg () {
        //		if dataTemp == "" {
        //		dataTemp = category.catShop!
        //		}
        //		category.catShop = dataTemp
        //		category.catRashSumm = includedTotalExpenses
        try? viewContext.save()
        //	dataTemp = ""
    }
    
    // ДОБАВЛЕНИЕ НОВОЙ КАТЕГОРИИ
    func addItemDefTemp () {
        /*	// запись первой строки – инициализация для превью
         let newItem = Item(context: viewContext)
         newItem.timestampData = Date()
         newItem.noteSummData = "info"
         newItem.mCatsData = "пример"
         newItem.summData = 0
         */
        // инициализация начальных данных категорий для превью
        catMaxArr = []
        let mCatInit: [String] = ["Новая категория"]
        
        
        // MARK: попробовать переделать через поиск максимального значения в categoryItemID
        //нужно начинать не с 0 категории, а с 1! 0 резеврируем для удаления?, но пока остается с 0
        //	let cate = Category(context: viewContext)
        //  let categoryMaxValue = $category.categoryItemID.max( )
        
        
        
        //		let categoryCount: Int = (category.count )  // через подсчет кол-ва
        //нужно начинать не с 0 категории, а с 1! 0 резеврируем для удаления?, но пока остается с 0
        //	let mCatInd: Int16 = Int16(categoryCount) + 1
        
        let newCategory = Category(context: viewContext)
        // let newcategoryItemID = newCategory.categoryItemID
        for categ in category {
            catMaxArr.append(Int(categ.categoryID))
            //let newcategoryItemID = catMaxArr
            //  return
        }
        //  let categoryIDnew = catMaxArr.max()
        // print(catMaxArr)
        
        for mCats in mCatInit {
            newCategory.catShop = mCats
            newCategory.categoryID =  Int16(catMaxArr.max()! + 1)  // mCatInd
            newCategory.categoryItemID = Int16(catMaxArr.max()! + 1)  //mCatInd
            newCategory.catUUID = UUID()
            newCategory.catNote = ""
            newCategory.onRemove = false
            newCategory.catRashSumm = true
            newCategory.categoryPriority = 0.0
            
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
        //	starterCategory = true
    }
    
    /*
     func saveCateg () {
     if dataTemp == "" {
     dataTemp = category.catShop
     }
     category.catShop = dataTemp
     category.catRashSumm = category.catRashSumm
     
     try? viewContext.save()
     dataTemp = ""
     
     }
     */
    func saveData() {
        
        try? viewContext.save()
        
    }
    
    func addItemDef () {
        // запись первой строки – инициализация для превью
        let newItem = Item(context: viewContext)
        newItem.timeStampData = Date()
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
            newCategory.categoryPriority = 5.0
            
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
    
    
    // MARK: сами уведомления уведомлений
    /*    func notificationMessage () {
     
     let content = UNMutableNotificationContent()
     
     //      let content = UNMutableNotificationContent()
     //       content.title = "Restaurant Recommendation3"
     //       content.subtitle = "Try new food today3"
     //       content.body = "I recommend you to check out Cafe Deadend3."
     
     
     // Configure the recurring date.
     var dateComponents = DateComponents()
     dateComponents.calendar = Calendar.current
     
     //  dateComponents.weekday = 3  // Tuesday
     dateComponents.hour = 20    // 20:00 hours отправка уведомления в 20 часов
     
     // Create the trigger as a repeating event.
     //     let trigger = UNCalendarNotificationTrigger(
     //             dateMatching: dateComponents, repeats: true)
     
     let trigger = UNCalendarNotificationTrigger(
     dateMatching: dateComponents, repeats: true)
     print (trigger)
     // Create the request
     let uuidString = UUID().uuidString
     let request = UNNotificationRequest(identifier: uuidString,
     content: content, trigger: trigger)
     
     // Schedule the request with the system.
     //        let notificationCenter = UNUserNotificationCenter.current()
     //        notificationCenter.add(request) { (error) in
     //           if error != nil {
     //              // Handle any errors.
     //           }
     //       }
     
     
     let notificationCenter = UNUserNotificationCenter.current()
     notificationCenter.getNotificationSettings { settings in
     guard (settings.authorizationStatus == .authorized) ||
     (settings.authorizationStatus == .provisional) else { return }
     
     
     
     if settings.alertSetting == .enabled {
     // Schedule an alert-only notification.
     content.title = "Restaurant Recommendation2"
     content.subtitle = "Try new food today2"
     content.body = "I recommend you to check out Cafe Deadend2."
     
     } else {
     // Schedule a notification with a badge and sound.
     
     //       let content = UNMutableNotificationContent()
     content.title = "Restaurant Recommendation"
     content.subtitle = "Try new food today"
     content.body = "I recommend you to check out Cafe Deadend."
     
     }
     }
     
     }
     
     */
    
    
    // MARK: запрос на разрешение уведомлений
    // необходимо поставить в самое начало запуска!
    func addNotificationRequest2() {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) { granted, error in
            //    if let error = error {
            // Handle the error here.
            //    }
            
            if granted {
                print("User notifications are allowed.")
            } else {
                
                print("User notifications are not allowed.")
            }
            
            // Enable or disable features based on the authorization.
        }
        
        
        
    }
    
    
    func notificationMessage() {
        
        let center = UNUserNotificationCenter.current()
        
        if notificationMessageTrigger == true {
            
            center.requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) { granted, error in
                //    if let error = error {
                // Handle the error here.
                //    }
                
                if granted {
                    hidenNotificationText = 0.0
                    //  center.UNAuthorizationOptions(options: [.alert, .sound, .badge)
                    print("User notifications are allowed.")
                } else {
                    notificationMessageTrigger = false
                    hidenNotificationText = 1.0
                    print("User notifications are not allowed.")
                }
                
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Привет! это SilverMoney"
            content.body = "Не забудь внести расходы..."
            content.sound = UNNotificationSound.default
            
            // Configure the recurring date.
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            
            //  dateComponents.weekday = 3  // Tuesday
            dateComponents.hour = 20   // показ уведомления в 20:00 hours
                                       // dateComponents.minute = 35   //
                                       // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents, repeats: true)
            
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                                                content: content, trigger: trigger)
            
            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
                if error != nil {
                    // Handle any errors.
                }
            }
        }
        
        
        if notificationMessageTrigger == false {
            
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { settings in
                
                guard (settings.authorizationStatus != .authorized) ||
                        (settings.authorizationStatus != .provisional) else { return }
                
                if settings.alertSetting == .enabled {
                    // Schedule an alert-only notification.
                } else {
                    // center.providesAppNotificationSettings
                    
                    // Schedule a notification with a badge and sound.
                }
            }
            
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.removeAllPendingNotificationRequests()  //Удаляет все ожидающие локальные уведомления
            notificationCenter.removeAllDeliveredNotifications() //Удаляет все доставленные уведомления
        }
        
    }
    
}



struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        //  SettingView().environment(\.managedObjectContext,  PersistenceController.preview.container.viewContext)
        SettingView().environment(\.managedObjectContext,  PersistenceController.preview.container.viewContext)
    }
}


struct Per {
    @Binding  var categoryDeleteToggle: Bool
    //	@Binding var includedTotalExpenses: Bool
    
    @ObservedObject var category: Category
}















/*
 
 struct CategoryRow: View {
 @Environment(\.managedObjectContext) var viewContext
 @Environment(\.refresh) private var refresh
 
 @ObservedObject var category: Category
 //@State var category: Category
 // @Binding var indexSet: IndexSet
 
 @State var ColorToggleRedGray = Color.gray
 
 @State  var categoryDeleteToggle: Bool = false  // MARK: разбираться что - то связано с ??
 
 @FocusState private var nameIsFocused: Bool // для скрытия и показа всплывающей клавиатуры
 @State var dataTemp: String = ""
 
 @Binding var includedTotalExpenses: Bool
 
 var body: some View {
 
 
 
 NavigationLink () {
 
 //     CategoryEditView()
 // рабочий блок
 VStack(){
 
 VStack{
 Text("КАТЕГОРИЯ")
 .font(.subheadline)
 .foregroundColor(Color.green)
 .frame(width: 320.0, alignment: .leading)
 .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxLarge/*@END_MENU_TOKEN@*/)
 
 
 Text("\(category.catShop!)")
 .foregroundColor(myColor.GBlue)
 .frame(width: 320.0, alignment: .leading)
 .dynamicTypeSize(.xLarge)
 
 }
 .padding(.top, 30.0)
 
 
 
 Text("Изменить название категории")
 .frame(width: 320.0, height: 20.0, alignment: .leading)
 .task {
 nameIsFocused = false
 }
 TextField("\(category.catShop!)", text: $dataTemp)
 .padding(.leading, 20.0)
 .foregroundColor(myColor.GBlue)
 .frame(width: 320.0, height: 40.0, alignment: .leading)
 .background(Color("downgray"))
 .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
 
 
 Toggle(isOn: self.$category.catRashSumm ) {
 Text("Учитывать в общих расходах")
 .task {saveCateg()
 
 }
 }
 .frame(width: 320.0, alignment: .leading)
 .padding(.vertical, 10.0)
 
 
 Text("Порог трат в неделю")
 .task {
 nameIsFocused = false
 }
 .frame(width: 320.0, alignment: .leading)
 .foregroundColor(Color.gray)
 
 Text("Порог трат в месяц")
 .task {
 nameIsFocused = false
 }
 .frame(width: 320.0, height: 10.0, alignment: .leading)
 .foregroundColor(Color.gray)
 
 Text("Приоритет показа")
 .font(.headline)
 // для OC 16                                 .fontWeight(.light)
 .multilineTextAlignment(.leading)
 .frame(width: 320.0, alignment: .leading)
 
 .foregroundColor(.black)
 .padding(.bottom, 10.0)
 
 
 Toggle(isOn: $categoryDeleteToggle ) {
 
 Text("Удалить категорию")
 
 //	.foregroundColor(.blue)
 
 }
 .task {
 }
 .frame(width: 320.0)
 .tint(.red)
 Text ("Удаление категории приведет к удалению связанных с ней данных. Вы можете переименовать категорю.")
 .font(.caption)
 .fontWeight(.medium)
 
 .foregroundColor(.gray)
 .frame(width: 320.0, alignment: .leading)
 .padding(.bottom, 10.0)
 
 
 
 Button("Подтвердить изменения") {
 nameIsFocused = false
 saveCateg ()
 //	deleteItems3(offsets: indexSet)
 }
 
 .frame(width: 320.0, height: 50.0)
 .accentColor(.white)
 .background(.green)
 .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
 .padding(.bottom, 40.0)
 
 }
 
 
 .padding(.top, 5.0)
 }
 
 label: {
 // TextField("\(category.catShop!)", text: $dataTemp)
 Text("\(category.catShop!)")
 .foregroundColor(category.catRashSumm ?   .blue : .gray)
 
 }
 
 
 
 //          .padding(.bottom, 20.0)
 
 .padding(.top, 20.0)
 .padding(.bottom, 5.0)
 
 
 }
 
 
 func deleteItems3(offsets: IndexSet) {
 withAnimation {
 //print ("категори индекс", category: categoryIndex)
 //offsets.map { category[$0] }.forEach(viewContext.delete)
 //     do {
 //print ("офсет", offsets)
 
 //	viewContext.delete(category)
 
 //	viewContext.update()
 
 try? viewContext.save()
 
 print ("Не записали удаление категории")
 
 
 //		let predicates = NSPredicate(format: "categoryItemID >= 0" )
 //	category.nsPredicate = predicates
 
 
 //  } catch {
 // Replace this implementation with code to handle the error appropriately.
 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 //	let nsError = error as NSError
 //	fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
 //   }
 }
 }
 
 
 func DeleteCateg() {
 
 print(categoryDeleteToggle)
 if categoryDeleteToggle == true {
 ColorToggleRedGray = Color.red
 }
 
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
 
 */





