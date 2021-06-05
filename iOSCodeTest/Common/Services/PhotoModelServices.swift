//
//  PhotoModelServices.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/16.
//

import UIKit
import Alamofire
import AlamofireImage

typealias PhotoListCompletionHandler = ([PhotoModel]?) -> Void
typealias PhotoImageCompletionHandler = (Image?) -> Void

class PhotoModelService {
    static let shared = PhotoModelService()

    // 이미지 캐시를 위한 변수
    let imageCache = AutoPurgingImageCache(memoryCapacity: 256_000_000, preferredMemoryUsageAfterPurge: 128_000)

    private init() { }
}

extension PhotoModelService {
    /// 서버로부터 네트워크 통신을 통하여 사진 리스트를 받아오는 함수.
    func getPhotoList(page: Int, topicId: String? = nil, completion: @escaping PhotoListCompletionHandler) {
        let parameters: [String: String] = ["page": "\(page)", "client_id": Server.API_ACCESS_KEY]

        // 조회 대상 Topic이 존재하는 경우
        if let topicId = topicId {
            let urlByTopic = Server.LIST_TOPIC_URL + "/\(topicId)/photos"
            AF.request(urlByTopic, method: .get, parameters: parameters).responseData { (responseData) in
                switch responseData.result {
                case .success(let resultData):
                    do {
                        let photoModel = try [PhotoModel].decode(data: resultData)

                        completion(photoModel)
                    } catch let decodeError as NSError {
                        completion(nil)
                        print(decodeError.localizedDescription)
                    }
                case .failure(let error):
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
        // 조회 대상 Topic이 존재하지 않는 경우
        } else {
            AF.request(Server.LIST_PHOTO_URL, method: .get, parameters: parameters).responseData { (responseData) in
                switch responseData.result {
                case .success(let resultData):
                    do {
                        let photoModel = try [PhotoModel].decode(data: resultData)
                        completion(photoModel)
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

    /// 서버로부터 사진 URL 정보를 통하여 실제 사진을 받아오는 함수.
    func loadPhotoImage(imageUrl: String, frameSize: CGSize, completion: @escaping PhotoImageCompletionHandler) {
        let devicePixelRatio = Int(UIScreen.main.scale)
        let parameters: [String: String] = ["w": "\(Int(frameSize.width))"
                                            , "dpr": "\(devicePixelRatio)"
                                            , "fm": "jpg"
                                            , "fit": "max"
                                            , "q": "80"]

        AF.request(imageUrl, parameters: parameters).responseImage { (response) in
            switch response.result {
            case .success(let image):

                self.imageCache.add(image, withIdentifier: imageUrl)
                completion(image)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }

    /// 검색어를 통하여 검색어에 해당하는 사진 리스트를 받아오는 함수.
    func searchPhoto(page: Int, searchText: String, completion: @escaping PhotoListCompletionHandler) {
        let parameters: [String: String] = ["page": "\(page)", "query": "\(searchText)", "client_id": Server.API_ACCESS_KEY]

        AF.request(Server.SEARCH_PHOTO_URL, method: .get, parameters: parameters).responseData { (responseData) in
            switch responseData.result {
            case .success(let resultData):
                do {
                    let photoSearchResultModel = try PhotoSearchResultModel.decode(data: resultData)
                    completion(photoSearchResultModel.results)
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
