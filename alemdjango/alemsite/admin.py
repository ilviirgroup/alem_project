from django.contrib import admin
from .models import Brand, Color, Gender, Products, Size, Category, Status, Subcategory, New, UserAlem, Messages, Orders, Favorites
from .forms import messageForm
from django.utils.safestring import mark_safe


# 1
class BrandAdmin(admin.ModelAdmin):
    list_display = ('name',)


admin.site.register(Brand, BrandAdmin)

# 2
class CategoryAdmin(admin.ModelAdmin):
    list_display = ( 'ai', 'name')



admin.site.register(Category, CategoryAdmin)

# 3
class ColorAdmin(admin.ModelAdmin):
    list_display = ('name',)


admin.site.register(Color, ColorAdmin)

#4
# class FavoritesAdmin(admin.ModelAdmin):

#5
class GenderAdmin(admin.ModelAdmin):
    list_display = ('name',)


admin.site.register(Gender, GenderAdmin)

#8
class OrderAdmin(admin.ModelAdmin):
    list_display = ('name', 'ai','color','completed', 'date', 'user', 'quantity', 'size')

admin.site.register(Orders, OrderAdmin)


#9
class ProductsAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'description', 'category', 'subcategory', 'price', 'brand', 'color', 'gender',
                    'size', 'status', 'new', 'get_photo', 'get_photo1', 'get_photo2', 'get_photo3')

    # def alem_id(self, obj):
    #     return mark_safe(str(obj.category.id)+obj.ai.ai+str(obj.subcategory.id))

    def get_photo(self, obj):
        if obj.photo:
            return mark_safe(f'<img src="{obj.photo.url}" width="75">')
        else:
            return 'Surat goyulmadyk'

    def get_photo1(self, obj):
        if obj.photo:
            return mark_safe(f'<img src="{obj.photo1.url}" width="75">')
        else:
            return 'Surat goyulmadyk'
    def get_photo2(self, obj):
        if obj.photo:
            return mark_safe(f'<img src="{obj.photo2.url}" width="75">')
        else:
            return 'Surat goyulmadyk'
    def get_photo3(self, obj):
        if obj.photo:
            return mark_safe(f'<img src="{obj.photo3.url}" width="75">')
        else:
            return 'Surat goyulmadyk'

    def get_photo4(self, obj):
        if obj.photo:
            return mark_safe(f'<img src="{obj.photo3.url}" width="75">')
        else:
            return 'Surat goyulmadyk'


admin.site.register(Products, ProductsAdmin)

#10
class SizeAdmin(admin.ModelAdmin):
    list_display = ('name', 'subcategory')


admin.site.register(Size, SizeAdmin)


#11
class StatusAdmin(admin.ModelAdmin):
    list_display = ('name',)


admin.site.register(Status, StatusAdmin)


#12
class SubcategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name',
                    #'category'
                    )



admin.site.register(Subcategory, SubcategoryAdmin)


#13
class NewAdmin(admin.ModelAdmin):
    list_display = ('new',)


admin.site.register(New, NewAdmin)

class UserAdmin(admin.ModelAdmin):
    list_display = ('username','email', 'phone','is_staff')


admin.site.register(UserAlem, UserAdmin)


class MessageAdmin(admin.ModelAdmin):
    form = messageForm
    list_display = ( 'user','text', 'date')
    ordering = ['date']


admin.site.register(Messages, MessageAdmin)

class FavoritesAdmin(admin.ModelAdmin):
    list_display = ('name', 'user', 'date' ,
                    #'color', 'size', 'category', 'subcategory', 'photo', 'photo1', 'photo2', 'photo3', 'photo4',
                    #'alem_id'
                    )

    def alem_id(self, obj):
        if obj.category:
            if obj.subcategory:
                return mark_safe(str(obj.category.id)+obj.ai.ai+str(obj.subcategory.id))
            else:
                return '-'

admin.site.register(Favorites, FavoritesAdmin)

admin.site.site_title = 'Alem',
admin.site.site_title = 'Alem',
