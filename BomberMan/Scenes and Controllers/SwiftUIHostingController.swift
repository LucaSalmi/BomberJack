//
//  SwiftUIHostingController.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-23.
//

import UIKit
import SwiftUI

struct MyView: View {
  var body: some View {
      NavigationView {
                  NavigationLink(
                      destination: ViewController(),
                      label: {
                          Text("Click me").foregroundColor(.white)
                          Image(systemName: "chevron.forward.2").imageScale(.large)}
                  )
              }
  }
}

struct ViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "gameViewController")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
       
    }
}

class SwiftUIHostingController: UIHostingController<MyView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: MyView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
