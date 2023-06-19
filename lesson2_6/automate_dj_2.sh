#!/bin/bash

# Prompt for project name
read -p "Enter project name: " project_name

# Create Django project
django-admin startproject $project_name

# Move into the project directory
cd $project_name

python manage.py makemigrations
python manage.py migrate

# Create superuser
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', '1@1.com', 'admin')" | python manage.py shell

python manage.py startapp app

# Update settings.py file
echo -e "\nINSTALLED_APPS.append('app')" >> $project_name/settings.py

# Create urls.py file in app folder
echo -e "from django.urls import path\nfrom . import views\n\nurlpatterns = [\n    path('', views.index, name='index'),\n]" > app/urls.py

# Create views.py file in app folder
echo -e "from django.shortcuts import render\n\n\ndef index(request):\n    context = {}\n    return render(request, 'index.html', context)" > app/views.py

# Update urls.py file
echo -e "\nfrom django.urls import include\n\nurlpatterns += [\n    path('', include('app.urls')),\n]" >> $project_name/urls.py

awk '/"DIRS":/ {$0 = "        \"DIRS\": [os.path.join(BASE_DIR, \x27templates\x27)],"} 1' $project_name/settings.py > $project_name/temp.py && mv $project_name/temp.py $project_name/settings.py

awk '/from pathlib import Path/ {print; print "import os"; next} 1' $project_name/settings.py > $project_name/temp.py && mv $project_name/temp.py $project_name/settings.py

mkdir -p app/templates/
mkdir -p app/static/
echo $PWD

cp -R ../resources/templates/. app/templates/
cp -R ../resources/static/. app/static/

echo -e "\nurlpatterns += [\n    path('login/', views.login, name='login'),\n]" >> app/urls.py
echo -e "\nurlpatterns += [\n    path('register/', views.register, name='register'),\n]" >> app/urls.py
echo -e "\nurlpatterns += [\n    path('forgot_password/', views.forgot_password, name='forgot_password'),\n]" >> app/urls.py
echo -e "\nurlpatterns += [\n    path('tables/', views.tables, name='tables'),\n]" >> app/urls.py
echo -e "\nurlpatterns += [\n    path('charts/', views.charts, name='charts'),\n]" >> app/urls.py
echo -e "\nurlpatterns += [\n    path('error_404/', views.error_404, name='error_404'),\n]" >> app/urls.py
echo -e "\nurlpatterns += [\n    path('blank/', views.blank, name='blank'),\n]" >> app/urls.py


echo -e "\ndef login(request):\n    context = {}\n    return render(request, 'login.html', context)" >> app/views.py
echo -e "\ndef register(request):\n    context = {}\n    return render(request, 'register.html', context)" >> app/views.py
echo -e "\ndef forgot_password(request):\n    context = {}\n    return render(request, 'forgot_password.html', context)" >> app/views.py
echo -e "\ndef tables(request):\n    context = {}\n    return render(request, 'tables.html', context)" >> app/views.py
echo -e "\ndef charts(request):\n    context = {}\n    return render(request, 'charts.html', context)" >> app/views.py
echo -e "\ndef error_404(request):\n    context = {}\n    return render(request, 'error_404.html', context)" >> app/views.py
echo -e "\ndef blank(request):\n    context = {}\n    return render(request, 'blank.html', context)" >> app/views.py
