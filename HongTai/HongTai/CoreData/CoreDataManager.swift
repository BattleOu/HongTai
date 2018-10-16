//
//  CoreDataManager.swift
//  HongTai
//
//  Created by wqy on 2018/10/12.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager: NSObject {
//  static let shared = CoreDataManager()
//
//
//    lazy var context: NSManagedObjectContext = {
//        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
//        return context
//    }()
//
//    // 更新数据
//    private func saveContext() {
//        do {
//            try context.save()
//        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//    }
//
//
//    // 增加数据
//    func savePersonWith(userid: String, username: String, userpassword: String, userrelaname: String, birthday: String, userimage: Data) {
//        let User = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
//        User.userid = userid
//        User.username = username
//        User.userpassword = userpassword
//        User.birthday = birthday
//        User.userimage = userimage
//        saveContext()
//    }
//
//
//    // 根据编号获取数据
//    func getPersonWith(userid: String) -> [User] {
//        let fetchRequest: NSFetchRequest = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "userid == %@", userid)
//        do {
//            let result: [User] = try context.fetch(fetchRequest)
//            return result
//        } catch {
//            fatalError();
//        }
//    }
//
//
//    func getPerwith(username: String) -> [User] {
//        let fetchRequest: NSFetchRequest = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
//        do {
//            let result: [User] = try context.fetch(fetchRequest)
//            return result
//        } catch {
//            fatalError();
//        }
//    }
//
//
//    func getAllPerson() -> [User] {
//        let fetchRequest: NSFetchRequest = User.fetchRequest()
//        do {
//            let result = try context.fetch(fetchRequest)
//            return result
//        } catch {
//            fatalError();
//        }
//    }
//
//    // 根据编号修改数据
//    func changePersonWith(userid: String, newusername: String, newuserpassword: String, newuserrelaname: String, newbirthday: String, newuserimage: Data) {
//        let fetchRequest: NSFetchRequest = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "userid == %@", userid)
//        do {
//            let result = try context.fetch(fetchRequest)
//            for user in result {
//                user.username = newusername
//                user.userpassword = newuserpassword
//                user.userrelaname = newuserrelaname
//                user.birthday = newuserrelaname
//                user.userimage = newuserimage
//            }
//        } catch {
//            fatalError();
//        }
//        saveContext()
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    // 根据编号删除数据
//    func deleteWith(userid: String) {
//        let fetchRequest: NSFetchRequest = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "userid == %@", userid)
//        do {
//            let result = try context.fetch(fetchRequest)
//            for user in result {
//                context.delete(user)
//            }
//        } catch {
//            fatalError();
//        }
//        saveContext()
//    }
//
//    // 删除所有数据
//    func deleteAllPerson() {
//        let result = getAllPerson()
//        for user in result {
//            context.delete(user)
//        }
//        saveContext()
//    }

}
