//
//  SortView.swift
//  Elenco
//
//  Created by James Bernhardt on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct SortViewItem: View {
    
    var title: String
    @State var isSelected: Bool
    
    var body: some View {
        Button(action: {
            self.isSelected = !self.isSelected
        }) {
            Text(self.title)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .border(borderColor(), width: 3)
                .font(.system(size: 20))
                .foregroundColor(viewTitleColor())
                .background(viewBackgroundColor())
                .cornerRadius(5)
        }
    }
    
    // Return border colour
    private func borderColor() -> Color {
        return isSelected ? Color("Orange") : Color("Dark-Gray")
    }
    
    private func viewBackgroundColor() -> Color {
        return isSelected ? Color("Orange") : Color(.white)
    }
    
    private func viewTitleColor() -> Color {
        return isSelected ? Color(.white) : Color("Dark-Gray")
    }
}

struct SortView: View {
    
    
    var body: some View {
        ZStack {
            ShadowView(width: 380, height: 150)
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 150) {
                    Text("Sort By")
                    .padding(.vertical, 15)
                    .font(.system(.title))
                    
                    
                    Button(action: {
                        print("hide")
                    }) {
                        Text("Hide")
                        .foregroundColor(Color("Orange"))
                        .font(.system(size: 20))
                        .alignmentGuide(.leading) {d in  d[.leading] }
                        .padding(.vertical, 15)
                    }
                }.padding(.vertical, 15)
                
                HStack {
                    SortViewItem(title: "Name", isSelected: true)
                    SortViewItem(title: "Type", isSelected: false)
                    SortViewItem(title: "Quantity", isSelected: false)
                    
                }
            }
            
            
            
        }
        
    }
    
}




struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}

