//
//  ListInstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct ListInstrumentsLayoutView: View {
    @State private var viewsList: [ViewItem] = [
        ViewItem(instrument: AnyView(BoatSpeedView()), isEnabled: true),
        ViewItem(instrument: AnyView(BoatHeadingView()), isEnabled: true),
        ViewItem(instrument: AnyView(WindSpeedView()), isEnabled: true),
        ViewItem(instrument: AnyView(WindDirectionView()), isEnabled: true),
        ViewItem(instrument: AnyView(ApparentWindSpeedView()), isEnabled: true),
        ViewItem(instrument: AnyView(ApparentWindAngleView()), isEnabled: true),
        ViewItem(instrument: AnyView(HeelAngleView()), isEnabled: true),
        ViewItem(instrument: AnyView(PitchAngleView()), isEnabled: true)
    ]
    @State private var isEditing = false  // State to track if the list is in edit mode

    var viewsEnabledCount: Int {
        print("viewsEnabledCount: \(viewsList.filter(\.isEnabled).count)")
        return max(4, viewsList.filter(\.isEnabled).count)
    }
    var body: some View {
        //NavigationView {
        GeometryReader { geometry in
                List {
                    ForEach($viewsList) { $item in
                        ZStack {
                            if item.isEnabled {
                                item.instrument
                                    .background(Color.clear)
                                    .frame(width: geometry.size.width, height: geometry.size.height/CGFloat(viewsEnabledCount))
                            }
                            if isEditing { // Show Toggle only when in edit mode
                                Toggle(isOn: $item.isEnabled){
                                    
                                }
                                //.labelsHidden()
                                .offset(x: geometry.size.width/4)
                                //.padding(.trailing)
                            }
                        }
                    }
                    .onMove(perform: move)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .swipe(
                    left: {
                        isEditing.toggle()
                    })
                .padding(0)
            }
        //}
        //.navigationTitle("Editable Views")
        //.navigationBarItems(trailing: EditButton())
    }
    private func move(from source: IndexSet, to destination: Int) {
        print("move: \(source) to \(destination)")
        viewsList.move(fromOffsets: source, toOffset: destination)
    }
}
         
 struct ViewItem: Identifiable {
     let id = UUID()
     var instrument: AnyView
     var isEnabled: Bool
 }

#Preview {
    struct Preview: View {
        var body: some View {
            ListInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
