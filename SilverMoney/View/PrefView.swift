//
//  PrefView.swift
//  CoreDta_v03
//
//  Created by George Bondin on 1/22/23.
//

import SwiftUI

struct PrefView: View {

    var body: some View {
        Text("временный перенос из CategView")
		
		Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
		
		
    }
}
struct PrefView_Previews: PreviewProvider {
    static var previews: some View {
        PrefView()
    }
}





//  временный перенос из CategView


/*



 struct CategView: View {
		 // разобраться – см блокнот
		 //  @Environment(\.dismiss) var dismiss
	 @Environment(\.managedObjectContext) private var viewContext
	 @Environment(\.refresh) private var refresh

	 
	 @AppStorage("starterCategory") var starterCategory: Bool = false
	 @AppStorage("periodRaschetText") var periodRaschetText: String = "1 день"
		 // @AppStorage("periodRaschet") var periodRaschet: Double = -30.0
		 //  @State var periodRaschet: Double = -30.0
	 
	 @State var dataTemp: String = ""
	 
		 // подтягивание данных из файла
	 @FetchRequest(
		 sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryID , ascending: true)],
		 predicate: NSPredicate(format: "categoryItemID >= 0" ),
		 animation: .default)
  var category: FetchedResults<Category>
	 
	 
	 @FetchRequest(
		 sortDescriptors: [NSSortDescriptor(keyPath: \Item.summData , ascending: true)],
	 predicate: NSPredicate(format: "categoryItemID >= 0" ),
 //  predicate: NSPredicate(format: "categoryItemID == 1" ),
	 animation: .default)
	 private var items: FetchedResults<Item>
	 
	 
	 
	 let periodRaschetM = ["1 день", "1 неделя", "2 недели", "1 месяц", "1 год", "С 1 числа текущего месяца", "С 1 января текущего года" ]
	 
		 //   var predicateReka = NSPredicate()
		 //@State var showCheckSumm: Bool = true
	 
		 //   var tempCat = Set<Int>()
		 //   var initCategory: Bool?
		 //    @State    var bbb: Bool = true
		 //    @State var showCheckSumm: Bool = true
		 //  var stIntCategory: Bool = false
		 // записывает начальные категории при запуске
	 
	 
	 
	 

	 
	

	 var body: some View {
		 
			 VStack {
				 Text("НАСТРОЙКИ")
					 .font(.title)
					 .fontWeight(.thin)
					 .frame(width: 320.0, height: 30.0, alignment: .leading)
				 //	.padding(.leading, 5.0)
				 Divider()

 // Label("Категории", systemImage: "42.circle")
			   
				 NavigationView {
					 VStack {
						 List {
							 
							 Text("КАТЕГОРИИ РАСХОДОВ")
								 //   .font(.headline)
								 // для OC 16                      .fontWeight(.light)
								 //  .multilineTextAlignment(.leading)
								 .foregroundColor(.green)
							 
							 
								 //  .position(x:155,y:20)
							 ForEach(category, id:\.self) { categoryIndex in
								 CategoryRow(category: categoryIndex)
					 //	.task{ print ("категори индекс", categoryIndex) }
								 
								 //
									 
									 .contextMenu {
										 
										 Button(action: {
										 //	deleteItems2(offsets: IndexSet)	// delete the selected restaurant
										 }) {
											 HStack {
												 Text("Delete")
												 Image(systemName: "trash")
											 }
										 }}

							 }
						 .onDelete(perform: deleteItems2)
							 
						 //	.onDelete(perform: removeCategory(offsets: IndexSet))
						 //	.task {removeCategory(offsets: IndexSet) }
							 Text("ПЕРИОД ПОДСЧЕТА РАСХОДОВ")
								 .padding(.top, 30)
								 .font(.headline)
 // для OC 16                    .fontWeight(.light)
								 .multilineTextAlignment(.leading)
								 .foregroundColor(.green)

							 ForEach (periodRaschetM, id: \.self) {period in
								 
								 Button(period) {
									 periodRaschetText = period
								 }
								 .foregroundColor(periodRaschetText != period ? .gray : .blue)
								 
							 }
							 

							 
							 Text("удалить все данные")
								 .padding(.top, 30)
								 .font(.headline)
								 // для OC 16                                 .fontWeight(.light)
								 .multilineTextAlignment(.leading)
								 .foregroundColor(.black)
							 
						 }
					 }
				 }
				 .refreshable (){
					 addItemDefTemp()  // Разбираться отсюда!
				 }
				 .dynamicTypeSize(.xLarge)
				 .padding(.bottom, -10.0)

 // для OC 16          .scrollContentBackground(.hidden)

		 }
		 
			 .padding(.top, 25.0)
			 .padding(.bottom, 20.0)
	 }

	 
	 

	 
	 private  func addItem2() {
		 
		 withAnimation {
			 let newCategory = Category(context: viewContext)
			 newCategory.catShop = "новая категория"
			 newCategory.categoryID = Int16(category.count)
				 // прдумать как при удалении категории переносить данные в удаленные данные (или как то так
			 do {
				 try viewContext.save()
			 } catch {
				 let nsError = error as NSError
				 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			 }
		 }
	 }
	 
	 
	 func removeCategory(offsets : IndexSet) -> Void  {
		 for index in offsets {
			 let categoryIndex = category[index]
				 viewContext.delete(categoryIndex)

		 //	try?  viewContext.save()
		 }
	 }
	 
 //	expenses.items.remove(atOffsets: offsets)


	 func deleteItems2(offsets: IndexSet) {
		 withAnimation {
			 print ("selfa", IndexSet.self)
			 offsets.map { category[$0] }.forEach(viewContext.delete)
				 //     do {
			 //print ("офсет", offsets)
			 
		 //	viewContext.delete(category)
			 
		 //	viewContext.update()

			 try? viewContext.save()

			 print ("Не записали удаление категории")
			 

				 //		let predicates = NSPredicate(format: "categoryItemID >= 0" )
				 //	category.nsPredicate = predicates
			 
			 
				 //  } catch {
				 // Replace this implementation with code to handle the error appropriately.
				 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				 //	let nsError = error as NSError
				 //	fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
				 //   }
		 }
	 }
	 
	 

	 
	 
	 func addItemDefTemp () {
		 /*	// запись первой строки – инициализация для превью
			 let newItem = Item(context: viewContext)
			 newItem.timestampData = Date()
			 newItem.noteSummData = "info"
			 newItem.mCatsData = "пример"
			 newItem.summData = 0
		 */
			 // инициализация начальных данных категорий для превью
			 let mCatInit: [String] = ["новая категория"]

		 
	 //нужно начинать не с 0 категории, а с 1! 0 резеврируем для удаления?, но пока остается с 0
		 let mCatInd: Int16 = 0   //MARK: ### нужно разобраться что сюда ставить, видимо получить кол-во категорий!
			 for mCats in mCatInit {
				 let newCategory = Category(context: viewContext)
				 newCategory.catShop = mCats
				 newCategory.categoryID = mCatInd
				 newCategory.categoryItemID = mCatInd
				 newCategory.catUUID = UUID()
				 newCategory.catNote = ""
				 newCategory.onRemove = false
				 newCategory.catRashSumm = true
				 
			 //	mCatInd += 1

			 }
			 
			 // запись файла
		 do {
			 try viewContext.save()
				 // отработка ошибок
		 } catch {
				 // Replace this implementation with code to handle the error appropriately.
				 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			 let nsError = error as NSError
			 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		 }
	 //	starterCategory = true
		 }


	 

 func addItemDef () {
		 // запись первой строки – инициализация для превью
		 let newItem = Item(context: viewContext)
		 newItem.timestampData = Date()
		 newItem.noteSummData = "info"
		 newItem.mCatsData = "пример"
		 newItem.summData = 0
		 
		 // инициализация начальных данных категорий для превью
		 let mCatInit: [String] = ["продукты", "товары", "услуги", "рестораны", "развлечения", "комм. платежи", "здоровье", "другое"]

	 
 //нужно начинать не с 0 категории, а с 1! 0 резеврируем для удаления?, но пока остается с 0
		 var mCatInd: Int16 = 0
		 for mCats in mCatInit {
			 let newCategory = Category(context: viewContext)
			 newCategory.catShop = mCats
			 newCategory.categoryID = mCatInd
			 newCategory.categoryItemID = mCatInd
			 newCategory.catUUID = UUID()
			 newCategory.catNote = ""
			 newCategory.onRemove = false
			 newCategory.catRashSumm = true
			 
			 mCatInd += 1

		 }
		 
		 // запись файла
	 do {
		 try viewContext.save()
			 // отработка ошибок
	 } catch {
			 // Replace this implementation with code to handle the error appropriately.
			 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		 let nsError = error as NSError
		 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
	 }
	 starterCategory = true
	 }
 }


		 struct CategView_Previews: PreviewProvider {
			 static var previews: some View {
			   //  CategView().environment(\.managedObjectContext,  PersistenceController.preview.container.viewContext)
				 CategView().environment(\.managedObjectContext,  PersistenceController.preview.container.viewContext)
			 }
		 }


 struct Per {
	 @Binding  var categoryDeleteToggle: Bool

 }

















 struct CategoryRow: View {
	 @Environment(\.managedObjectContext) var viewContext
	 @Environment(\.refresh) private var refresh
	 
	 @ObservedObject var category: Category
	 //@State var category: Category
	 // @Binding var indexSet: IndexSet
	 
	 @State var ColorToggleRedGray = Color.gray
	 
	 @State  var categoryDeleteToggle: Bool = false  // MARK: разбираться что - то связано с ??
	 
	 @FocusState private var nameIsFocused: Bool // для скрытия и показа всплывающей клавиатуры
	 @State var dataTemp: String = ""
	 

	 
	 var body: some View {
		 


		 NavigationLink () {
			 
		  //     CategoryEditView()
		  // рабочий блок
			 VStack(){
				 
				 VStack{
					 Text("КАТЕГОРИЯ")
						 .font(.subheadline)
						 .foregroundColor(Color.green)
						 .frame(width: 320.0, alignment: .leading)
						 .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxLarge/*@END_MENU_TOKEN@*/)

					 
					 Text("\(category.catShop!)")
						 .foregroundColor(Color.blue)
						 .frame(width: 320.0, alignment: .leading)
						 .dynamicTypeSize(.xLarge)
					 
				 }
				 .padding(.top, 30.0)
				 
			 
				 
				 Text("Изменить название категории")
					 .frame(width: 320.0, height: 20.0, alignment: .leading)
					 .task {
						 nameIsFocused = false
					 }
				 TextField("\(category.catShop!)", text: $dataTemp)
					 .padding(.leading, 20.0)
					 .foregroundColor(Color.blue)
					 .frame(width: 320.0, height: 40.0, alignment: .leading)
					 .background(Color("downgray"))
					 .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
				 
				 
				 Toggle(isOn: self.$category.catRashSumm ) {
					 Text("Учитывать в общих расходах")
						 .task {saveCateg()
							 
						 }
				 }
				 .frame(width: 320.0, alignment: .leading)
				 .padding(.vertical, 10.0)
				 
				 
				 Text("Порог трат в неделю")
					 .task {
						 nameIsFocused = false
					 }
					 .frame(width: 320.0, alignment: .leading)
					 .foregroundColor(Color.gray)
				 
				 Text("Порог трат в месяц")
					 .task {
						 nameIsFocused = false
					 }
					 .frame(width: 320.0, height: 10.0, alignment: .leading)
					 .foregroundColor(Color.gray)
				 
				 Text("Приоритет показа")
					 .font(.headline)
					 // для OC 16                                 .fontWeight(.light)
					 .multilineTextAlignment(.leading)
					 .frame(width: 320.0, alignment: .leading)

					 .foregroundColor(.black)
					 .padding(.bottom, 10.0)

				 
				 Toggle(isOn: $categoryDeleteToggle ) {
					 
					 Text("Удалить категорию")
						 
					 //	.foregroundColor(.blue)

				 }
				 .task {
				 }
				 .frame(width: 320.0)
				 .tint(.red)
				 Text ("Удаление категории приведет к удалению связанных с ней данных. Вы можете переименовать категорю.")
					 .font(.caption)
					 .fontWeight(.medium)
					 
					 .foregroundColor(.gray)
					 .frame(width: 320.0, alignment: .leading)
					 .padding(.bottom, 10.0)

				 
				 
				 Button("Подтвердить изменения") {
					 nameIsFocused = false
					 saveCateg ()
				 //	deleteItems3(offsets: indexSet)
				 }

				 .frame(width: 320.0, height: 50.0)
				 .accentColor(.white)
				 .background(.green)
				 .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
				 .padding(.bottom, 40.0)

			 }
			 

			 .padding(.top, 5.0)
		  }

			 label: {
			 // TextField("\(category.catShop!)", text: $dataTemp)
			 Text("\(category.catShop!)")
			 .foregroundColor(category.catRashSumm ?   .blue : .gray)

			 }

		 
		 
		 
		 
		 
	 }
	 

	 func deleteItems3(offsets: IndexSet) {
		 withAnimation {
			 //print ("категори индекс", category: categoryIndex)
			 //offsets.map { category[$0] }.forEach(viewContext.delete)
				 //     do {
			 //print ("офсет", offsets)
			 
		 //	viewContext.delete(category)
			 
		 //	viewContext.update()

			 try? viewContext.save()

			 print ("Не записали удаление категории")
			 

				 //		let predicates = NSPredicate(format: "categoryItemID >= 0" )
				 //	category.nsPredicate = predicates
			 
			 
				 //  } catch {
				 // Replace this implementation with code to handle the error appropriately.
				 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				 //	let nsError = error as NSError
				 //	fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
				 //   }
		 }
	 }


	  func DeleteCateg() {
		 
		 print(categoryDeleteToggle)
		 if categoryDeleteToggle == true {
			 ColorToggleRedGray = Color.red
		 }
		  
	  }

 func saveCateg () {
	 if dataTemp == "" {
	 dataTemp = category.catShop!
	 }
	 category.catShop = dataTemp
	 category.catRashSumm = category.catRashSumm
	 try? viewContext.save()
	 dataTemp = ""
	 
	 }

 }

*/
