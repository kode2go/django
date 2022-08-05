from django.contrib import admin
from django.urls import path
from django.shortcuts import render

def store(request):
    context = {}
    return render(request, 'index.html', context)

def fruit(request):
    context = {}
    return render(request, 'fruit.html', context)

def service(request):
    context = {}
    return render(request, 'service.html', context)

def contact(request):
    context = {}
    return render(request, 'contact.html', context)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', store, name='store'),
    path('fruit/', fruit, name='fruit'),
    path('service/', service, name='service'),
    path('contact/', contact, name='contact'),
]