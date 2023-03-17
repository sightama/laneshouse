from django.shortcuts import render
from ipware import get_client_ip
# from django.http import HttpResponse, StreamingHttpResponse, Http404
# from django.conf import settings
# from os import listdir
# from os.path import isfile, join
import logging

logger = logging.getLogger(__name__)


def index(request):
    ip, is_routable = get_client_ip(request)
    if ip is None:
        # Unable to get the client's IP address
        logger.info(f"Unable to retrieve the client's IP address for the below call")
    else:
        # We got the client's IP address
        logger.info(f"We got their IP! Below request made by {ip}")
        if is_routable:
            # The client's IP address is publicly routable on the Internet
            logger.info(f"The IP {ip} is also publicly routable on the Internet")
        else:
             # The client's IP address is private
             logger.info(f"The IP {ip} is private")

    # Order of precedence is (Public, Private, Loopback, None)
    return render(request, 'index.html', {})
