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
    case none     = "None"
}

struct ActionView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var actionViewIsVisible: Bool = false
    
    let actionTypes: [ActionType] = [.clearList, .completeAll]
    let sortTypes: [SortType] = [.name, .aisle, .none]
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack() {
                    
                    Text("Actions")
                        .padding()
                        .font(.custom("HelveticaNeue-Medium", size: 20))
                        .foregroundColor(Color("BodyText"))
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.actionViewIsVisible.toggle()
                        }
                    }) {
                        Text(actionViewIsVisible ? "Hide":"Show")
                            .foregroundColor(Color("Orange"))
                            .font(.custom("HelveticaNeue-Bold", size: 16))
                            .frame(width: 60, alignment: .trailing)
                            .animation(nil)
                    }.padding()
                }
                .padding(.horizontal, 5).padding(.top, 5)
                
                if actionViewIsVisible {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(actionTypes, id: \.self) { type in
                                ActionViewButtonItem(actionType: type)
                            }
                        }
                        .padding(.leading, 18).padding(.top,3)
                    }
                    .padding(.top, -20)
                    
                    Text("Sort by")
                        .padding().padding(.leading, 5)
                          .font(.custom("HelveticaNeue-Medium", size: 20))
                          .foregroundColor(Color("BodyText"))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(sortTypes, id: \.self) { type in
                                SortViewButtonItem(type: type)
                            }
                            
                        }
                        .padding(.leading, 18).padding(.bottom)
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
        ActionView().environmentObject(ListHolderDataModel(window: UIWindow()))
    }
}
#endif


