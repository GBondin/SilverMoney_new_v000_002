//
//  CategorySummView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 2/5/23.
//

import SwiftUI

struct CategorySummView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)

       
        VStack {
            Text("Today's Weather")
                .font(.title)
                .border(.gray)

            HStack {
                Text("🌧")
                    .alignmentGuide(VerticalAlignment.top) { _ in 100 }
                    .border(.gray)
                Text("Rain & Thunderstorms")
                    .border(.gray)
                Text("⛈")
                    .alignmentGuide(VerticalAlignment.top) { _ in 20 }
                    .border(.gray)
            }
        }
        
        
        
        
        
        
        
        
        VStack{
            
           
    
            Circle()
                .alignmentGuide(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Guide@*/.top/*@END_MENU_TOKEN@*/) { dimension in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/dimension[.top]/*@END_MENU_TOKEN@*/
                }
           //   .fill(Color.pink)
           // .scaledToFill()
              .frame(width: 300, height: 200)
              .position(.zero)

                .border(Color(white: 0.75))
            Circle()
               // .fill(Color.pink)
           // .scaledToFill()
              .frame(width: 300, height: 500)

                .border(Color(white: 0.75))
            
                .position(/*@START_MENU_TOKEN@*/.zero/*@END_MENU_TOKEN@*/)
            
        }
    }
}

struct CategorySummView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySummView()
    }
}
