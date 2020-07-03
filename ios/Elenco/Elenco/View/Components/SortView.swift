//
//  SortView.swift
//  Elenco
//
//  Created by James Bernhardt on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI
import Foundation

public enum SortType: String {
    case name     = "Name"
    case aisle    = "Aisle"
    case quantity = "Quantity"
    case none     = "None"
}

struct SortView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var myListModel: MyListDataModel
    @State var sortViewIsVisible: Bool = false
    
    let sortTypes: [SortType] = [.name, .aisle, .quantity, .none]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack() {
                    
                    Text("Sort By")
                        .padding()
                        .font(.custom("HelveticaNeue-Medium", size: 20))
                        .foregroundColor(Color("BodyText"))
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.sortViewIsVisible.toggle()
                        }
                    }) {
                        Text(sortViewIsVisible ? "Hide":"Show")
                            .foregroundColor(Color("Orange"))
                            .font(.custom("HelveticaNeue-Bold", size: 16))
                    }.padding()
                }
                .padding(.horizontal, 5).padding(.top, 5)
                
                if sortViewIsVisible {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(sortTypes, id: \.self) { type in
                                SortViewButtonItem(type: type)
                            }
                            
                        }
                        .padding(.leading, 18).padding(.bottom).padding(.top,3)
                    }
                    .padding(.top, -20).padding(.bottom, 5)
                }
            }
            .background(colorScheme == .dark ? Color("Lead") : Color("Light-Gray").opacity(0.15))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView().environmentObject(MyListDataModel(window: UIWindow()))
    }
}
#endif


