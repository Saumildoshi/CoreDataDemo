//
//  CoreDataManager.swift
//  DemoCore
//
//  Created by Saumil on 23/07/24.
//

import UIKit
import CoreData


class CoreDataManager {
    
    static var shared = CoreDataManager()
    let managedContext = CoreDataStack.shared.context
    
    func saveData(user: UserModal) {
        let studentData = Student(context: managedContext) // user creation
        studentData.name = user.name
        studentData.address = user.address
        studentData.city = user.city
        studentData.mobile = user.mobile
        studentData.imgName = user.image
        try? managedContext.save()
    }
    
    func fetchUserData() -> [Student] {
        var users: [Student] = []
        do {
            users = try managedContext.fetch(Student.fetchRequest())
        } catch {
            print("founf error")
        }
        return users
    }
    
    func updateUserData(user: UserModal,userEntity: Student) {
        userEntity.name = user.name
        userEntity.address = user.address
        userEntity.city = user.city
        userEntity.mobile = user.mobile
        userEntity.imgName = user.image
        try? managedContext.save()
    }
    
    func deleteUser(userEntity: Student) {
        //CoreDataManager.shared.removeImageFromDocumentsDirectory(fileName: userEntity.imgName ?? "")
        managedContext.delete(userEntity)
        try? managedContext.save()
    }
    
    func removeImageFromDocumentsDirectory(fileName: String) -> Bool {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Image removed from \(fileURL)")
            return true
        } catch {
            print("Failed to remove image: \(error)")
            return false
        }
    }
    
    func loadImageFromDocumentsDirectory(fileName: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Failed to load image: \(error)")
            return nil
        }
    }
    
    func saveImageToDocumentsDirectory(image: UIImage,fileName: String) {
        guard let data = image.pngData() else { return }
        let filename = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try data.write(to: filename)
            print("Image saved to \(filename)")
        } catch {
            print("Failed to save image: \(error)")
        }
    }
    
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
