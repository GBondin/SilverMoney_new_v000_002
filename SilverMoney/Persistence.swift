//
//  Persistence.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/19/23.
//


import SwiftUI
import Foundation
import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // запись первой строки – инициализация для превью
            
		let newItemServ = Item(context: viewContext)
				newItemServ.categoryItemID = 999999
				newItemServ.summData = 0
		newItemServ.timeStampData = Date()

		/*
		let newItem = Item(context: viewContext)
		
		newItem.categoryItemID = 4
		newItem.timeStampData = Date()
		newItem.noteSummData = "info"
		newItem.mCatsData = "пример"
		newItem.summData = 40
		
		*/
		
			// инициализация начальных данных служебных (зарезервированных) категорий для превью

		
		let mCatInitServ: [String] = ["service category 001", "service category 002","service category 003","service category 004","service category 005","service category 006","service category 007","service category 008","service category 009","service category 010",]

		var mCatIndServ: Int16 = -10
		for mCats in mCatInitServ {
		let newCategory = Category(context: viewContext)
		newCategory.catShop = mCats
		newCategory.categoryID = mCatIndServ
		newCategory.categoryItemID = mCatIndServ
		newCategory.catUUID = UUID()
		newCategory.catNote = ""
		newCategory.onRemove = false
		newCategory.catRashSumm = true  // учитывать в общих расходах
		mCatIndServ += 1
		}
			
        // инициализация начальных данных Нулевой категории для превью – будет использоваться для добавления новой категории прямо из списка категорий
        let mCatZerro: [String] = ["Добавить новую категорию"] // нулевая категория, будет всегда добавляться в конец всех категорий N категории 0
        let newZeroCategory = Category(context: viewContext)
        newZeroCategory.catShop = mCatZerro[0]
        newZeroCategory.categoryID = 0
        newZeroCategory.categoryItemID = 0
        newZeroCategory.catUUID = UUID()
        newZeroCategory.catNote = ""
        newZeroCategory.onRemove = false
        newZeroCategory.categoryPriority = 0.0
        newZeroCategory.catRashSumm = true  // учитывать в общих расходах
        
        
        
        // инициализация начальных данных категорий для превью
        
        let mCatInit: [String] = ["Продукты", "Товары", "Услуги", "Рестораны", "Развлечения", "Комм. платежи", "Здоровье", "Погашение кредита", "Другое"] //определюсь позже
        
        var mCatInd: Int16 = 1
        for mCats in mCatInit {
            let newCategory = Category(context: viewContext)
            newCategory.catShop = mCats
            newCategory.categoryID = mCatInd
            newCategory.categoryItemID = mCatInd
            newCategory.catUUID = UUID()
            newCategory.catNote = ""
            newCategory.onRemove = false
            newCategory.categoryPriority = 5.0
            newCategory.catRashSumm = true  // учитывать в общих расходах
            
            mCatInd += 1
        }

            try? viewContext.save()
   
          
        return result
}()


     



    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SilverMoney")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
       
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
}



