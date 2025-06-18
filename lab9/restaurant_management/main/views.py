from django.shortcuts import render, get_object_or_404, redirect
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.urls import reverse_lazy
from .models import Cook, Dish, Supplier, Product, Recipe, Restaurant
from .forms import CookForm, DishForm, SupplierForm, ProductForm, RecipeForm, RestaurantForm

class CookListView(ListView):
    model = Cook
    template_name = 'main/cook_list.html'
    context_object_name = 'cooks'
    success_url = reverse_lazy('cook_list')

class CookDetailView(DetailView):
    model = Cook
    template_name = 'main/cook_detail.html'
    context_object_name = 'cook'

class CookCreateView(CreateView):
    model = Cook
    form_class = CookForm
    template_name = 'main/cook_form.html'
    success_url = reverse_lazy('cook_list')

class CookUpdateView(UpdateView):
    model = Cook
    form_class = CookForm
    template_name = 'main/cook_form.html'
    success_url = reverse_lazy('cook_list')

class CookDeleteView(DeleteView):
    model = Cook
    template_name = 'main/cook_confirm_delete.html'
    success_url = reverse_lazy('cook_list')

def cook_search(request):
    query = request.GET.get('q')
    cooks = Cook.objects.filter(chef_name__icontains=query) if query else Cook.objects.all()
    return render(request, 'main/cook_list.html', {'cooks': cooks})

class DishListView(ListView):
    model = Dish
    template_name = 'main/dish_list.html'
    context_object_name = 'dishes'

class DishDetailView(DetailView):
    model = Dish
    template_name = 'main/dish_detail.html'
    context_object_name = 'dish'

class DishCreateView(CreateView):
    model = Dish
    form_class = DishForm
    template_name = 'main/dish_form.html'
    success_url = reverse_lazy('dish_list')

class DishUpdateView(UpdateView):
    model = Dish
    form_class = DishForm
    template_name = 'main/dish_form.html'
    success_url = reverse_lazy('dish_list')

class DishDeleteView(DeleteView):
    model = Dish
    template_name = 'main/dish_confirm_delete.html'
    success_url = reverse_lazy('dish_list')

def dish_search(request):
    query = request.GET.get('q')
    dishes = Dish.objects.filter(dish_name__icontains=query) if query else Dish.objects.all()
    return render(request, 'main/dish_list.html', {'dishes': dishes})

class SupplierListView(ListView):
    model = Supplier
    template_name = 'main/supplier_list.html'
    context_object_name = 'suppliers'

class SupplierDetailView(DetailView):
    model = Supplier
    template_name = 'main/supplier_detail.html'
    context_object_name = 'supplier'

class SupplierCreateView(CreateView):
    model = Supplier
    form_class = SupplierForm
    template_name = 'main/supplier_form.html'
    success_url = reverse_lazy('supplier_list')

class SupplierUpdateView(UpdateView):
    model = Supplier
    form_class = SupplierForm
    template_name = 'main/supplier_form.html'
    success_url = reverse_lazy('supplier_list')

class SupplierDeleteView(DeleteView):
    model = Supplier
    template_name = 'main/supplier_confirm_delete.html'
    success_url = reverse_lazy('supplier_list')

def supplier_search(request):
    query = request.GET.get('q')
    suppliers = Supplier.objects.filter(supplier_name__icontains=query) if query else Supplier.objects.all()
    return render(request, 'main/supplier_list.html', {'suppliers': suppliers})

class ProductListView(ListView):
    model = Product
    template_name = 'main/product_list.html'
    context_object_name = 'products'

class ProductDetailView(DetailView):
    model = Product
    template_name = 'main/product_detail.html'
    context_object_name = 'product'

class ProductCreateView(CreateView):
    model = Product
    form_class = ProductForm
    template_name = 'main/product_form.html'
    success_url = reverse_lazy('product_list')

class ProductUpdateView(UpdateView):
    model = Product
    form_class = ProductForm
    template_name = 'main/product_form.html'
    success_url = reverse_lazy('product_list')

class ProductDeleteView(DeleteView):
    model = Product
    template_name = 'main/product_confirm_delete.html'
    success_url = reverse_lazy('product_list')

def product_search(request):
    query = request.GET.get('q')
    products = Product.objects.filter(product_name__icontains=query) if query else Product.objects.all()
    return render(request, 'main/product_list.html', {'products': products})

class RecipeListView(ListView):
    model = Recipe
    template_name = 'main/recipe_list.html'
    context_object_name = 'recipes'

class RecipeDetailView(DetailView):
    model = Recipe
    template_name = 'main/recipe_detail.html'
    context_object_name = 'recipe'

class RecipeCreateView(CreateView):
    model = Recipe
    form_class = RecipeForm
    template_name = 'main/recipe_form.html'
    success_url = reverse_lazy('recipe_list')

class RecipeUpdateView(UpdateView):
    model = Recipe
    form_class = RecipeForm
    template_name = 'main/recipe_form.html'
    success_url = reverse_lazy('recipe_list')

class RecipeDeleteView(DeleteView):
    model = Recipe
    template_name = 'main/recipe_confirm_delete.html'
    success_url = reverse_lazy('recipe_list')

def recipe_search(request):
    query = request.GET.get('q')
    recipes = Recipe.objects.filter(dish__dish_name__icontains=query) if query else Recipe.objects.all()
    return render(request, 'main/recipe_list.html', {'recipes': recipes})

class RestaurantListView(ListView):
    model = Restaurant
    template_name = 'main/restaurant_list.html'
    context_object_name = 'restaurants'

class RestaurantDetailView(DetailView):
    model = Restaurant
    template_name = 'main/restaurant_detail.html'
    context_object_name = 'restaurant'

class RestaurantCreateView(CreateView):
    model = Restaurant
    form_class = RestaurantForm
    template_name = 'main/restaurant_form.html'
    success_url = reverse_lazy('restaurant_list')

class RestaurantUpdateView(UpdateView):
    model = Restaurant
    form_class = RestaurantForm
    template_name = 'main/restaurant_form.html'
    success_url = reverse_lazy('restaurant_list')

class RestaurantDeleteView(DeleteView):
    model = Restaurant
    template_name = 'main/restaurant_confirm_delete.html'
    success_url = reverse_lazy('restaurant_list')

def restaurant_search(request):
    query = request.GET.get('q')
    restaurants = Restaurant.objects.filter(name__icontains=query) if query else Restaurant.objects.all()
    return render(request, 'main/restaurant_list.html', {'restaurants': restaurants})
