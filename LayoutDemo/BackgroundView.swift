//
//  BackgroundView.swift
//  LayoutDemo
//
//  Created by localadmin on 25.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
      ZStack {
        Color.black
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
      }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
