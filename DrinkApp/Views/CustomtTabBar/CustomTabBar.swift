//
//  CustomTabBar.swift
//  DrinkApp
//
//  Created by Mona Rostami on 11/11/2022.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case heart
    case mug
    case share
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    var body: some View {
        VStack{
            HStack{
                ForEach(Tab.allCases, id: \.rawValue){tab in
                    Spacer()
                    var name = nil
                    if()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                    Spacer()
                    
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.house))
    }
}
