# Generated by Django 5.0.6 on 2024-06-08 01:22

import django.db.models.deletion
from django.db import migrations, models

# python manage.py makemigrations
# python manage.py migrate

class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Cook',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('chef_name', models.CharField(max_length=100)),
                ('experience_years', models.IntegerField()),
                ('speciality', models.CharField(max_length=100)),
                ('location', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_name', models.CharField(max_length=100)),
                ('category', models.CharField(max_length=100)),
                ('quantity_in_stock', models.IntegerField()),
                ('price', models.FloatField()),
                ('ingredients', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Restaurant',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('cuisine', models.CharField(max_length=100)),
                ('rating', models.IntegerField()),
                ('street', models.CharField(max_length=100)),
                ('city', models.CharField(max_length=100)),
                ('state', models.CharField(max_length=100)),
                ('zip', models.CharField(max_length=10)),
            ],
        ),
        migrations.CreateModel(
            name='Supplier',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('supplier_name', models.CharField(max_length=100)),
                ('contact_person', models.CharField(max_length=100)),
                ('phone_number', models.CharField(max_length=15)),
                ('email', models.EmailField(max_length=254)),
            ],
        ),
        migrations.CreateModel(
            name='Dish',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('dish_name', models.CharField(max_length=100)),
                ('description', models.TextField()),
                ('preparation_time', models.IntegerField()),
                ('calories', models.IntegerField()),
                ('cook', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.cook')),
            ],
        ),
        migrations.CreateModel(
            name='Recipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.FloatField()),
                ('unit', models.CharField(choices=[('граммы', 'граммы'), ('миллилитры', 'миллилитры'), ('штуки', 'штуки'), ('чайные ложки', 'чайные ложки'), ('столовые ложки', 'столовые ложки')], max_length=20)),
                ('dish', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.dish')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.product')),
            ],
        ),
        migrations.AddField(
            model_name='product',
            name='supplier',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.supplier'),
        ),
    ]
