from rest_framework import generics
from .models import Brand, Products, Category, Color, Gender, Size, Status, Subcategory, New, Messages, Orders
from .models import Favorites, UserAlem
from .serializers import BrandSerializer, ProductSerializer, CategorySerializer, ColorSerializer
from .serializers import GenderSerializer, SizeSerializer, StatusSerializer, SubcategorySerializer, OrdersSerializer
from .serializers import MessageSerializer, FavoritesSerializer, NewSerializer, UserAlemSerializer
from rest_framework.response import Response
from rest_framework.reverse import reverse


class BrandList(generics.ListCreateAPIView):
    queryset = Brand.objects.all()
    serializer_class = BrandSerializer
    name = 'brand-list'


class BrandDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Brand.objects.all()
    serializer_class = BrandSerializer
    name = 'brand-detail'


class ProductList(generics.ListCreateAPIView):
    queryset = Products.objects.all()
    serializer_class = ProductSerializer
    name = 'product-list'

class ProductDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Products.objects.all()
    serializer_class = ProductSerializer
    name = 'product-detail'


class CategoryList(generics.ListCreateAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    name = 'category-list'

class CategoryDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    name = 'category-detail'

class ColorList(generics.ListCreateAPIView):
    queryset = Color.objects.all()
    serializer_class = ColorSerializer
    name = 'color-list'

class ColorDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Color.objects.all()
    serializer_class = ColorSerializer
    name = 'color-detail'


class GenderList(generics.ListCreateAPIView):
    queryset = Gender.objects.all()
    serializer_class = GenderSerializer
    name = 'gender-list'


class GenderDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Gender.objects.all()
    serializer_class = GenderSerializer
    name = 'gender-detail'

class SizeList(generics.ListCreateAPIView):
    queryset = Size.objects.all()
    serializer_class = SizeSerializer
    name = 'size-list'


class SizeDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Size.objects.all()
    serializer_class = SizeSerializer
    name = 'size-detail'

class StatusList(generics.ListCreateAPIView):
    queryset = Status.objects.all()
    serializer_class = StatusSerializer
    name = 'status-list'


class StatusDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Status.objects.all()
    serializer_class = StatusSerializer
    name = 'status-detail'

class SubcategoryList(generics.ListCreateAPIView):
    queryset = Subcategory.objects.all()
    serializer_class = SubcategorySerializer
    name = 'subcategory-list'


class SubcategoryDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Subcategory.objects.all()
    serializer_class = SubcategorySerializer
    name = 'subcategory-detail'

class NewList(generics.ListCreateAPIView):
    queryset = New.objects.all()
    serializer_class = NewSerializer
    name = 'new-list'


class NewDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = New.objects.all()
    serializer_class = NewSerializer
    name = 'new-detail'


class MessageList(generics.ListCreateAPIView):
    queryset = Messages.objects.all()
    serializer_class = MessageSerializer
    name = 'messages-list'


class MessageDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Messages.objects.all()
    serializer_class = MessageSerializer
    name = 'messages-detail'

class OrdersList(generics.ListCreateAPIView):
    queryset = Orders.objects.all()
    serializer_class = OrdersSerializer
    name = 'orders-list'


class OrdersDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Orders.objects.all()
    serializer_class = OrdersSerializer
    name = 'orders-detail'

class FavoritesList(generics.ListCreateAPIView):
    queryset = Favorites.objects.all()
    serializer_class = FavoritesSerializer
    name = 'favorites-list'


class FavoritesDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Favorites.objects.all()
    serializer_class = FavoritesSerializer
    name = 'favorites-detail'

class UserAlemList(generics.ListCreateAPIView):
    queryset = UserAlem.objects.all()
    serializer_class = UserAlemSerializer
    name = 'useralem-list'


class UserAlemDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = UserAlem.objects.all()
    serializer_class = UserAlemSerializer
    name = 'useralem-detail'

class ApiRoot(generics.GenericAPIView):
    name = 'alem'

    def get(self, request, *args, **kwargs):
        return Response({
            '1-brands': reverse(BrandList.name, request=request),
            '2-products': reverse(ProductList.name, request=request),
            '3-categories': reverse(CategoryList.name, request=request),
            '4-colors': reverse(ColorList.name, request=request),
            '5-genders': reverse(GenderList.name, request=request),
            '6-sizes': reverse(SizeList.name, request=request),
            '7-status': reverse(StatusList.name, request=request),
            '8-subcategory': reverse(SubcategoryList.name, request=request),
            '9-new': reverse(NewList.name, request=request),
            '10-message': reverse(MessageList.name, request=request),
            '11-order': reverse(OrdersList.name, request=request),
            '12-favorite': reverse(FavoritesList.name, request=request),
            '13-user:': reverse(UserAlemList.name, request=request)


            })
