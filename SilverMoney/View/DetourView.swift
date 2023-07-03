//
//  DetourView.swift
//  SilverMoney
//
//  Created by Georgeus on 03.05.2023.
//

import SwiftUI





struct DetourView: View {
    @Environment(\.dismiss) var dismiss

    @AppStorage("detourTrigger") var detourTrigger: Bool = true  // подсказка при входе
    
    let persistenceController = PersistenceController.shared
    
    @State  var skipTrigger: Bool = false
    
    
    @State private var currentPage = 0
    
    let textHelp: [String] = [
    "Возможности SilverMoney.",
    "Ведите учет расходов по категориям. \r\rНазвание категории можно изменить в любое время",
    "Установите лимит трат по любой из категорий."
    
    ]
    
    
    
    
    var body: some View {
        
   // MARK: Делать отсюда

 //       TabView {
 //           ForEach(textHelp.indices, id: \.self) { index in
            //    HelpPage()
//       }

   
            
     //   if skipTrigger == false {
            
            //      Text("lkadjghl")
            //     .onTapGesture{ooo()}


       //     Text("Поехали")

       //     Text("Поехали2")

     
            
            VStack{
                Spacer()
                Spacer()
                
               // Text("экран заставка – подсказка")
                ScrollView {
                    
                    Text("Возможности SilverMoney. \r\rВедите учет по категориям.\r\rНазвание категории всегда можно переименовать. \r\rЛюбой категории можно присвоить значение 'не учитывать в общих расходах'. \rЗаписывайте в такую категорию те траты, которые уже есть в другой категории, но Вы хотите знать сколько уходит на определенный вид трат. Например Вы купили продукты на 1000 руб., из них сладости на 300 руб. Запишите в категории Продукты 1000. а в категорию сладости 300. Укажите, что категорю сладости не учитывать в общих расходах. Расходы не будут дублироваться в общем подсчете, но Вы будите знать сколько ушло отдельно на сладости. \r\rЛимит трат для каждой категории.\rКогда предел трат будет достигнут, эта категория будет подсвечена красным цветом. \r\rЛимит трат по всем категориям. \rПри просмотре расходов общая сумма будет подсвечена красным цветом.\r\rУдалить сумму. Перейдите в раздел 'Смотреть расходы' выберите нужную категорию, в появившемся списке удалите сумму смахиванием влево ")
                    //    Text("Как внести расходы? Сначала введите сумму, потом выберите категорию.")
                    
                    
                    Spacer()
                }
                    
                    
                    Spacer()
                    
                    Toggle(isOn: $detourTrigger) {
                        Text("Показывать эту подсказку при входе?")
                            .foregroundColor(Color.gray)
                    }
                    Text("Всегда можно включить в настройках")
                        .foregroundColor(Color.gray)
                    Spacer()
                    
                    Button("Пропустить") {
                        //   skipTrigger = true
                        
                        //  ooo()
                        dismiss()
                        
                    }
                
                Spacer()

            }
            .frame(width: 320.0)
  //      }
           
   //     if  skipTrigger {
       //         MainView()
      //              .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
      //      }


    //    }

            
               


        
      
   

           
   /*         VStack {
                Spacer()

                Text("подсказка при входе")
                
                Spacer()
                
                Text("Пропустить")
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        skipTrigger = true

                    }

                Spacer()

            }
    */
     

      
   
    

        
        
        
    }
    
    
    func ooo()  {
        skipTrigger = true
    
      //  return
    }
    
    struct HelpPage: View {
        
        let text1 = "это текст"
        var body: some View {
            Text (text1)
        }
    }
    
    
    struct DetourView_Previews: PreviewProvider {
        static var previews: some View {
            DetourView()
        }
    }
}
