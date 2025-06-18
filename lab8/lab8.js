// 3.1 Отобразить коллекции базы данных
  show collections
  
  // 3.2 Вставка записей
  // 1)Вставка одной записи
  db.cooks.insertOne({
    chef_name: "Виктор Баринов",
    experience_years: 10,
    speciality: "Итальянская кухня",
    location: "Россия"
  });
  db.cooks.insertOne({
    chef_name: "Владимир Кошкин",
    experience_years: 5,
    speciality: "Французская кухня",
    location: "Россия"
  });
  db.dishes.insertOne({
    dish_name: "Карбонара",
    description: "Превосхожное блюдо итальянской кухни",
    preparation_time: 30,
    calories: 250,
    cook_id: db.cooks.findOne({ chef_name: "Виктор Баринов" })._id
  });
  db.dishes.insertOne({
    dish_name: "Болоньезе",
    description: "Великолепная паста, передающая весь аромат итальянских томатов",
    preparation_time: 20,
    calories: 350,
    cook_id: db.cooks.findOne({ chef_name: "Виктор Баринов" })._id
  });
  db.dishes.insertOne({
    dish_name: "Запечёные улитки",
    description: "Изысканное блюдо французской кухни",
    preparation_time: 45,
    calories: 100,
    cook_id: db.cooks.findOne({ chef_name: "Владимир Кошкин" })._id
  });
  db.suppliers.insertOne({
        supplier_name: "Живая еда",
        contact_person: "Николай Наумов",
        phone_number: "+7(927)-886-27-66",
        email: "nikolay@mail.ru"
  });
  db.products.insertOne({
        product_name: "Итальянская паста",
        category: "Паста",
        quantity_in_stock: 100,
        price: 1.5,
        supplier_id: db.suppliers.findOne({ supplier_name: "Живая еда" })._id,
        ingredients: ["Пшеница", "Яйца"]
  });
    db.restaurants.insertOne({
          name: "Ресторан Итальянской Кухни",
          cuisine: "Итальянская",
          rating: 5,
          address: {
              street: "Бульвар Победы 23",
              city: "Йошкар-Ола",
              state: "Марий Эл",
              zip: "425200"
          }
    })
    db.recipes.insertOne({
          dish_id: db.dishes.findOne({ dish_name: "Карбонара" })._id,
          product_id: db.products.findOne({ product_name: "Итальянская паста" })._id,
          quantity: 0.01,
          unit: "граммы"
    });

  // 2)Вставка нескольких записей
  db.products.insertMany([
    {
      product_name: "Томат",
      category: "Овощи",
      quantity_in_stock: 150,
      price: 0.99,
      supplier_id: ObjectId()
    },
    {
      product_name: "Базилик",
      category: "Травы",
      quantity_in_stock: 40,
      price: 1.20,
      supplier_id: ObjectId()
    }
  ]);
  
  // 3.3 Удаление записей
  // 1)Удаление одной записи по условию
  db.products.deleteOne({ product_name: "Базилик" });
  
  // 2)Удаление нескольких записей по условию
  db.products.deleteMany({ category: "Овощи" });
  
  // 3.4 Поиск записей
  // 1)Поиск по ID
  db.dishes.findOne({ _id: ObjectId("6663932648b69ed52ff604ea") });
  
  // 2)Поиск записи по атрибуту первого уровня
  db.cooks.findOne({ chef_name: "Виктор Баринов" });
  
  // 3)Поиск записи по вложенному атрибуту (такой атрибут должен быть в документе)
  db.restaurants.findOne({ "address.city": "Йошкар-Ола" });

  // 4)Поиск записи по нескольким атрибутам (логический оператор AND)
  db.products.find({ $and: [{price: { $gt: 1.00 }},{category: "Травы" }] });
  
  // 5)Поиск записи по одному из условий (логический оператор OR)
  db.products.find({ $or: [{ category: "Овощи" }, { price: { $lt: 1.00 } }] });
  
  // 6)Поиск с использованием оператора сравнения
  db.products.find({ price: { $gt: 1.00 } });
  
  // 7)Поиск с использованием двух операторов сравнения
  db.products.find({ price: { $gt: 0.50, $lt: 1.50 } });
  
  // 8)Поиск по значению в массиве (пример с массивом)
  db.products.find({ ingredients: "Томатный соус" });

  // 9)Поиск по количеству элементов в массиве (пример с массивом)
  db.products.find({ ingredients: { $size: 2 } });
  
  // 10)Поиск записей без атрибута
  db.products.find({ category: { $exists: false } });
  
  // 3.5 Обновление записей
  // 1)Изменить значение атрибута у записи
  db.cooks.updateOne({ chef_name: "Виктор Баринов" }, { $set: { experience_years: 12 } });
  
  // 2)Удалить атрибут у записи
  db.cooks.updateOne({ chef_name: "Виктор Баринов" }, { $unset: { location: "" } });
  
  // 3)Добавить атрибут записи
  db.cooks.updateOne({ chef_name: "Виктор Баринов" }, { $set: { DateOfBitrh: "18-06-1980" } });



сколько блюд готовит каждый повар

db.dishes.aggregate([
  {
      $group: {
          _id: "$cook_id",
          count: { $sum: 1 } 
      }
  },
  {
      $lookup: {
          from: "cooks",       
          localField: "_id",   
          foreignField: "_id", 
          as: "cook_info"      
      }
  },
  {
      $project: {
          _id: 0, 
          chef_name: "$cook_info.chef_name", 
          dish_count: "$count" 
      }
  }
])