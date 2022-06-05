//
//  RadioButton.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 19/05/22.
//

import SwiftUI


//MARK:- Single Radio Button Field
struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.white,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

//MARK:- Group of Radio Buttons
enum SnacksDeliveryType: String {
    case deliverAtSeat = "Deliver at Seat"
    case takeAway = "Takeaway"
}

enum SnacksDeliveryTimeType: String {
    case showBeginning = "Show Beginning"
    case interval = "Interval"
}

struct DeliveryButtonGroups: View {
    @State var selectedId: String = ""
    let callback: (String) -> ()
    
   
    
    var body: some View {
        HStack {
            deliverAtSeatView
            takeAwayView
        }
    }
    
    var deliverAtSeatView: some View {
        RadioButtonField(
            id: SnacksDeliveryType.deliverAtSeat.rawValue,
            label: SnacksDeliveryType.deliverAtSeat.rawValue,
            isMarked: selectedId == SnacksDeliveryType.deliverAtSeat.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var takeAwayView: some View {
        RadioButtonField(
            id: SnacksDeliveryType.takeAway.rawValue,
            label: SnacksDeliveryType.takeAway.rawValue,
            isMarked: selectedId == SnacksDeliveryType.takeAway.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}


struct DeliveryTimeGroups: View {
    @State var selectedId: String = ""
    let callback: (String) -> ()
    
    
    
    var body: some View {
        HStack {
            showBeginningView
            intervalView
        }
    }
    
    var showBeginningView: some View {
        RadioButtonField(
            id: SnacksDeliveryTimeType.showBeginning.rawValue,
            label: SnacksDeliveryTimeType.showBeginning.rawValue,
            isMarked: selectedId == SnacksDeliveryTimeType.showBeginning.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var intervalView: some View {
        RadioButtonField(
            id: SnacksDeliveryTimeType.interval.rawValue,
            label: SnacksDeliveryTimeType.interval.rawValue,
            isMarked: selectedId == SnacksDeliveryTimeType.interval.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}
