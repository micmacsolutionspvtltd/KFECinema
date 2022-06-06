//
//  TermsAndConditionWebView.swift
//  KFECinemas
//
//  Created by MAC on 06/06/22.
//

import SwiftUI

struct TermsAndConditionWebView: View {
    @State var urlName :  String?
    var body: some View {
        Webview(url: URL(string : "http://202.83.31.153:8075/KFE_Android/terms.php")!)
    }
}

struct TermsAndConditionWebView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionWebView()
    }
}
