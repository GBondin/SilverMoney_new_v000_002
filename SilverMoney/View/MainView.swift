//
//  MainView.swift
//  Coblueta_v03
//
//  Created by George Bondin on 1/20/23.
//

import SwiftUI
//import Coblueata



// sdfgjhjsdlfg
struct myColor {
    static let GSilver = Color("GSilver")
    static let Fistashka = Color("GFistashka")
    static let DarkYellow = Color("DarkYellow")
    static let GDarkGray = Color("GDarkGray")
    static let GBlue = Color("GBlue")
    static let ColorPesok = Color("ColorPesok")
    static let ColorPurpure = Color("ColorPurpure")
    static let ColorRed = Color("ColorRed")
    static let ColorBoloto = Color("ColorBoloto")
    static let ColorBlackInvert = Color("ColorBlackInvert")
}


var valutaSymbol: String = "rublesign"

var valutaTxt: String = "RuB"

let sort1 = NSSortDescriptor(keyPath: \Category.categoryPriority, ascending: false)
let sort2 = NSSortDescriptor(keyPath: \Category.categoryID, ascending: true)

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("detourTrigger") var detourTrigger: Bool = true  // подсказка при входе
        @AppStorage("categoryItemsG") var categoryItemsG: Int = 0

    // сохраняем в установки программы состояние первоначальной записи в базе
    @AppStorage("starterCategory") var starterCategory: Bool = false
    
    // подтягивание данных из базы
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.summData , ascending: true)],
        predicate: NSPredicate(format: "categoryItemID >= 0" ),
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        //	sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryPriority, ascending: true)],
        sortDescriptors: [sort1, sort2],
        predicate: NSPredicate(format: "categoryID >= 0 "),
        animation: .default)
    private var category: FetchedResults<Category>
    
    
    @State  var trigerAddItem = false
    @State private var dataStrEx: String = "" // ввод данных
    @State private var dataStrInt: Int = 0
    @State private var dataStrEx2: String = ""
    @State private var dataStrCat: String = "" // Выбранная категория
    @State private var textTrat: String = "Внести расходы"
 //   init() {
//       self.textTrat = textTrat
//    }
    @State    private var showingSheet = false
    @State    private var showingSheetCateg = false
    
    @State private var showingSheetGBlock = false
    
    @State var  opacityT = 1.0
    
    @State var dataStrEx5: String = "" // временно при переделке, нужно заменить нормальное название
    
    
    @State var dataStrEx7: String = "" // требует замены
    
    var xTemp: Int = 0
    let ttt:Text = Text(Image(systemName:"square.grid.3x1.folder.fill.badge.plus"))
    
    private let infoWarningInput: String = "Сначала введите сумму, потом выберите категорию."
    private let bottonLable: [String] = ["0","1","2","3","4","5","6","7","8","9","C","+","-","=","<"]
    
    
    @State var tttrrr = false
    
  @State var itemsCtegoryToContentItems: Int16 = 0
  
  
   @State var itemsCtegL: Int16 = 0
  
  struct aaaa{
  var gggg: String = ""
  var cccc: Int16 = 0
  }
