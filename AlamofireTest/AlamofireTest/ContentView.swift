//
//  ContentView.swift
//  AlamofireTest
//
//  Created by Haris Zaman on 1/4/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    try await executeRequestsInParallel()
                }
            }
    }
}

func executeRequestsInParallel() async throws {
    async let getValue = getRequest()
    async let postValue = postRequest()
    async let uploadValue = uploadRequest()
    
    let responses = try await (getValue, postValue, uploadValue)
    
    debugPrint("get request: \(responses.0.slideshow.title)")
    debugPrint("post request: \(responses.1)")
    debugPrint("upload request: \(responses.2.headers.contentLength)")
}

func uploadRequest() async throws -> PostResponse {
    let request = AF.upload(multipartFormData: { multipartData in
        multipartData.append("123".data(using: .utf8)!, withName: "Number1")
        multipartData.append("456".data(using: .utf8)!, withName: "Number2")
    }, to: postUrlString, method: .post)
    
    Task {
        for await progress in request.uploadProgress() {
            debugPrint(progress.fractionCompleted)
        }
    }
    
    let value = try await request.serializingDecodable(PostResponse.self).value
    return value
}

func postRequest() async throws -> String {
    let parameters = ["1": 1, "2": 2]
    return try await AF.request(postUrlString, method: .post, parameters: parameters, encoder: .json, headers: headers).serializingString().value
}

func getRequest() async throws -> Welcome {
    return try await AF.request(geturlString, method: .get, headers: headers).serializingDecodable(Welcome.self).value
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
