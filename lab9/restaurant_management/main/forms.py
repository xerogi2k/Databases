from django import forms
from .models import Cook, Dish, Supplier, Product, Recipe, Restaurant

class CookForm(forms.ModelForm):
    class Meta:
        model = Cook
        fields = '__all__'

class DishForm(forms.ModelForm):
    class Meta:
        model = Dish
        fields = '__all__'

class SupplierForm(forms.ModelForm):
    class Meta:
        model = Supplier
        fields = '__all__'

class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = '__all__'

class RecipeForm(forms.ModelForm):
    class Meta:
        model = Recipe
        fields = '__all__'

class RestaurantForm(forms.ModelForm):
    class Meta:
        model = Restaurant
        fields = '__all__'
