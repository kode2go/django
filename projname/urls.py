"""projname URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
#1 added HttpResponse below
from django.http import HttpResponse
#2 added render below
from django.shortcuts import render

#1 added homePage function/view below
def homePage(request):
	return HttpResponse('homePage')

#1 added page1 function/view below
def page1(request):
	return HttpResponse('page1')

#2 added mainView function/view
def mainView(request):
    return render(request, 'main.html')

urlpatterns = [
    path('admin/', admin.site.urls),
#1 added two paths home and contact
    path('',homePage),
    path('page1/',page1),
#2 added main page 
    path('main/',mainView),
    
]