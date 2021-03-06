//
//  UIImageView+DownloadImage.swift
//  Cake List
//
//  Created by Suman Chatterjee on 07/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit

public extension UIImageView {
  @objc  func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            // Was the download cancelled?
            if let error = error as NSError?, error.code == -999 {
                return
            }

            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.image = image
                    }
                }
            }
        })
        downloadTask.resume()
        return downloadTask
    }
}
