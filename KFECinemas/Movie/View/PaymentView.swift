//
//  PaymentView.swift
//  KFECinemas
//
//  Created by MAC on 20/05/22.
//

import Foundation
import SwiftUI
import Razorpay

struct PaymentView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CheckoutViewController {
        .init()
    }

    func updateUIViewController(_ uiViewController: CheckoutViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, RazorpayPaymentCompletionProtocol {
        let parent: PaymentView
        
        typealias Razorpay = RazorpayCheckout
        var razorpay: RazorpayCheckout!
        
        init(_ parent: PaymentView) {
            self.parent = parent
            super.init()
            razorpay =  RazorpayCheckout.initWithKey("rzp_test_F0OI03VaPbNCHU", andDelegate: self)
            //rzp_test_F0OI03VaPbNCHU     rzp_live_vq8tmnnZmbWVkx
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                let options: [String:Any] = [
                            "amount": "100000", //This is in currency subunits. 100 = 100 paise= INR 1.
                            "currency": "INR",//We support more that 92 international currencies.
                            "description": "purchase description",
                            "image": "https://url-to-image.png",
                            "name": "business or product name",
                            "prefill": [
                                "contact": "9797979797",
                                "email": "foo@bar.com"
                            ],
                            "theme": [
                                "color": "#F37254"
                            ]
                        ]
                self.razorpay.open(options)
//                if let rzp = self.razorpay {
//                    rzp.open(options)
//                } else {
//                    print("Unable to initialize")
//                }// your code here
            }
            
        }
        
        func onPaymentError(_ code: Int32, description str: String) {
              print("error: ", code, str)
           //   self.presentAlert(withTitle: "Alert", message: str)
            // parent.alert with message
          }

          func onPaymentSuccess(_ payment_id: String) {
              print("success:view ", payment_id)
           //   self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
          }
    }
}

class CheckoutViewController: UIViewController {
    
    var razorpay: RazorpayCheckout!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  razorpay = RazorpayCheckout.initWithKey("rzp_test_F0OI03VaPbNCHU", andDelegate: self)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
           //     self.showPaymentForm()
        }

    
//    internal func showPaymentForm(){
//        let options: [String:Any] = [
//                    "amount": "100000", //This is in currency subunits. 100 = 100 paise= INR 1.
//                    "currency": "INR",//We support more that 92 international currencies.
//                    "description": "purchase description",
//                    "image": "https://url-to-image.png",
//                    "name": "business or product name",
//                    "prefill": [
//                        "contact": "9797979797",
//                        "email": "foo@bar.com"
//                    ],
//                    "theme": [
//                        "color": "#F37254"
//                    ]
//                ]
//        razorpay.open(options)
//    }
}

extension CheckoutViewController : RazorpayPaymentCompletionProtocol {

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
//        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success:viewcontroller ", payment_id)
//        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}


