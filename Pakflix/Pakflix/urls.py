"""
URL configuration for Pakflix project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
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
from Pakflix import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [ 
    path('admin/', admin.site.urls),
    path('search/', views.searchPage),
    path('list/', views.listPage),
    path("signup/", views.signUpPage),  
    path("subscription/", views.subscriptionPage),
    path("creditcard/", views.creditcardPage),
    path("login/", views.loginPage),
    path("", views.loginPage),
    path("movie/<str:movieTitle>",views.moviePage),
    path("home/", views.homePage),
    path("othersList/", views.othersListPage),
    path("watchHistory/",views.watchHistoryPage),
   
] + static( settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
