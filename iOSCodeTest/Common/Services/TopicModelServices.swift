//
//  TopicModelServices.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/16.
//

import UIKit
import Alamofire

typealias TopicListCompletionHandler = ([TopicModel]?) -> Void

class TopicModelService {
    static let shared = TopicModelService()

    private init() { }
}

extension TopicModelService {
    /// 서버로부터 네트워크 통신을 통하여 카테고리의 리스트를 받아오는 함수.
    func getTopicList(page: Int, completion: @escaping TopicListCompletionHandler) {
        let parameters: [String: String] = ["page": "\(page)", "client_id": Server.API_ACCESS_KEY]

        AF.request(Server.LIST_TOPIC_URL, method: .get, parameters: parameters).responseData { (responseData) in
            switch responseData.result {
            case .success(let resultData):
                do {
                    let topicModel = try [TopicModel].decode(data: resultData)
                    completion(topicModel)
                } catch let decodeError as NSError {
                    completion(nil)
                    print(decodeError.localizedDescription)
                }
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }
}
