from django.http import request
from django.shortcuts import render, get_object_or_404, redirect
from .models import Products, Brand, Size, Status, Subcategory, Color, Category, Gender, New, Messages, UserAlem, Orders, Favorites
from django.contrib import messages
from .forms import userRegisteration, userLoginForm, messageForm, orderForm, favoritesForm
from django.contrib.auth import login
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, DetailView, CreateView

from django.db.models import Count



def userRegister(request):
    if request.method == 'POST':
        form = userRegisteration(request.POST)
        if form.is_valid():
            user= form.save()
            login(request, user)
            return redirect('userLogin')
    else:
        form = userRegisteration()
    return render(request, 'userRegister.html', {"form": form})

def userLogin(request):
    if request.method == 'POST':
        form = userLoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('home')
    else:
        form = userLoginForm()
    return render(request, 'userLogin.html', {"form": form})

def brand(request):
    brand = Brand.objects.all()
    return render(request, 'brand/brand.html', {'brand':brand})

def category(request):
    category = Category.objects.all()
    return render(request, 'category/category.html', {'category':category})

def color(request):
    color = Color.objects.all()
    return render(request, 'color/color.html', {'color':color})


def gender(request):
    gender = Gender.objects.all()
    return render(request, 'gender/gender.html', {'gender':gender})

def lastids(request):
    products = Products.objects.all()
    cats = Category.objects.annotate(Count('products'))
    subs = Subcategory.objects.annotate(Count('products'))
    messages = Messages.objects.count();

    return render(request, 'lastids/lastids.html', {'products':products, 'cats':cats, 'subs':subs, 'messages':messages})



def orders(request):
    return render(request, 'orders/orders.html')

def size(request):
    size = Size.objects.all()
    return render(request, 'size/size.html', {'size':size})

def status(request):
    status = Status.objects.all()
    return render(request, 'status/status.html', {'status':status})

def subcategory(request):
    subcategory = Subcategory.objects.all()
    return render(request, 'subcategory/subcategory.html', {'subcategory':subcategory})

def user(request):
    user = UserAlem.objects.all()
    return render(request, 'user/user.html', {'user':user })


def index(request):
    products = Products.objects.all()
    categories = Category.objects.all()
    return render(request, 'index.html', {'products': products, 'title': 'products', 'categories': categories})

class messageView(CreateView):
    form_class = messageForm
    template_name = 'messages/messages.html'
    success_url = '/messages/'

    def get_context_data(self, **kwargs):
        context = super(messageView, self).get_context_data(**kwargs)
        context ['messages'] = Messages.objects.all()
        return context

    def form_valid(self, form):
        form.instance.user =self.request.user
        return super().form_valid(form)

class catView(ListView):
    model = Category
    template_name = 'products/cat_list.html'
    context_object_name = 'categories'


class subView(ListView):
    model = Subcategory
    template_name = 'products/sub_list.html'
    context_object_name = 'subcategories'


class proView(ListView):
    model = Products
    template_name = 'products/pro_list.html'
    context_object_name = 'products'

    def get_queryset(self):
        return Products.objects.filter( subcategory_id=self.kwargs['subcategory_id'], )


class infoView(DetailView):
    model = Products
    template_name = 'products/info_list.html'
    context_object_name = 'info'

class orderView(CreateView):

    form_class = orderForm
    template_name = 'orders/orders.html'
    success_url = '/cat/'
    context_object_name = 'orderView'

    def form_valid(self, form):
        form.instance.name_id= self.kwargs['name']
        form.instance.ai_id=self.kwargs['ai']
        form.instance.user =self.request.user
        return super().form_valid(form)

class favoritesView(CreateView):
    form_class = favoritesForm
    template_name = 'products/info_list.html'
    success_url = '/cat/'
    context_object_name = 'favoritesView'

    def form_valid(self, form):
        #form.instance.name_id= self.kwargs['name']
        #form.instance.ai_id=self.kwargs['ai']
        #form.instance.color_id = self.kwargs['color']
        #form.instance.category_id = self.kwargs['category']
        #form.instance.subcategory_id = self.kwargs['subcategory']
        #form.instance.size_id = self.kwargs['size']
        form.instance.user =self.request.user

        return super().form_valid(form)

def orderlistView(request):
    orderlist = Orders.objects.all()
    return render(request, 'orders/user_orders.html', {'list':orderlist })

def favlistView(request):
    favlist= Favorites.objects.all()
    return render(request, 'favorites/fav_list.html', {'list':favlist })

























