//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by 최준영 on 2022/11/26.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        //make url
        guard let fileUrl = self.url(forResource: file, withExtension: nil) else {
            fatalError("file not found")
        }
        //url -> data
        guard let data = try? Data(contentsOf: fileUrl) else {
            fatalError("making data error")
        }
        //data -> swift instance
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("decoding Error")
        }
        return decoded
    }
}
