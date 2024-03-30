import Foundation

public extension String? {

    ///  is true if value of string is empty or nil, flase otherwise
    var isNilOrEmpty: Bool { self?.isEmpty ?? true }

    /// returns an empty string if the value is nil, retruns unwrapped value otherwise
    var orEmpty: String { self ?? "" }
}

public extension String {

    /// true if is string is valid URL, false otherwise
    var isValidURL: Bool {
        if #available(iOS 17.0, macOS 14.0, *) {
            URL(string: self, encodingInvalidCharacters: false) != nil
        } else {
            URL(string: self) != nil
        }
    }

    /// Adds percent encoded query parameters to the end of the strings value
    ///
    ///  ```swift
    ///  let basePath = "/home"
    ///  let fullPath = path.addQueryParams(params: ["alertMessage": "Pizza is here!🍕"])
    ///  print(fullPath) // should print "/home?alertMessage=Pizza%20is%20here%21%F0%9F%8D%95"
    ///
    ///  ```
    /// - Parameter params: Dictionary of values to be added as query parameters
    /// - Returns: the current string with the queryparams
    func addQueryParams(params: [String: String]) -> String? {
        var url = URLComponents(string: self)
        url?.queryItems = params.compactMap({URLQueryItem(name: $0, value: $1)})
        guard let completeUrl = url?.url?.absoluteString else { return nil }
        return completeUrl
    }

    /// Returns current value with out the query parameters if there are any
    ///
    ///  ```swift
    ///  let fullPath = "/home?alertMessage=Pizza%20is%20here%21%F0%9F%8D%95"
    ///  let basePath = fullPath.removeQueryParams()
    ///  print(basePath) // should print "/home"
    ///  ```
    /// - Returns: the base string with out the query parameters
    func removeQueryParams() -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        return url.path
    }

    /// Returns the query params if present or an empty dictionary
    ///
    /// ```swift
    /// let fullpath = "/home?param=value"
    /// print(fullpath.getQueryParams()) // should print "[param: value]"
    ///
    /// ```
    ///
    /// - Returns: dictionary of query params if there are any
    func getQueryParams() -> [String: String] {
        guard let selfURL = URLComponents(string: self) else { return [: ] }
        var params = [String: String]()
        selfURL.queryItems?.forEach({ params[$0.name] = $0.value })
        return params
    }

}
