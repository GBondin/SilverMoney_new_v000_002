//
//  IncomeLookView.swift
//  SilverMoneyCoreData
//
//  Created by George Bondin on 4/19/23.
//

import SwiftUI

struct IncomeLookView: View {
    var body: some View {
        
        
        
        
        
        
        VStack{
            
            
            
            HStack {
                Text("Доходы")
                    .font(.title)
                Text ("[+]")
                    .foregroundColor(Color.green)
                Spacer()
                
            }
            .font(.title)
            .frame(width: 320.0, height: 30.0, alignment: .leading)
            
            
            
            Divider()
            /**
             Text("\(TextSummCatAllandCatOnly)")
             .fontWeight(.medium)
             .foregroundColor(.gray)
             .multilineTextAlignment(.leading)
             
             // попробовать сделать через инициализацию
             .onAppear {
             DayTimer(periodRaschetText)
             }
             .padding(/*@START_MENU_TOKEN@*/.top, -5.0/*@END_MENU_TOKEN@*/)
             .font(.headline)
             .multilineTextAlignment(.leading)
             //   .padding(.top, 2.0)
             .frame(width: 320.0, alignment: .leading)
             .padding(.leading, 8.0)
             
             
             Text("период: \(periodRaschetText)")
             
             .frame(width: 320.0, alignment: .leading)
             .frame(alignment: .leading)
             .padding(.leading, 8.0)
             .foregroundColor(.gray)
             .font(.subheadline)
             
             Text("Cумма RUB: \(totalAmount5)")
             .frame(width: 320.0, alignment: .leading)
             .frame(alignment: .leading)
             .padding(.leading, 8.0)
             .foregroundColor(.green)
             .font(.subheadline)
             
             
             */
            
            Spacer()
            
            
            /*
             ForEach(itemsC, id:\.self) { item in
             NavigationLink() {
             }
             label:{
             Text("\(item.summData )")
             }
             }
             */
            
            //	Divider()
            /***			NavigationView {
             List {
             ForEach(category) {category in
             let categoryID = category.categoryID
             //   let itemsCategoryID = category.categoryID
             
             NavigationLink() {
             
             NavigationView {
             List{
             ForEach(items) { item in   //ForEach(items, id:\.self)
             //  if item.categoryItemID == categoryID { // подбор чеков соответствующей категории
             
             
             NavigationLink(){
             Form {
             TextEditor(text: $tempText)
             .frame(height: 200.0)
             //						 .task{tempText=item.noteSummData!}
             Text ("Комментарий к сумме: \(item.summData )")
             
             }
             
             .navigationBarBackButtonHidden(true) // скрытие кнопки назад
             // записываем изменения при выходе из формы (при нажатии кнопки назад
             
             //						.onDisappear(perform: {if tempText != "" {
             item.noteSummData = self.tempText
             try? self.viewContext.save()
             //						 tempText = ""
             }
             })
             
             }
             
             label: {
             HStack(alignment: .top)  {
             //  Text("\(item.categoryItemID)") // номер категории
             //  Text("\(categoryID)")
             Text(item.timestampData!,  style: .date)
             // для OC 16             .fontWeight(.light)
             .foregroundColor(Color.gray)
             .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
             .multilineTextAlignment(.leading)
             .lineLimit(1)
             .frame(maxWidth: 200.0, alignment: .leading) //130
             //      Text("\(category[Int(item.categoryItemID)].catShop!)")
             
             Text("Rub: \(item.summData )")
             
             .frame(maxWidth: 100.0, alignment: .trailing)
             .font(.body)
             .multilineTextAlignment(.trailing)
             .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
             
             }
             .padding(.all, 8.0)
             
             }
             
             }
             
             //						  .onDelete(perform: deleteItems)
             
             
             }
             // .background(.white)
             
             
             //						  .onAppear {categPredicate(categoryID)}
             ///						  .task { TextSummCatAllandCatOnly = "на \(category.catShop!)" }
             //    .onAppear { totalAmount5 = totalAmount2}
             //  .onAppear {categPredicateC(categoryID)}
             //  .task { categoryAll = false }
             
             
             
             // MARK: подумать как перейти на первый экран
             
             
             }
             //  .foregroundColor(.black)
             //  .background(.black)
             
             
             }
             
             
             label: {
             //	ZStack{
             //			RoundedRectangle(cornerRadius: 8)
             //			.foregroundColor(.black)
             
             //		HStack() {
             Text("\(category.catShop!) " )  // \(categoryID) \(totalAmount2)
             //	RoundedRectangle(cornerRadius: 8.0)
             
             .foregroundColor(category.catRashSumm ? .gray : .white)
             .frame(height: 35.0)
             //.padding(.all, 7.0)
             
             //								.onAppear  {reka(category.categoryID, category.catRashSumm)  }
             
             
             //     .task { categoryAll = true }
             //    .onAppear { itemsCategoryIDPredicate (categoryID)}
             //		}
             
             //	}
             }
             
             
             
             //					.refreshable (){
             //						addItem()
             //					 }
             
             }
             //изменяет цвет фона списка	.listRowBackground(myColor.Silver)
             //					.onAppear { hyhyhyh() }
             //   .task { TextSummCatAllandCatOnly = "по всем категориям:"}
             
             }
             .padding(.bottom, 25.0)
             
             }
             //								.accentColor(myColor.Fistashka)
             
             
             
             
             .padding(.bottom, 0.0)
             
             
             Divider()
             ***/		//          .padding(.bottom, 20.0)
        }
        .padding(.top, 20.0)
        .padding(.bottom, 5.0)
        
        
    }
    
    
    
}

struct IncomeLookView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeLookView()
    }
}
