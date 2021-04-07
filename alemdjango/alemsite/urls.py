from django.urls import path, reverse
from .views import *
from .views_serializers import *
from django.conf.urls import url
from alemsite import views_serializers
from rest_framework import routers


urlpatterns = [
    path('alem/', index, name='home'),
    path('userRegister/', userRegister, name='userRegister'),
    path('userLogin/', userLogin, name='userLogin'),
    path('category/', category, name='category'),
    path('brand/', brand, name='brand'),
    path('color/', color, name='color'),
    path('favorites/<ai>/<name>/<color>/<category>/<subcategory>/<size>/', favoritesView.as_view(), name='favorites'),
    path('gender/', gender, name='gender'),
    path('lastids/', lastids, name='lastids'),
    path('messages/', messageView.as_view(), name='messages'),
    path('order/<ai>/<name>/', orderView.as_view(), name='orders'),
    path('user/', user, name='user'),
    path('size/', size, name='size'),
    path('status/', status, name='status'),
    path('subcategory/', subcategory, name='subcategory'),
    path('cat/', catView.as_view(), name='cat'),
    path('sub/<int:category_id>/', subView.as_view(), name='sub'),
    path('product/<int:subcategory_id>/', proView.as_view(), name='product'),
    path('info/<int:pk>/', infoView.as_view(), name='infoProducts'),
    path('orderlist/', orderlistView, name='orderlist'),
    path('favlistt/', favlistView, name='favlist'),
    url(r'^brand-list/$', views_serializers.BrandList.as_view(), name=views_serializers.BrandList.name),
    url(r'^brand-list/(?P<pk>[0-9]+)$', views_serializers.BrandDetail.as_view(), name=views_serializers.BrandDetail.name),
    url(r'^product-list/$', views_serializers.ProductList.as_view(), name=views_serializers.ProductList.name),
    url(r'^product-list/(?P<pk>[0-9]+)$', views_serializers.ProductDetail.as_view(), name=views_serializers.ProductDetail.name),
    url(r'^category-list/$', views_serializers.CategoryList.as_view(), name=views_serializers.CategoryList.name),
    url(r'^category-list/(?P<pk>[0-9]+)$', views_serializers.CategoryDetail.as_view(), name=views_serializers.CategoryDetail.name),
    url(r'^color-list/$', views_serializers.ColorList.as_view(), name=views_serializers.ColorList.name),
    url(r'^color-list/(?P<pk>[0-9]+)$', views_serializers.ColorDetail.as_view(), name=views_serializers.ColorDetail.name),
    url(r'^gender-list/$', views_serializers.GenderList.as_view(), name=views_serializers.GenderList.name),
    url(r'^gender-list/(?P<pk>[0-9]+)$', views_serializers.GenderDetail.as_view(), name=views_serializers.GenderDetail.name),
    url(r'^size-list/$', views_serializers.SizeList.as_view(), name=views_serializers.SizeList.name),
    url(r'^size-list/(?P<pk>[0-9]+)$', views_serializers.SizeDetail.as_view(), name=views_serializers.SizeDetail.name),
    url(r'^status-list/$', views_serializers.StatusList.as_view(), name=views_serializers.StatusList.name),
    url(r'^status-list/(?P<pk>[0-9]+)$', views_serializers.StatusDetail.as_view(), name=views_serializers.StatusDetail.name),
    url(r'^subcategory-list/$', views_serializers.SubcategoryList.as_view(), name=views_serializers.SubcategoryList.name),
    url(r'^subcategory-list/(?P<pk>[0-9]+)$', views_serializers.SubcategoryDetail.as_view(), name=views_serializers.SubcategoryDetail.name),
    url(r'^new-list/$', views_serializers.NewList.as_view(), name=views_serializers.NewList.name),
    url(r'^new-list/(?P<pk>[0-9]+)$', views_serializers.NewDetail.as_view(), name=views_serializers.NewDetail.name),
    url(r'^message-list/$', views_serializers.MessageList.as_view(), name=views_serializers.MessageList.name),
    url(r'^message-list/(?P<pk>[0-9]+)$', views_serializers.MessageDetail.as_view(), name=views_serializers.MessageDetail.name),
    url(r'^order-list/$', views_serializers.OrdersList.as_view(), name=views_serializers.OrdersList.name),
    url(r'^order-list/(?P<pk>[0-9]+)$', views_serializers.OrdersDetail.as_view(), name=views_serializers.OrdersDetail.name),
    url(r'^favorite-list/$', views_serializers.FavoritesList.as_view(), name=views_serializers.FavoritesList.name),
    url(r'^favorite-list/(?P<pk>[0-9]+)$', views_serializers.FavoritesDetail.as_view(), name=views_serializers.FavoritesDetail.name),
    url(r'^user-list/$', views_serializers.UserAlemList.as_view(), name=views_serializers.UserAlemList.name),
    url(r'^user-list/(?P<pk>[0-9]+)$', views_serializers.UserAlemDetail.as_view(), name=views_serializers.UserAlemDetail.name),

    url(r'^$', views_serializers.ApiRoot.as_view(), name=views_serializers.ApiRoot.name)


]







