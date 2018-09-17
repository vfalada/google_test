import requests
import json

class Requests(object):
    def __init__(self, url, headers):
        self.url = url
        self.headers = headers  
    
    def request(self, method):
        self.r = requests.request(method, self.url, headers=json.loads(self.headers))
        return self.r.status_code, self.r.text

class Rest(object):

    ROBOT_LIBRARY_VERSION = 1.0

    def send_get_request(self, url, headers):
        self.conn = Requests(url, headers)
        self.code, self.text = self.conn.request("GET")
        
    def send_post_request(self, url, headers):
        self.conn = Requests(url, headers)
        self.code, self.text = self.conn.request("POST") 
        
    def get_response_code(self):
        return self.code
    
    def get_response_text(self):
        return self.text