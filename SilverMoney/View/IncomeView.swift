//
//  SeeView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/20/23.
//

import SwiftUI



struct IncomeView: View {
    
    
    var body: some View {
        
        VStack {
        
        
        
            HStack {
                Text("Записать доходы")
                    .font(.title)
                Text ("[+]")
                    .foregroundColor(Color.green)
                Spacer()
                
            }
            .font(.title)
            .frame(width: 320.0, height: 30.0, alignment: .leading)
            
            Divider()
            
            Spacer()
            
            
            Divider()
            // горизонтальный блок категорий
            //	Text("показать за период")
            
            ScrollView (.horizontal) {
                HStack {
                    Text("показать за месяц")
                        .padding(.all, 8.0)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                    
                    Text("показать за год")
                        .padding(.all, 8.0)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                    
                    Text("показать за все время")
                        .padding(.all, 8.0)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                    
                    
                    
                    
                    
                    
                }
                .padding(.vertical, 5.0)
            }
            .font(.title3)
            .frame(width: 320.0)
            .foregroundColor(.gray)
            
            
            // конец горизонтального блока
            
            Divider()
                .padding(.bottom, 15.0)
            
            
            
            HStack () {
                VStack() {
                    HStack {
                        Button {
                            
                            
                            
                        } label: {
                            Text("1")
                                .frame(width: 72)
                                .frame(height: 72)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .accentColor(.gray)
                                .background(myColor.GSilver)
                                .cornerRadius(8)
                        }
                        
                        
                        Button("2")
                        {
                            
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        
                        
                        Button(/*@START_MENU_TOKEN@*/"3"/*@END_MENU_TOKEN@*/)
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        
                        
                        Button(" < ")
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(Color.white)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        .padding(.leading, 5)
                        
                    }
                    .padding(.trailing, 5)
                    
                    HStack {
                        Button(/*@START_MENU_TOKEN@*/"4"/*@END_MENU_TOKEN@*/)
                        {
                            
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        Button("5")
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        Button(/*@START_MENU_TOKEN@*/"6"/*@END_MENU_TOKEN@*/)
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        
                        
                        Button("-")
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.white)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        .padding(.leading, 5)
                        
                    }
                    .padding(.trailing, 5)
                    
                    HStack {
                        Button(/*@START_MENU_TOKEN@*/"7"/*@END_MENU_TOKEN@*/)
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        Button("8")
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        Button(/*@START_MENU_TOKEN@*/"9"/*@END_MENU_TOKEN@*/)
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        
                        
                        Button("+")
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.white)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        .padding(.leading, 5)
                        
                    }
                    .padding(.trailing, 5)
                    
                    HStack {
                        Button("C")
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.white)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        Button("0")
                        {
                        }
                        .frame(width: 72)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.gray)
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        
                        
                        
                        
                        
                        Button("Ввод"){
                            
                            
                        }
                        
                        .frame(width: 155)
                        .frame(height: 72)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .accentColor(.white)
                        
                        .background(myColor.GSilver)
                        .cornerRadius(8)
                        .padding(.trailing, 5)
                        
                    }
                    
                    
                }
                
            }
            
            .padding(.bottom, 25.0)
            
            
            Divider()
            
        }
        .padding(.top, 20.0)
        .padding(.bottom, 5.0)
        // .navigationBarBackButtonHidden(true)
        
    }
    
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
