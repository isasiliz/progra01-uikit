//
//  ApiError.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 10/10/2024.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case internetConnectionError
    case unknownError
    case requestError(title: String, message: String)
    case emptyData
    case urlNotFound
    case timeout
}
