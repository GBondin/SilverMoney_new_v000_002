    //
    //  TutorialView.swift
    //  SilverMoney
    //
    //  Created by Georgeus on 10.05.2023.
    //

import SwiftUI

struct TutorialView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("detourTrigger") var detourTrigger: Bool = false
    @State private var currentPage = 0

    let pageHeadings = [//"Узнайте как использовать возможности \rSilverMoney", // 1
        "Ведите учет расходов по категориям", //2
        "Управляйте категориями.", //3
        "Предупреждать о превышении трат", //4
        "Период подсчета расходов", //5
        "Включите уведомления",  //6
        "Используйте возможности \r 'НЕ учитывать в общих расходах'" //7
    ]
    
        let pageSubHeadings = [//"Для быстрого ознакомленя смахните влево, либо нажмите 'Далее...' ", //1
        "\r Что бы записать расходы, \r сначала введите сумму, \r потом выберите категорию", //2
        "\r Категории можно исключить из общего подсчета трат. \r - Переименовать. \r - Изменить порядок показа. \r - Удалить." , //3
        "\r При превышении лимита трат сумма будет подсвечена красным цветом. \r Установить лимит можно как для отдельной категории, так и для всех категорий вместе.", //4
        "\r Показывает все Ваши траты за выбранный период. Можно изменить в любое время. ", //5
        "\r Разрешите приложению SilverMoney отправлять Вам напоминание о внесении расходов",  //6
        "\r Узнайте сколько тратите на 'любимые печеньки', или просто посчитайте Ваши траты в отпуске. Запишите всю потраченную сумму в любую подходящую категорию, а сумму на 'печеньки' впишите в одельную категорию и укажите в настройках 'Не учитывать в общих расходах'. Теперь Вы знаете сколько потратили на любимые 'печеньки', и при этом эта позиция не будет дублироваться в общих расходах." //7
    ]
    
    let pageInfo = [//"", //1
        "", //2
        "(включается и выключается в настройках)", // 3
        "(включается и выключается в настройках)", //4
        "(включается и выключается в настройках)", //5
        "напоминание будет приходить один раз в день, включается и выключается в настройках",  //6
        "(включается и выключается в настройках)" //7
    ]
    
    var body: some View {
        
        VStack {
            TabView(selection: $currentPage) {
                ForEach(pageHeadings.indices, id: \.self) { index in
                    TutorialPage(heading: pageHeadings[index], subHeading: pageSubHeadings[index], pInfo:pageInfo[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            .animation(.default, value: currentPage)
            
            VStack(spacing: 20) {
                Text(currentPage == pageHeadings.count - 1 ? "" : "Cмахните влево, \rлибо нажмите 'Далее...'")
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                
                Button(action: {
                    if currentPage < pageHeadings.count - 1 {
                        currentPage += 1
                    } else {
                        detourTrigger = true
                        dismiss()
                    }
                }) {
                    Text(currentPage == pageHeadings.count - 1 ? "Начать" : "Далее...")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .frame(width: 250.0)
                        .background(Color(.systemIndigo))
                        .cornerRadius(8)
                }
                
                if currentPage < pageHeadings.count - 1 {
                    
                        // Кнопка пропустить
                    /*     Button(action: {
                     detourTrigger = true
                     dismiss()
                     }) {
                     
                     Text( "Пропусутить")
                     .font(.headline)
                     .foregroundColor(Color(.darkGray))
                     
                     }
                     */
                }
            }
            .padding(.bottom)
            
        }
        
    }
}

struct TutorialPage: View {
    
        //  let image: String
    let heading: String
    let subHeading: String
    let pInfo: String
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
            
            
            VStack(spacing: 5) {
                
                Text(heading)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30.0)
                
                Text(subHeading)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                    //   Label("", systemImage: "gearshape.2")
                    //    Text(Image(systemName: "star"))
                Text(pInfo)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .italic()
                    .padding(.top, 10.0)
                
                if pInfo.contains("настройках") {
                    Label("", systemImage: "gearshape.2")
                }
                
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
        

    }
}
