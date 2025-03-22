from django.db import models

# Create your models here.

MESSAGE_TYPE = (
    ("SIGNUP","SIGNUP"),
    ("SUBSCRIPTION","SUBSCRIPTION"),
    ("LENDING","LENDING")
)

class User(models.Model):
    user_id = models.IntegerField()
    username = models.CharField(max_length=128)
    email = models.EmailField(max_length=255)
    is_superuser = models.BooleanField(default=False)
class Notification(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message = models.TextField()
    message_type = models.CharField(max_length=255, choices=MESSAGE_TYPE)