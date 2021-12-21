//
//  ContentView.swift
//  MachPortDemoApp
//
//  Created by Sei Takayuki on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Text("Hello, world!")
                .padding()
        
            Text("Hello, world!")
                .padding()
        }
        .onAppear {
                viewModel.onAppear()
        }
    }
}

class ContentViewModel: NSObject, ObservableObject {
    private let server: Server!
    override init() {
        server = Server()
        super.init()
        server.delegate = self
    }
    
    func onAppear() {
        server.run()
    }
}

extension ContentViewModel: ServerDelegate {
    func server(_ server: Server, receive message: PortMessage) {
        switch message.msgid {
        case 1:
            let string = String(data: message.components![0] as! Data, encoding: .utf8)!
            let responsString = "\(string) というメッセージを受信したよ"
            print(responsString)
            let response = PortMessage(send: message.sendPort,
                                       receive: nil,
                                       components: [responsString.data(using: .utf8)])
            response.msgid = message.msgid
            let timeout = Date(timeIntervalSinceNow: 1.0)
            response.send(before: timeout)
        default: break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
