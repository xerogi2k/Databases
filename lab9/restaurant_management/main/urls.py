from django.urls import path
from . import views

urlpatterns = [
    # Маршруты для поваров
    path('cooks/', views.CookListView.as_view(), name='cook_list'),
    path('cooks/<int:pk>/', views.CookDetailView.as_view(), name='cook_detail'),
    path('cooks/new/', views.CookCreateView.as_view(), name='cook_create'),
    path('cooks/<int:pk>/edit/', views.CookUpdateView.as_view(), name='cook_update'),
    path('cooks/<int:pk>/delete/', views.CookDeleteView.as_view(), name='cook_delete'),
    path('cooks/search/', views.cook_search, name='cook_search'),

    # Маршруты для блюд
    path('dishes/', views.DishListView.as_view(), name='dish_list'),
    path('dishes/<int:pk>/', views.DishDetailView.as_view(), name='dish_detail'),
    path('dishes/new/', views.DishCreateView.as_view(), name='dish_create'),
    path('dishes/<int:pk>/edit/', views.DishUpdateView.as_view(), name='dish_update'),
    path('dishes/<int:pk>/delete/', views.DishDeleteView.as_view(), name='dish_delete'),
    path('dishes/search/', views.dish_search, name='dish_search'),

    # Маршруты для поставщиков
    path('suppliers/', views.SupplierListView.as_view(), name='supplier_list'),
    path('suppliers/<int:pk>/', views.SupplierDetailView.as_view(), name='supplier_detail'),
    path('suppliers/new/', views.SupplierCreateView.as_view(), name='supplier_create'),
    path('suppliers/<int:pk>/edit/', views.SupplierUpdateView.as_view(), name='supplier_update'),
    path('suppliers/<int:pk>/delete/', views.SupplierDeleteView.as_view(), name='supplier_delete'),
    path('suppliers/search/', views.supplier_search, name='supplier_search'),

    # Маршруты для продуктов
    path('products/', views.ProductListView.as_view(), name='product_list'),
    path('products/<int:pk>/', views.ProductDetailView.as_view(), name='product_detail'),
    path('products/new/', views.ProductCreateView.as_view(), name='product_create'),
    path('products/<int:pk>/edit/', views.ProductUpdateView.as_view(), name='product_update'),
    path('products/<int:pk>/delete/', views.ProductDeleteView.as_view(), name='product_delete'),
    path('products/search/', views.product_search, name='product_search'),

    # Маршруты для рецептов
    path('recipes/', views.RecipeListView.as_view(), name='recipe_list'),
    path('recipes/<int:pk>/', views.RecipeDetailView.as_view(), name='recipe_detail'),
    path('recipes/new/', views.RecipeCreateView.as_view(), name='recipe_create'),
    path('recipes/<int:pk>/edit/', views.RecipeUpdateView.as_view(), name='recipe_update'),
    path('recipes/<int:pk>/delete/', views.RecipeDeleteView.as_view(), name='recipe_delete'),
    path('recipes/search/', views.recipe_search, name='recipe_search'),

    # Маршруты для ресторанов
    path('restaurants/', views.RestaurantListView.as_view(), name='restaurant_list'),
    path('restaurants/<int:pk>/', views.RestaurantDetailView.as_view(), name='restaurant_detail'),
    path('restaurants/new/', views.RestaurantCreateView.as_view(), name='restaurant_create'),
    path('restaurants/<int:pk>/edit/', views.RestaurantUpdateView.as_view(), name='restaurant_update'),
    path('restaurants/<int:pk>/delete/', views.RestaurantDeleteView.as_view(), name='restaurant_delete'),
    path('restaurants/search/', views.restaurant_search, name='restaurant_search'),
]
