//
//  SwiftUIViewC.swift
//  article
//
//  Created by localuser on 21.06.20.
//  Copyright © 2020 localuser. All rights reserved.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

extension VerticalAlignment {
    private enum MyVerticalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.top]
        }
    }
    
    static let myVerticalAlignment = VerticalAlignment(MyVerticalAlignment.self)
}

extension VerticalAlignment {
    private enum MybVerticalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    
    static let mybVerticalAlignment = VerticalAlignment(MybVerticalAlignment.self)
}

extension VerticalAlignment {
    private enum MyHalfWidth : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.top] + (d.width / 2)
        }
    }
    
    static let myVA = VerticalAlignment(MyHalfWidth.self)
}

extension HorizontalAlignment {
    private enum MyHorizontalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.leading]
        }
    }
    
    static let myHorizontalAlignment = HorizontalAlignment(MyHorizontalAlignment.self)
}

extension HorizontalAlignment {
    private enum MybHorizontalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.trailing]
        }
    }
    
    static let mybHorizontalAlignment = HorizontalAlignment(MybHorizontalAlignment.self)
}

extension Alignment {
    static let myAlignment = Alignment(horizontal: .myHorizontalAlignment, vertical: .myVerticalAlignment)
}

extension HorizontalAlignment {
  private enum MyHalfHeight : AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.leading] + (d.height / 2)
            
        }
    }
    
  static let myVH = HorizontalAlignment(MyHalfHeight.self)
}

let frameWidth:CGFloat = 128
let frameHeight: CGFloat = 128

var vframeWidth: CGFloat = 128
var vframeHeight: CGFloat = 128


struct gView: View {
    @State var horizonalB = HorizontalAlignment.myHorizontalAlignment
    @State var verticalB = VerticalAlignment.myVerticalAlignment
    
    @State var horizonalA = HorizontalAlignment.mybHorizontalAlignment
    @State var verticalA = VerticalAlignment.mybVerticalAlignment
    
    @State var zoom:CGFloat = 1.0
    var body: some View {
        ZStack() {
            ZStack() {
                Image(systemName: "plus")
                .frame(width: 128, height: 128, alignment: .center)
//                .alignmentGuide(.myHorizontalAlignment, computeValue: {d in d[HorizontalAlignment.center]})
//                .alignmentGuide(.myVerticalAlignment, computeValue: {d in d[VerticalAlignment.center]})
            }.frame(width: frameWidth, height: frameHeight, alignment: .myAlignment)
            .border(Color.blue)
            
            ZStack() {
            
            ZStack() {
                Image(systemName: "triangle")
                  .frame(width: frameWidth * 2, height: frameHeight * 2, alignment: .bottomTrailing)
                  .border(Color.green)
                  .foregroundColor(Color.green)
                  .scaleEffect(zoom, anchor: .center)
//                    .alignmentGuide(.myHorizontalAlignment, computeValue: {d in d[.leading]})
//                    .alignmentGuide(.myVerticalAlignment, computeValue: {d in d[.top]})
                    // center
//                    .alignmentGuide(.myHorizontalAlignment, computeValue: {d in -128 + (d.width / 2)})
//                    .alignmentGuide(.myVerticalAlignment, computeValue: {d in -128 + (d.height / 2)})
                    // top left
//                    .alignmentGuide(.myHorizontalAlignment, computeValue: {d in 0})
//                    .alignmentGuide(.myVerticalAlignment, computeValue: {d in 0})
                    // animated
                  .alignmentGuide(.myHorizontalAlignment, computeValue: {d in d[self.horizonalA]})
                  .alignmentGuide(.myVerticalAlignment, computeValue: {d in d[self.verticalA]})
//                  wrong, wrong, wrong
//                    .alignmentGuide(.myHorizontalAlignment, computeValue: {d in d[HorizontalAlignment.center]})
//                    .alignmentGuide(.myVerticalAlignment, computeValue: {d in d[VerticalAlignment.center]})
//                  .onAppear( perform: {
                    .onTapGesture {
                        withAnimation(.linear(duration: 4)) {
//                          self.horizonalA = HorizontalAlignment.center
//                          self.verticalA = VerticalAlignment.center
                            self.horizonalA = HorizontalAlignment.myVH
                            self.verticalA = VerticalAlignment.myVA
//                            self.zoom = 2.0
                        }
                        
                    }
            }.frame(width: frameWidth, height: frameHeight, alignment: .myAlignment)
             .border(Color.red)
             
//             ZStack() {
//              Image(systemName: "circle")
//                      .frame(width: 128, height: 128, alignment: .center)
//                      .border(Color.yellow)
//                      .foregroundColor(Color.purple)
////                      .scaleEffect(zoom, anchor: .center)
//                      .alignmentGuide(.myHorizontalAlignment, computeValue: {d in d[HorizontalAlignment.mybHorizontalAlignment]})
//                      .alignmentGuide(.myVerticalAlignment, computeValue: {d in d[VerticalAlignment.mybVerticalAlignment]})
////                      .alignmentGuide(.myHorizontalAlignment, computeValue: {d in d[self.horizonalB]})
////                      .alignmentGuide(.myVerticalAlignment, computeValue: {d in d[self.verticalB]})
//            }.frame(width: frameWidth, height: frameHeight, alignment: .myAlignment)
//             .scaleEffect(self.zoom, anchor: .center)
          }
        }
    }
}

struct SwiftUIViewC_Previews: PreviewProvider {
    static var previews: some View {
        fView()
    }
}
