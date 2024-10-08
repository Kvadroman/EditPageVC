//
//  EditFileManager.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

protocol PEditFileManager {
    func saveImage(_ image: UIImage, withName name: String) -> URL?
    func loadImage(with URL: URL) -> UIImage?
}

final class EditFileManager: PEditFileManager {
    private typealias Strings = String.FileManager
    // MARK: - Properties
    private let fileManager = FileManager.default
    // MARK: - Interface
    func saveImage(_ image: UIImage, withName name: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentsURL.appendingPathComponent("\(name).jpg")
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print(Strings.savingError.localizedFormat(error.localizedDescription))
            return nil
        }
    }
    func loadImage(with URL: URL) -> UIImage? {
        let fileName = URL.deletingPathExtension().lastPathComponent
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentsURL.appendingPathComponent("\(fileName).jpg")
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print(Strings
                .loadingError
                .localizedFormat(fileURL.absoluteString, error.localizedDescription))
            return nil
        }
    }
}
