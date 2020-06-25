//
//  ContentView.swift
//  LayoutDemo
//
//  Created by localadmin on 17.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

extension VerticalAlignment {
    private enum MyAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    static let myAlignment = VerticalAlignment(MyAlignment.self)
}

struct aCustomView: View {
    @State private var selectedIdx = 1
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
            HStack(alignment: .myAlignment) {
                Image(systemName: "arrow.right.circle.fill")
                    .alignmentGuide(.myAlignment, computeValue: { d in d[VerticalAlignment.center] })
                    .foregroundColor(.green)

                VStack(alignment: .leading) {
                    ForEach(days.indices, id: \.self) { idx in
                        Group {
                            if idx == self.selectedIdx {
                                Text(self.days[idx])
                                    .transition(AnyTransition.identity)
                                    .alignmentGuide(.myAlignment, computeValue: { d in d[VerticalAlignment.center] })
                            } else {
                                Text(self.days[idx])
                                    .transition(AnyTransition.identity)
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedIdx = idx
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .padding(20)
            .font(.largeTitle)
    }
}

struct ContentView: View {
  var body: some View {
//    hView()
//    kView()
//    mView() Looks Good, issue with center
//    nView()
    oView() // Looks Better, WIP
  }
}

var linkingVariable = HorizontalAlignment.leading

struct fView: View {
  @State var variable:CGFloat = 0
  var body: some View {
    ZStack {
      VStack(alignment: linkingVariable) {
        LabelView(variable: $variable)
        .alignmentGuide(linkingVariable, computeValue: { _ in self.variable })
//          .alignmentGuide(linkingVariable, computeValue: { d in d[.leading] })

  // this I don0t understand yet
//          .alignmentGuide(.leading) { $0[explicit: .leading]! }
//        Rectangle()
//        .fill(Color.blue)
//        .frame(width: 300, height: 32)
        Text("\(self.variable)")
      }.frame(width: 300, height: 32, alignment: .center)
      .border(Color.red)
      
    }
  }
}

struct LabelView: View {
  @Binding var variable: CGFloat
  var body: some View {
      Image(systemName: "triangle")
        .frame(width: 32, height: 32)
        .background(Color.yellow)
        .border(Color.black)
        .onTapGesture {
          self.variable += 10
        }
        .onLongPressGesture {
          self.variable -= 10
        }
  }
}

//extension VerticalAlignment {
//    private enum MyVerticalAlignment : AlignmentID {
//        static func defaultValue(in d: ViewDimensions) -> CGFloat {
//            return d[.top]
//        }
//    }
//
//    static let myVerticalAlignment = VerticalAlignment(MyVerticalAlignment.self)
//}
//
//extension HorizontalAlignment {
//    private enum MyHorizontalAlignment : AlignmentID {
//        static func defaultValue(in d: ViewDimensions) -> CGFloat {
//            return d[.leading]
//        }
//    }
//
//    static let myHorizontalAlignment = HorizontalAlignment(MyHorizontalAlignment.self)
//}
//
//extension Alignment {
//    static let myAlignment = Alignment(horizontal: .myHorizontalAlignment, vertical: .myVerticalAlignment)
//}



struct eView: View {
// does nothing
   @State var variable: CGFloat = 0
    var body: some View {
        ZStack(alignment: .myAlignment) {
          HStack {
            Image(systemName: "plus")
              .frame(width: 145, height: 145, alignment: .center)
              .border(Color.red)
              .background(Color.yellow)
              .opacity(0.5)
              .onTapGesture {
                print("click ",self.variable)
                self.variable += 10
              }
              .alignmentGuide(.myAlignment, computeValue: { d in self.variable })
            Image(systemName: "minus")
              .frame(width: 145, height: 145, alignment: .center)
              .border(Color.green)
          }
          
          
          ZStack(alignment: .myAlignment) {
            Image(systemName: "circle")
              .frame(width: 145, height: 145, alignment: .center)
              .alignmentGuide(.myAlignment, computeValue: { d in d[VerticalAlignment.center] })
          }
        }
    }
}





var topRed: CGPoint!
var topOrange: CGPoint!
var cent: CGPoint!
var botGreen: CGPoint!
var botPurple: CGPoint!
var botPink: CGPoint!
var botYellow: CGPoint!

struct cView: View {
  @State var swap1: Bool = false
  @State var swap2: Bool = false
  @State var centerPoint: CGPoint = .zero
  @State var zoom:CGFloat = 1
  @State var ready: Bool = false
  var body: some View {
    
    ZStack(alignment: .center) {
      if ready {
        ZStack {
          ZStack {
            Image(systemName: "plus")
              .frame(width: 145, height: 145, alignment: .center)
              
              .background(Color.yellow)
              .border(Color.red)
              .onTapGesture {
                withAnimation(.linear(duration:2)) {
                  self.swap1 = true
//                    self.zoom = 2.0
                  }
            }
            .position(self.swap1 ? cent : topOrange)
            Image(systemName: "plus")
              .frame(width: 145, height: 145, alignment: .center)
              
              .background(Color.pink)
              .opacity(0.5)
              .border(Color.blue)
              .onTapGesture {
                withAnimation(.linear(duration:2)) {
                  self.swap2 = true
//                    self.zoom = 2.0
                  }
            }
            .position(self.swap2 ? cent : topRed)
          }.scaleEffect(zoom, anchor: .center)
        }
      }
      
      GeometryReader { geo in
        VStack(alignment: .center) {
          
          VStack {
            Spacer()
            HStack {
              Image(systemName: "circle")
                .frame(width: 64, height: 64, alignment: .center)
                .border(Color.orange)
                .background(GeometryReader { gp -> Color in
                  let rect = gp.frame(in: .named("OuterV"))
                  topOrange = returnCent(rect: rect)
                  return Color.clear
                }).padding(.trailing, 32)
              Image(systemName: "circle")
                .frame(width: 64, height: 64, alignment: .center)
                .border(Color.red)
                .background(GeometryReader { gp -> Color in
                  let rect = gp.frame(in: .named("OuterV"))
                  topRed = returnCent(rect: rect)
                  return Color.clear
                }).padding(.leading, 32)
            }.padding(.bottom, 64)
            
            Image(systemName: "circle")
              .frame(width: 128, height: 128, alignment: .center)
              .border(Color.blue)
              .background(GeometryReader { gp -> Color in
                let rect = gp.frame(in: .named("OuterV"))
                cent = returnCent(rect: rect)
                return Color.clear
              })
            
            HStack {
              Image(systemName: "circle")
                .frame(width: 64, height: 64, alignment: .center)
                .border(Color.green)
                .background(GeometryReader { gp -> Color in
                  let rect = gp.frame(in: .named("OuterV"))
                  botGreen = returnCent(rect: rect)
                  return Color.clear
                }).padding(.trailing, 32)
              Image(systemName: "circle")
                .frame(width: 64, height: 64, alignment: .center)
                .border(Color.purple)
                .background(GeometryReader { gp -> Color in
                  let rect = gp.frame(in: .named("OuterV"))
                  botPurple = returnCent(rect: rect)
                  return Color.clear
                }).padding(.leading, 32)
              
            }.padding(.top, 64)
            Spacer()
          }
        }
      }.coordinateSpace(name: "OuterV")
        .onAppear {
          self.ready = true
      }
      Image(systemName: "circle")
        .frame(width: 128, height: 128, alignment: .center)
        .border(Color.yellow)
        .position(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 140)
      
    }
  }
}



func returnCent(rect: CGRect) -> CGPoint {
  let halfWidth = (rect.width / 2)
  let halfheight = (rect.height / 2)
  let returnPoint = CGPoint(x: rect.origin.x + halfWidth, y: rect.origin.y + halfheight)
  return(returnPoint)
}

//struct InsideView: View {
//  @Binding var centerPoint: CGPoint
//  var body: some View {
//    GeometryReader { geo in
//    Image(systemName: "plus")
//      .background(Color.yellow)
//      .onAppear {
//        self.centerPoint = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
//      }
//    }
//  }
//}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

extension HorizontalAlignment {
    enum MadAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }

    static let madAccountAndName = HorizontalAlignment(MadAccountAndName.self)
}

struct bView: View {
  @State var zoom: CGFloat = 1.0
  @State var moveX: CGFloat = 0
  @State var moveY: CGFloat = 0
  @State var expand: CGFloat = 1
  @State var swap: Bool = false
  @State var alignX = VerticalAlignment.bottom
  @State var alignY = HorizontalAlignment.trailing
  var body: some View {
    ZStack() {
        VStack(alignment: alignY) {
        HStack(alignment: alignX) {
          Image(systemName: "sparkles")
            .alignmentGuide(.midAccountAndName, computeValue: { d in d[ HorizontalAlignment.leading ] })
            .alignmentGuide(.madAccountAndName, computeValue: { d in d[ VerticalAlignment.bottom ] })
            .frame(width: 128, height: 128, alignment: .bottom)
            .border(Color.black)
            .onTapGesture {
              self.swap.toggle()
              withAnimation(.linear(duration:4)) {
                print("SPG")
                self.alignX = VerticalAlignment.midAccountAndName
              }
            }
            .onLongPressGesture {
              withAnimation(.linear(duration:4)) {
                print("LPG")
                self.alignY = HorizontalAlignment.madAccountAndName
              }
            }
        }.scaleEffect(zoom, anchor: .leading)
        
        ZStack {
          Image(systemName: "plus")
            .frame(width: 128, height: 128, alignment: .top)
            .alignmentGuide(.midAccountAndName, computeValue: { d in d[ VerticalAlignment.top ] })
            .alignmentGuide(.madAccountAndName, computeValue: { d in d[ HorizontalAlignment.trailing ] })
            .border(Color.red)
        }
      }
    }
  }
}



struct aView: View {
    @State var zoom: CGFloat = 1.0
    
    var body: some View {
    ZStack {
//      ZStack {
      VStack(alignment: .trailing) {
        Spacer()
        Image(systemName: "sparkles")
            .frame(width: 64, height: 128, alignment: .trailing)
            .border(Color.black)
            .alignmentGuide(.trailing, computeValue: { d in d[ .trailing] })
            .onTapGesture {
              withAnimation(.linear(duration: 4)) {
                self.zoom = 4.0
              }
            }
        Spacer()
      }.scaleEffect(zoom)
      VStack(alignment: .leading) {
          Spacer()
          Image(systemName: "sparkles")
            .frame(width: 64, height: 64, alignment: .leading)
            .border(Color.black)
            .alignmentGuide(.leading, computeValue:  {d in d[.leading]})
          Spacer()
//        }
      }
//      ZStack {
        VStack(alignment: .trailing) {
          Spacer()
            Rectangle()
              .fill(Color.green)
              .frame(width: 64, height: 64, alignment: .center)
            Spacer()
            Rectangle()
              .fill(Color.green)
              .frame(width: 64, height: 64, alignment: .center)
            Spacer()
          }
//        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
