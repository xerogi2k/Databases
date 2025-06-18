from django.contrib import admin
from .models import Cook, Dish, Supplier, Product, Recipe, Restaurant

admin.site.register(Cook)
admin.site.register(Dish)
admin.site.register(Supplier)
admin.site.register(Product)
admin.site.register(Recipe)
admin.site.register(Restaurant)