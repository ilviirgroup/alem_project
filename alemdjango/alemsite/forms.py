from .models import UserAlem, Messages, Orders, Color, Size, Category, Favorites, Brand
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django import forms


class userRegisteration(UserCreationForm):
    email = forms.EmailField(label='Email:', widget=forms.EmailInput(attrs={'class': 'form-control'}))
    username = forms.CharField(label='Ady:', widget=forms.TextInput(attrs={'class': 'form-control'}))
    phone = forms.IntegerField(label='Telefon no:', widget=forms.NumberInput(attrs={'class': 'form-control'}))
    password1 = forms.CharField(label='Parol:', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    password2 = forms.CharField(label='Parol gaytadan:', widget=forms.PasswordInput(attrs={'class': 'form-control'}))

    class Meta:
        model = UserAlem
        fields = ('email', 'username', 'phone', 'password1', 'password2')

class userLoginForm(AuthenticationForm):
    username = forms.CharField(label='Ady:', widget=forms.TextInput(attrs={'class': 'form-control'}))
    password = forms.CharField(label='Parol:', widget=forms.PasswordInput(attrs={'class': 'form-control'}))

class messageForm(forms.ModelForm):
    class Meta:
        model = Messages

        fields = ['text',]
        widgets = {
            'text': forms.Textarea(attrs={'class': 'form-control'}),
        }

class orderForm(forms.ModelForm, ):
    class Meta:
        model = Orders
        fields = [ 'size', 'color','quantity', 'completed']

class favoritesForm(forms.ModelForm):
    class Meta:
        model = Favorites
        fields = ['name']

class brandForm(forms.ModelForm):
    class Meta:
        model = Brand
        fields = ['name']