@State var gggg: String = ""
@State var cccc: Int16 = 0


  @State var yyyyy = false
  
  @State var trigger89 = false
 @State var trigger99 = false
 
    
    var body: some View  {
        VStack(){
            VStack() {
                HStack {
                    Text(textTrat)
                        .font(.title)
                        .fontWeight(.bold)
                        
                    Text ("[–]")
                        .foregroundColor(myColor.ColorRed)  //Color.red
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    ZStack{
                        Label("", systemImage: "gearshape.2")
                            .padding(.leading, 5.0)
                            .frame(width: 40.0, height: 40.0)
                            .font(.title2)
                            .onTapGesture(perform: {
                                showingSheetCateg.toggle()
                            })
                            .sheet(isPresented: $showingSheetCateg) {
                                SettingView()
                            }
                    }
                }
                
                .frame(height: 30.0, alignment: .leading)
                            .padding(.horizontal, 10.0)

                Divider()
                               .padding(.horizontal, 10.0)

                
                VStack(alignment: .leading) {

                    if !trigerAddItem {
                        if dataStrEx == "" {
                            VStack(alignment: .leading){
                                Text(infoWarningInput)
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(4)
                                    .padding(.top, 20.0)
                                     .task{
                        //dataStrEx = "введите сумму"
                        }
                            }
                            Spacer()
                        }
                        
                        Spacer()
                        Text(dataStrEx)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .padding(.bottom, -12.0)
                            .dynamicTypeSize(.accessibility2)
                            .frame(alignment: .trailing)
                    }
                    
                    else {
                    HStack{
                        VStack(alignment: .leading){
                        Text("Последняя внесенная запись:")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .padding(.top, -2.0)
                            .dynamicTypeSize(.xxxLarge)

                        Text("Категория:")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .dynamicTypeSize(.xxxLarge)
                            .padding(.top, 0.2)
                        
                        
                        Text( dataStrCat )
                            .foregroundColor(Color.green)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .dynamicTypeSize(.xxxLarge)
                            .padding(.bottom, -2.0)
                        
                        Text( "Сумма")
                            .foregroundColor(.gray)
                            .dynamicTypeSize(.xxxLarge)
                            .padding(.top, -1)
                        
                        HStack{
                            Text(dataStrEx2 )
                                .foregroundColor(Color.green)
                                .dynamicTypeSize(.xxxLarge)
                            // для OC 16    .fontWeight(.light)
                            Label("", systemImage: valutaSymbol)
                        }
                        }
                        .padding(.trailing, 20.0)
                        Spacer()
                        }
                                                Spacer()

                    }

                }
                .padding(.top, 3.0)
                .frame(alignment: .leading) //height: 120.0,
                                                .padding(.horizontal, 10.0)

            }
            .onAppear () {
                addItemDefault() //запись даных по умолчанию MARK: поставить в инициализацию вместе с фукнкцией!
            }
                 
            
            Divider()
            .padding(.horizontal, 10.0)

            
 // горизонтальный блок категорий
            HStack {
                
                ScrollView (.horizontal) {
                    HStack() {
                        
                        ForEach(category) {category in
                            
                            Button("\(category.catShop!)") {
                                if category.categoryID != 0 {
                                    //   itemsCtegL = category.categoryID
categoryItemsG = Int(category.categoryID)

gggg = category.catShop!

cccc = category.categoryID

                                	dataStrEx =  replacLastCharacter("=")
                                    dataStrEx2 = dataStrEx
                                    addItem(category.categoryID)
                                    dataStrCat = "\(category.catShop!)"
                                     tttrrr = true
                                     
                                       showingSheetGBlock = dataStrEx == "" ? true : false

//print(itemsCtegoryToContentItems)
//ContentItemView().reca(itemsCtegoryToContentItems)
                            //  ContentItemView()

                                    // introducedСosts()
                                }

                                else {
                                    addItemDefTemp()
                                }
                            }
                            .frame(height: 35.0)
                            .padding(.horizontal, 10.0)
                            .fontWeight(.medium)
                            .background(category.categoryID == 0 ? myColor.ColorPurpure : myColor.GBlue)
                            .cornerRadius(6.0)
                            .accentColor(category.catRashSumm ? .white : .gray)
                            .onChange(of: showingSheetGBlock) { newValue in
                                trigger89 = false
                                trigger99 = false
                          //  ContentItemView().reca1(2)
                             //   print(itemsCtegL)
                             
                            }
                   .sheet(isPresented: $showingSheetGBlock) {
                       ContentItemView(gggg: .constant("\(gggg)"), cccc: .constant(Int(cccc)))

                   }

                        }

                    }
                    .padding(.vertical, 10.0)
                }
                .padding(.horizontal, 10.0)
                .frame(height: 40.0)
                .font(.title3)

                /*		// образец кода жеста
                 let press = LongPressGesture(minimumDuration: 1)
                 .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                 gestureState = currentState
                 }
                 
                 Circle()
                 .fill(isDetectingLongPress ? Color.yellow : Color.green)
                 .frame(width: 100, height: 100, alignment: .center)
                 .gesture(press)
                 
                 */			// конец образец кода жеста
                
            }
            Image("ArrowImage")
                .frame(height: 3.0)
                .padding(.horizontal, 10.0)

                .task {
                    opacityTimeInterval()
                }
                .opacity(opacityT)
            // .animation(.linear(duration: 1.0))
            // .withAnimation(.linear(duration: 1))
                .animation(.linear(duration: 2.0), value:  opacityT)
            
// конец горизонтального блока
            
            Divider()
               // .frame(width: 350.0)
                .padding(.bottom, 5.0)
            .padding(.horizontal, 10.0)
            
            HStack () {
                
                VStack() {
                    HStack {
                        
                        Button {
                            dataStrEx = replacLastCharacter("1")
                        } label: {
                            Text("1")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("2")
                        } label: {
                            Text("2")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("3")
                        } label: {
                            Text("3")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("<")
                        } label: {
                                                    Spacer()

                            Text("<")
                               // .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                               // .background(myColor.GSilver)
                                .cornerRadius(8)
                                                            Spacer()

                        }
                                                                    .border(.gray)
                                .background(myColor.GSilver)

                        //	.padding(.leading, 5)
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            dataStrEx = replacLastCharacter("4")
                        } label: {
                            Text("4")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("5")
                        } label: {
                            Text("5")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("6")
                        } label: {
                            Text("6")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("-")
                        } label: {
                                                    Spacer()

                            Text("-")
                               // .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                               // .background(myColor.GSilver)
                                .cornerRadius(8)
                                                            Spacer()

                        }
                        
                        //	.padding(.leading, 5)
                                                                    .border(.gray)
                                .background(myColor.GSilver)

                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            dataStrEx = replacLastCharacter("7")
                        } label: {
                            Text("7")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("8")
                        } label: {
                            Text("8")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("9")
                        } label: {
                            Text("9")
                                .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("+")
                        } label: {
                                                    Spacer()

                            Text("+")

                               // .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                               // .background(myColor.GSilver)
                                .cornerRadius(8)
                                 Spacer()

                        }
                        //.padding(.leading, 5)
                                                                    .border(.gray)
                                .background(myColor.GSilver)

                    }
                    Spacer()
                    HStack {
                        Button {
                            dataStrEx = replacLastCharacter("del")
                        } label: {
                            Text("C")
                              .frame(width: 86)
                                .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                        Spacer()
                        
                        Button {
                            dataStrEx = replacLastCharacter("0")
                        } label: {
                            Text("0")
                                .frame(width: 86)
                               .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                                                                    .border(.gray)

                     
                         Spacer()
                        Button {
                            dataStrEx = replacLastCharacter("=")
                        } label: {
                                                                    Spacer()

                            Text("=")
                              //  .frame(width: 170)
                              .frame(height: 55)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                              //  .background(myColor.GSilver)
                                .cornerRadius(8)
                                                                            Spacer()


                        }
                                            .border(.gray)
                                .background(myColor.GSilver)

                    }

                    
                }

                /*			RoundedRectangle(cornerRadius: 4.0)
                 .padding(.leading, 3.0)
                 //.padding(.trailing, 5.0)
                 .frame(width: 40.0)
                 .onTapGesture(perform: {
                 showingSheet.toggle()
                 })
                 .sheet(isPresented: $showingSheet) {
                 ContentView()
                 }
                 .opacity(0.01)
                 */
            }
             .frame(height: 230.0)
            .padding(.horizontal, 10.0)


            Divider()
                            .padding(10.0)

            ZStack{
                RoundedRectangle(cornerRadius: 8.0)
                    .frame(height: 55)
                    .foregroundColor(myColor.GSilver)
                    .onTapGesture(perform: {
                        showingSheet.toggle()
                    })
                    .sheet(isPresented: $showingSheet) {
                        ContentView()
                    }

                Text("СМОТРЕТЬ ВСЕ РАСХОДЫ")
                    .font(.headline)
                    .foregroundColor(myColor.GBlue)
                    .dynamicTypeSize(.xxLarge)
                    .onTapGesture(perform: {
                        showingSheet.toggle()
                    })
                    .sheet(isPresented: $showingSheet) {
                        ContentView()
                    }
                //	.frame(width: 315.0, height: 40.0)

            }
            
            .cornerRadius(8.0)
            .border(.gray)
                 .padding(.horizontal, 10.0)
                 .padding(.vertical, 2.0)

            // показ экрана обхода
            .sheet(isPresented: $detourTrigger) {
                //   DetourView()
                TutorialView()
            }
            
            
        }
        .padding(.top, 10.0)
        .padding(.bottom, 20.0)

    }
    
  
    
    func test() {
 // ContentItemView().reca2(2)
    }
    
    
    // Приведение вводимых данных + калькулятор введенных данных
    func replacLastCharacter (_ textMatch:String) -> String{

// проверка на первоначальное нажатие категории без введенной суммы
if dataStrEx7 == "" && textMatch == "=" {
return ""
}
else {
        var triggerEquals = false
        
        var textMatchReplace: String = dataStrEx7
        trigerAddItem = false
        textMatchReplace += textMatch
        
        
        if textMatch == "<" {
            if textMatchReplace.count > 1 {
                textMatchReplace.removeLast(2)
            }
            else{
                textMatchReplace = ""
            }
        }
        
        if textMatch == "del" {
            textMatchReplace = ""
        }
        
        if textMatchReplace.first == "+" || textMatchReplace.first == "-" || textMatchReplace.first == "0" {
            textMatchReplace.removeFirst()
        }
        
        if textMatchReplace.count >= 2 {
            let index = textMatchReplace.index(textMatchReplace.endIndex, offsetBy: -2)
            let index2 = textMatchReplace.index(textMatchReplace.endIndex, offsetBy: -1)
            
            if textMatchReplace[index] == "+" && textMatchReplace[index2] == "+" {
                textMatchReplace.remove(at: index)
            }
            else if textMatchReplace[index] == "+" && textMatchReplace[index2] == "-" {
                textMatchReplace.remove(at: index)
                
            }
            else if textMatchReplace[index] == "-" && textMatchReplace[index2] == "+" {
                textMatchReplace.remove(at: index)
                
            }
            else if textMatchReplace[index] == "-" && textMatchReplace[index2] == "-" {
                textMatchReplace.remove(at: index)
                
            }
            else if textMatchReplace[index] == "-" && textMatchReplace[index2] == "=" {
                textMatchReplace.remove(at: index)
            }
            else if textMatchReplace[index] == "+" && textMatchReplace[index2] == "=" {
                textMatchReplace.remove(at: index)
          
            }
            
            
            if textMatch == "="   {
                textMatchReplace = summString(abc: textMatchReplace)
                triggerEquals = true
               
            }
            
            
            // MARK: сюда нужно заменять на расчет после равно!
            
            
            /*
             else if textMatchReplace[index] == "=" && textMatchReplace[index2] == "=" {
             textMatchReplace.remove(at: index)
             }
             */
        }
      
        // калькулятор суммы
        //struct calcString {
        
        func summString(abc: String) -> String {
            var inboxABC = abc
            var digitAString = ""
            var digitBString = ""
            var charNum = 0
            var znak = ""
            var znakB = ""
            var triggerA = false
            var digitA = 0
            var digitB = 0
            var summABC = 0
            
            
            if inboxABC.first == "+" || inboxABC.first == "-" || inboxABC.first == "0" {
                inboxABC.removeFirst()
                // dataStrEx7 = inboxABC
                
            }
            
            if inboxABC.first != "=" {
                for char in inboxABC {
                    
                    // собираем первое число и второе число
                    if char != "+" && char != "-" && char != "="{
                        // собираем первое число
                        if triggerA == false {
                            digitAString += String(char)
                            charNum += 1
                        }
                        
                        else if triggerA == true {
                            digitBString += String(char)
                            charNum += 1
                        }
                    }
                    
                    // записали первый знак в знак
                    else if char == "+" || char == "-" {
                        
                        if triggerA == false {
                            znak = String(char)
                            charNum += 1
                            triggerA = true
                        }
                        
                        else if triggerA == true {
                            znakB = String(char)
                            charNum += 1
                            
                            digitA = Int(digitAString)!
                            digitB = Int(digitBString)!
                            if znak == "+" {
                                summABC = digitA + digitB
                            }
                            
                            if znak == "-" {
                                summABC = digitA - digitB
                            }
                            
                            digitAString = String(summABC)
                            digitBString = ""
                            znak = znakB
                            znakB = ""
                        }
                    }
                    
                    else if char == "=" && znak != "" {
                        
                        digitA = Int(digitAString)!
                        digitB = Int(digitBString)!
                        
                        if znak == "+" {
                            summABC = digitA + digitB
                        }
                        if znak == "-" {
                            summABC = digitA - digitB
                        }
                        break
                    }
                    
                    else if char == "=" && znak == "" {
                        
                        summABC = Int(digitAString)!
                    }
                    
                    inboxABC.removeFirst(charNum)
                    charNum = 0
                }
            }
            
            return String(summABC)
        }
        
        //  }
        
        //   z = calcString().summString(abc: abc)
        
        dataStrEx7 = textMatchReplace
        if triggerEquals == true {
            dataStrEx7 = ""
        }
        return textMatchReplace // потом заменить
        }
  }
      
      
     func calkData(_ dataStrEx7: String) {
        
        dataStrInt = Int(dataStrEx7)!
        
        
    }
    
    func clearDataStrEx(){
        trigerAddItem = false
    }
    
    func opacityTimeInterval(){
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            opacityT = 0.0
        }
    }
    
    
    
    // ДОБАВЛЯЕТ набранную сумму в выбранную категорию
    func addItem(_ x:Int16) {
        
        if dataStrEx == "" {
            // Label("", systemImage: "exclamationmark.triangle.fill")
            ///    dataStrCat = "000"
            ///
            if     trigerAddItem == true {
                trigerAddItem = false
                //        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                //        trigerAddItem = true
                //    }
            }
        }
        
        // MARK: доделывать если много 00000
        else if dataStrEx == "0" {
            trigerAddItem = false
            
        }
        
        
        // проверить что не так с категорией! dataStrCat
        
        
        
        else if dataStrEx != "" {
            
            let newItem = Item(context: viewContext)
            newItem.mCatsData = dataStrCat  // потом возможно убрать, когда сделать запись категории через ID
            newItem.timeStampData = Date()
            
            let  convSumm = Int32(dataStrEx)
            
            newItem.summData = convSumm!
            newItem.categoryItemID = Int32(x)// сюда сделать запись категории в соотвествии с ID категории
            newItem.noteSummData = ""
            
            do {
                try viewContext.save()
                trigerAddItem = true
                //trigerOne = true
                //dataStrCat = ""
            }
            catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            
            
            
        }
        //   dataStrEx7 = ""
        //  dataStrEx = ""
        
    }
    
    
    
    
    // MARK: повторяет функцию в CategView
    func addItemDefTemp () {
        /*    // запись первой строки – инициализация для превью
         let newItem = Item(context: viewContext)
         newItem.timestampData = Date()
         newItem.noteSummData = "info"
         newItem.mCatsData = "пример"
         newItem.summData = 0
         */
        // инициализация начальных данных категорий для превью
        let mCatInit: [String] = ["Новая категория"]
        
        
        //нужно начинать не с 0 категории, а с 1! 0 резеврируем для удаления?, но пока остается с 0
        
        let categoryCount: Int = (category.count ) //
                                                   //нужно начинать не с 0 категории, а с 1! 0 резеврируем для удаления?, но пока остается с 0
        let mCatInd: Int16 = Int16(categoryCount)
        for mCats in mCatInit {
            let newCategory = Category(context: viewContext)
            newCategory.catShop = mCats
            newCategory.categoryID = mCatInd
            newCategory.categoryItemID = mCatInd
            newCategory.catUUID = UUID()
            newCategory.catNote = ""
            newCategory.onRemove = false
            newCategory.catRashSumm = true
            newCategory.categoryPriority = 1.0
            
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
        //    starterCategory = true
    }
    
    
    //  MARK: пока отключено использование
    func timer() {
        // сделать функцию таймера для выключения следующей функции
        
        
    }
    
    //  MARK: пока отключено использование
    func introducedСosts() {
        
        
        
        if dataStrCat != "" && trigerAddItem == true{  //&& dataStrEx != ""
            textTrat = "Учтено"
            _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                textTrat = "Внести расходы"
            }
        }
        
    }
    
    
    func amountCalculator (_ dataIntEx: Int) {
        // dataStr = Int(dataStrEx)
        // dataStr = 256+4-60
        // self.dataStrEx = (rrr as Any)
    }
    
    private  func addItemDefault () {
        if starterCategory == false {
            let newItem = Item(context: viewContext)
            newItem.timeStampData = Date()
            newItem.noteSummData = "..."
            newItem.mCatsData = "пример"
            newItem.summData = 0
            
            
            // инициализация начальных данных Нулевой категории для превью – будет использоваться для добавления новой категории прямо из списка категорий
            let mCatZerro: [String] = ["Добавить новую категорию"] // нулевая категория, будет всегда добавляться в конец всех категорий N категории 0
            let newZeroCategory = Category(context: viewContext)
            newZeroCategory.catShop = mCatZerro[0]
            newZeroCategory.categoryID = 0
            newZeroCategory.categoryItemID = 0
            newZeroCategory.catUUID = UUID()
            newZeroCategory.catNote = ""
            newZeroCategory.onRemove = false
            newZeroCategory.categoryPriority = 0.0
            newZeroCategory.catRashSumm = true  // учитывать в общих расходах
            
            try? viewContext.save()
            
            
            // инициализация начальных данных категорий
            let mCatInit: [String] = ["Продукты", "Товары", "Услуги", "Рестораны", "Развлечения", "Комм. платежи", "Здоровье", "Погашение кредита", "другое"]
            
            var mCatInd: Int16 = 1
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
            // запись файла базы
            try? viewContext.save()
        }
        starterCategory = true
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
    
}
