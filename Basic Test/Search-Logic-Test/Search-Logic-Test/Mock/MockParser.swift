//
//  MockParser.swift
//  Search-Logic-Test
//
//  Created by SHIN YOON AH on 2022/07/22.
//

import Foundation

final class MockParser {
    static func load<T: Decodable>(type: T.Type, fileName: String) -> T? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            assert(false, "json 파일로 변환 불가")
            return nil
        }
        let fileURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: fileURL) else {
            assert(false, "path 이상함")
            return nil
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            assert(false, "json serialization 불가")
            return nil
        }
        guard let decodable = try? JSONSerialization.data(withJSONObject: jsonObject) else { return nil }
        return try? JSONDecoder().decode(T.self, from: decodable)
    }
}
