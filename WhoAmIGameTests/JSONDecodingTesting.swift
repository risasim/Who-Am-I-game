//
//  JSONTesting.swift
//  WhoAmIGameTests
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Testing
import Foundation
@testable import WhoAmIGame

struct JSONDecodingTesting {

    @Test func decodeJSON() async throws {
        let jsonData = JSON.data(using: .utf8)!
        let packs:PocketBasePacks = try JSONDecoder().decode(PocketBasePacks.self, from: jsonData)
        #expect(packs.items.first?.questions.count == 2)
        #expect(packs.items.first?.expand.questions.first?.question == "Prague")
    }
    
    let JSON = """
    {
      "items": [
        {
          "author": "",
          "collectionId": "pbc_1924718284",
          "collectionName": "packs",
          "created": "2025-01-02 12:45:57.782Z",
          "expand": {
            "questions": [
              {
                "question": "Prague"
              },
              {
                "question": "Berlin"
              }
            ]
          },
          "id": "7wz80s0893hu6cq",
          "imageString": "hello",
          "name": "Cities",
          "questions": [
            "w98twr5ii21n857",
            "78v29db834gp6hs"
          ],
          "updated": "2025-01-02 12:46:30.346Z"
        }
      ],
      "page": 1,
      "perPage": 30,
      "totalItems": 1,
      "totalPages": 1
    }
    """

}
