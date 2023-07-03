//
//  Data.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/20/23.
//

import SwiftUI
import CoreData

//public class CategoryRow: NSManagedObject {
  //  @NSManaged public var catRashSumm: Bool
//}



// var dataStrEx7: String = ""
/*

var dataStrCatAndSumm: String = ""
var dataInt: String = ""
var dataIntEx: Int = 0
var dataStrCat: String = ""
var dInt: Int16 = 0

var dataStrEx3: String = ""

var dataIntEx2: Int = 0

var summAll: Int32 = 0

var allSumm: Int32 = 0

var summA:Int = 0

var togglePlusMinus: Bool = false

struct Data {
    

    @State var dataStrEx: String = ""

        //@Binding  var trigerAddItem: Bool
    
    
        //   @State private var mCat: [String] = [""]
    
        //  @Environment(\.scenePhase) var scenePhase
        //  @Environment(\.managedObjectContext) private var viewContext
    
    
    
    func calcint(_ c: Int) -> Int  {
        dataIntEx2 = c
        dataStrEx3 = String(dataIntEx2)
        print (dataStrEx3)
        
        return dataIntEx
    }
    
    
    
    
        // составляем число для вывода на экран
    func calcstr(_ x:String) -> String {
        
        if x == "enter" {
                // dataStrEx = "записано"
            dataStrEx = ""
        }
        
        else if x == "<" {
            if dataStrEx.count >= 1 {
                dataStrEx.removeLast(1)
            }
        }
        
        else if x == "C" {
            dataStrEx = ""
        }
        
        else if x == "=" {
            dataStrEx +=  x
            dataStrEx = calkul(dataStrEx)
            
        }
        else if x == "+" {
            dataStrEx +=  x
            
            /*
             if togglePlusMinus == true {
             summA = Int(dataStrEx)!
             dataStrEx = ""
             togglePlusMinus = true
             }
             else {
             summA += Int(dataStrEx)!
             
             }
             */
        }
        
        else if x == "-" {
                // формула подсчета при вычитании
                //calkul (dataStrEx)
            dataStrEx +=  x
        }
        else {
            dataStrEx +=  x
                //	dataStrEx +=  "555"
            
            
            
        }
        
            //	print(dataStrEx)
            //	MainView().clearDataStrEx()
        return dataStrEx
    }
    
    
    func calkul2 (_ treb:String) -> String {
        let rega = "LKJHL" + treb
        return rega
    }
    
    
        // захватываем сумму с экрана и записываем в категорию трат
        // проверить действие этой функции
    func calcShop(_ x:String) ->  String {
            //если сумма на экране 0, то ничего не вводим
        if dataStrEx != ""  {
            dataStrCat = x // "добавили" // "- \(mCat[x]) \(dataStrEx)"
            
            for ttt in dataStrEx {
                if ttt == "+" || ttt == "-" {
                    print ("нали + или -")
                    dataStrEx += "="
                    dataStrEx =	calkul(dataStrEx)
                }
            }
            
            dataInt = dataStrEx
            
        }
        else if dataStrEx == "" {
        }
        
        else if dataInt == dataStrEx { // при той же сумме можно заменить категорю товара – сейчас не работает
            dataStrCat = "добавили2" // \(mCat[x]) -  [\(dataStrEx)] "
        }
        
            //	else if dataStrEx == "0" {
            //	}
        
        else{
            
        }
            //  dInt = Int16(dataStrEx)!
            //  addItem2(dInt)
            // dataStrCat =
        dataStrEx = ""
        
        
        
        print ("dataStrCat")
        print (dataStrCat)
        return dataStrCat
        
    }
    
    
    
    
    struct CategorySumm {
        
        
            //   @Environment(\.managedObjectContext) private var viewContext
            // подтягивание данных из файла
            //   @FetchRequest(
            //      sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestampData, ascending: false)], animation: .default)
        
            //@FetchRequest(
            //  sortDescriptors: [NSSortDescriptor(keyPath: \Category.catID , ascending: true)], animation: .default)
            // @ObservedObject var items: Item
        
            //  private var items: FetchedResults<Item>
        
        
            //  var total = items.summData.reduce(0, +)
        
            //   var allSumm: Int = 0
            //    func allSummfunc() -> Int {
        
            //       ForEach(items, id:\.self) { item in
            // let   allSumm = item.summData
            //          print (item.summData)
            //       }
            //        return allSumm
        
            //   }
        
    }
    
    
        // MARK: переписать переменные??
    func calkul (_ aaa:String) -> String{
        print ( "RUN: calkul")
        var a:String = ""
        print (aaa)
        
        var aInt = 0
        var bInt = 0
        var cInt = 0
        var znak: String = "nil"
        var trigger: Bool = false
        
        let yyy = aaa.count
        if aaa == "=" && yyy == 1 {
            
        }
        
        
        for eee in aaa {
            
            
            if (eee != "+" && eee != "-" && eee != "=")  {
                a += String(eee)
                aInt = Int(a)!
            }
            
            if (eee == "+" && trigger == true) || (eee == "-" && trigger == true) {
                countEquals ()
            }
            
            if eee == "+" {
                znak = "+"
                bInt = aInt
                a = ""
                trigger = true
            }
            
            else if eee == "-" {
                znak = "-"
                a = ""
                bInt = aInt
                trigger = true
                
            }
            
            if eee == "="  {
                countEquals ()
            }
            
            
            
            func countEquals () {
                if cInt != 0 {
                    bInt = cInt
                }
                else if  cInt == 0 {
                    cInt = aInt
                }
                else  {
                    cInt = aInt
                }
                a = ""
                
                if znak == "+" { cInt = bInt + aInt }
                if znak == "-" { cInt = bInt - aInt }
                if znak == "=" {
                    
                    
                }
                znak = "nil"
                trigger = false
            }
            print (cInt)
        }
        return  String(cInt)
    }
    
    
    
    
    
    
    
}

*/
