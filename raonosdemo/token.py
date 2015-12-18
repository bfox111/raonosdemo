import os
from urlparse import urlparse, urlunparse
from bpprov.components.rest_auth import Auth

class BPAuth(Auth):

    schema_base = os.path.join(os.path.dirname(__file__), 'model', 'schema')
    schema = 'bp-auth.json'

    def start(self):
        pass

    def stop(self):
        pass

    def sign(self, url, body, headers):
        parsed = urlparse(url)
        query_params = parsed.query.split('&')
        query_params.append('token={}'.format(self.params['token']))
        parsed = parsed._replace(query='&'.join(query_params))
        url = urlunparse(parsed)
        return (url, body, headers)
