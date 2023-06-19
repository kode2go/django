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

rm app/*.py
cp -R ../resources/pyfiles/. app/

python manage.py makemigrations
python manage.py migrate
