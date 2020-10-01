//
//  Networking.swift
//  GeekWeather
//
//  Created by Mad Brains on 06.07.2020.
//  Copyright © 2020 GeekTest. All rights reserved.
//

import Foundation

protocol Networking {

  /// Fetch data from url and parameters query
  ///
  /// - Parameters:
  ///   - url: The url
  ///   - parameters: Parameters as query items
  ///   - completion: Called when operation finishes
  /// - Returns: The data task
  @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask?
}
