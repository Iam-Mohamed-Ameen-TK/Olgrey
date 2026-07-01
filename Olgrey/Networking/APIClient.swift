//
//  APIClient.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation

// MARK: - HTTP Method

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
    case patch  = "PATCH"
}

// MARK: - API Error

enum APIError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case serverError(Int)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:       return "Invalid URL."
        case .noData:           return "No data received."
        case .decodingFailed:   return "Failed to decode response."
        case .serverError(let code): return "Server error with status code \(code)."
        case .unknown(let err): return err.localizedDescription
        }
    }
}

// MARK: - APIClient

final class APIClient {
    static let shared = APIClient()
    private let session: URLSession

    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        session = URLSession(configuration: config)
    }

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        body: Encodable? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        guard let requestURL = URL(string: url) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        if let body {
            request.httpBody = try? JSONEncoder().encode(body)
        }

        let (data, response) = try await session.data(for: request)

        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw APIError.serverError(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
