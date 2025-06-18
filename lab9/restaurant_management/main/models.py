from django.db import models

class Cook(models.Model):
    chef_name = models.CharField(max_length=100)
    experience_years = models.IntegerField()
    speciality = models.CharField(max_length=100)
    location = models.CharField(max_length=100)

    def __str__(self):
        return self.chef_name

class Dish(models.Model):
    dish_name = models.CharField(max_length=100)
    description = models.TextField()
    preparation_time = models.IntegerField()
    calories = models.IntegerField()
    cook = models.ForeignKey(Cook, on_delete=models.CASCADE)

    def __str__(self):
        return self.dish_name

class Supplier(models.Model):
    supplier_name = models.CharField(max_length=100)
    contact_person = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=15)
    email = models.EmailField()

    def __str__(self):
        return self.supplier_name

class Product(models.Model):
    product_name = models.CharField(max_length=100)
    category = models.CharField(max_length=100)
    quantity_in_stock = models.IntegerField()
    price = models.FloatField()
    supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)
    ingredients = models.TextField()

    def __str__(self):
        return self.product_name

class Recipe(models.Model):
    dish = models.ForeignKey(Dish, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.FloatField()
    unit = models.CharField(max_length=20, choices=[('граммы', 'граммы'), ('миллилитры', 'миллилитры'), ('штуки', 'штуки'), ('чайные ложки', 'чайные ложки'), ('столовые ложки', 'столовые ложки')])

    def __str__(self):
        return f"{self.quantity} {self.unit} of {self.product} for {self.dish}"

class Restaurant(models.Model):
    name = models.CharField(max_length=100)
    cuisine = models.CharField(max_length=100)
    rating = models.IntegerField()
    street = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    zip = models.CharField(max_length=10)

    def __str__(self):
        return self.name
