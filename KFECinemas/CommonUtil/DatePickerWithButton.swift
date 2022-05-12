//
//  DatePickerWithButton.swift
//  KFECinemas
//
//  Created by MAC on 28/04/22.
//

import SwiftUI


struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                if #available(iOS 14.0, *) {
                    DatePicker("Test", selection: $selectedDate, in: Date.now...(Calendar.current.date(byAdding: .day, value: 7, to: Date.now) ?? Date.now) , displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                } else {
                    DatePicker("Test", selection: $selectedDate , displayedComponents: [.date])
                    // Fallback on earlier versions
                }
                
                Divider()
                HStack {
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("Save".uppercased())
                            .bold()
                    })
                    
                }
                .padding(.horizontal)

            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )

            
        }

    }
}



struct DatePickerWithButtons_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerWithButtons(showDatePicker: .constant(false), savedDate: .constant(Date()))
    }
}

