//
//  ReadOperator.swift
//  UIStage
//
//  Created by Рустем on 08.03.2024.
//

import UIKit

struct ReadOperator {

    init(decoder: JSONDecoder = JSONDecoder()) {
        decoder.dateDecodingStrategy = .secondsSince1970
        self.decoder = decoder
    }

    private let decoder: JSONDecoder

    func readListFromJSON<T: Codable>(_ file: String) throws -> [T] {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            throw ReadErrors.pathError
        }
        if let data = FileManager.default.contents(atPath: path) {
            do {
                let list = try decoder.decode([T].self, from: data)
                return list
            } catch {
                throw ReadErrors.decodeError(error: error)
            }
        } else {
            throw ReadErrors.dataError
        }
    }
}

private enum ReadErrors: Error {

    case pathError
    case dataError
    case decodeError(error: Error)

    var errorMessage: String {
        switch self {
        case .pathError:
            return "wrong Path"
        case .dataError:
            return "wrond data"
        case .decodeError(let error):
            return "decode error \(error)"
        }
    }

}
