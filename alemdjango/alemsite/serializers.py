from django.utils.safestring import mark_safe
from rest_framework import serializers
from .models import Brand, Products, Category, Color, Gender, Size, Status, Subcategory, New, Messages, UserAlem
from .models import Orders, Favorites


class BrandSerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')

    class Meta:
        model = Brand
        fields = ('url','pk', 'name', 'products', )


class ProductSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Products
        fields = ('pk', 'ai','name', 'description', 'price',  'brand', 'category', 'color', 'gender', 'size', 'status',
                  'subcategory', 'new', 'photo','photo1','photo2','photo3','photo4',)

        def alem_id(self, obj):
            return mark_safe(str(obj.category.id)+obj.ai.ai+str(obj.subcategory.id))



class CategorySerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')
    subcategory = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='subcategory-detail'
    )


    class Meta:
        model = Category
        fields = ('url', 'pk', 'ai', 'name', 'products', 'photo', 'subcategory')

class ColorSerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')

    class Meta:
        model = Color
        fields = ('pk','url', 'name', 'products', )

class GenderSerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')

    class Meta:
        model = Gender
        fields = ('url','pk', 'name', 'products', )

class SizeSerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')

    class Meta:
        model = Size
        fields = ('url','pk', 'name', 'subcategory','products', )

class StatusSerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')

    class Meta:
        model = Status
        fields = ('url','pk', 'name', 'products', )

class SubcategorySerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')


    class Meta:
        model = Subcategory
        fields = ('url','pk','name', 'category', 'products'  )

class NewSerializer(serializers.HyperlinkedModelSerializer):
    products = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='product-detail')

    class Meta:
        model = New
        fields = ('url','pk','new', 'products')

class MessageSerializer(serializers.ModelSerializer):
    user = serializers.SlugRelatedField(queryset=UserAlem.objects.all(), slug_field='username')
    #user = serializers.HyperlinkedRelatedField(
        #many=True,
        #read_only=True,
        #view_name='messages-detail')

    class Meta:
        model = Messages
        fields = ('url','pk', 'user', 'text', 'answer', 'date')

class OrdersSerializer(serializers.ModelSerializer):
    user = serializers.SlugRelatedField(queryset=UserAlem.objects.all(), slug_field='username')


    class Meta:
        model = Orders
        fields = ('url','pk', 'user', 'ai', 'name','color', 'completed', 'date',  'quantity', 'size', 'inprocess',
                  )

class FavoritesSerializer(serializers.ModelSerializer):
    user = serializers.SlugRelatedField(queryset=UserAlem.objects.all(), slug_field='username')


    class Meta:
        model = Favorites
        fields = ('name', 'user', 'date','url','pk', 'ai', 'brand', 'gender', 'status', 'color', 'size', 'category'
                  , 'subcategory')


class UserAlemSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    class Meta:
        model = UserAlem
        fields = ('url','pk', 'username', 'surname', 'phone', 'email','password')
        write_only_fields = 'password'

        def create(self, validated_data):
            user = UserAlem.objects.create(username=validated_data['username'],
                                           email=validated_data['email'],
                                           phone= validated_data['phone'],
                                           password=validated_data['password'])
            user.set_password(validated_data['password'])
            user.save()
            return user
