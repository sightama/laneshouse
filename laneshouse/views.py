from django.shortcuts import render
from django.http import HttpResponse, StreamingHttpResponse, Http404
from django.conf import settings
from os import listdir
from os.path import isfile, join


def index(request):
    return render(request, 'index.html', {})


def css(request, templatefile):
    return render(request, 'css/' + templatefile, {})


def viewer(request, templatefile):
    return render(request, 'view/' + templatefile, {})
