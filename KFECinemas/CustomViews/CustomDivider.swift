//
//  CustomDivider.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 19/05/22.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle().fill(.gray).frame(maxWidth: .infinity, maxHeight: 1, alignment: .center).padding(.horizontal,10)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
