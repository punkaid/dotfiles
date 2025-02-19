from Printer import Printer
from Colors import Colors
import whois
import datetime
import dns.resolver
import ssl
import socket
import requests
from ipwhois import IPWhois
import pprint
# import json

class Pinger:

    domain = ''

    def __init__(self):
        self.printer = Printer()


    def ping(self):
        self.printer.header(self.domain)
        self.check_domain()
        self.check_ns()
        self.check_ssl()
        self.check_status()
        self.check_ping()
        self.check_mx()
        self.check_spf()
        self.check_dkim()
        self.check_txt()
        self.printer.footer(self.domain)


    def check_domain(self):
        self.printer.title("TESTING DOMAIN")

        self.lookup = whois.whois(self.domain)

        if not self.lookup.domain_name:
            self.printer.colored('This is not a regisered domain: ' + self.domain, '', Colors.fg.red)
            exit(1)

        # pprint.pp(self.lookup)

        self.printer.labeled('Registrar', self.lookup.registrar)
        self.printer.labeled('Reseller', self.lookup.reseller)

        created_date = self.clean_date(self.lookup.creation_date)
        updated_date = self.clean_date(self.lookup.updated_date)
        expired_date = self.clean_date(self.lookup.expiration_date)

        if created_date == None:
            self.printer.warning('Created', created_date)
        else:
            self.printer.labeled('Created', created_date)

        self.printer.labeled('Updated', updated_date)

        if expired_date == None:
            self.printer.warning('Expired', expired_date)
        else:
            difference = expired_date - datetime.datetime.now()

            if difference.days < 30:
                self.printer.danger('Expired', expired_date)
                self.printer.danger('Days', difference.days)
            elif difference.days < 60:
                self.printer.warning('Expired', expired_date)
                self.printer.warning('Days', difference.days)
            else:
                self.printer.success('Expired', expired_date)
                self.printer.success('Days', difference.days)


    def check_ns(self):
        self.printer.title("NS Check")

        if self.lookup.name_servers:
            for ns in self.lookup.name_servers:
                self.printer.labeled('NS', ns)
        else:
            results = dns.resolver.resolve(self.domain, 'NS')
            for r in results:
                self.printer.labeled('NS', r.to_text().upper())


    def check_ssl(self):
        self.printer.title("SSL Check")

        def ssl_expiry_datetime(hostname):
            ssl_dateformat = r'%b %d %H:%M:%S %Y %Z'
            context = ssl.create_default_context()
            context.check_hostname = False
            conn = context.wrap_socket(
                socket.socket(socket.AF_INET),
                server_hostname = hostname,
            )
            conn.settimeout(5)
            conn.connect((hostname, 443))
            ssl_info = conn.getpeercert()
            return datetime.datetime.strptime(ssl_info['notAfter'], ssl_dateformat)

        try:
            expire = ssl_expiry_datetime(self.domain)
            difference = expire - datetime.datetime.now()
            self.printer.labeled("Domain", self.domain)

            if difference.days < 30:
                self.printer.danger('Expired', expire.strftime("%Y-%m-%d"))
                self.printer.danger('Days', difference.days)
            elif difference.days < 60:
                self.printer.warning('Expired', expire.strftime("%Y-%m-%d"))
                self.printer.warning('Days', difference.days)
            else:
                self.printer.success('Expired', expire.strftime("%Y-%m-%d"))
                self.printer.success('Days', difference.days)

        except Exception as e:
            self.printer.colored(str(e), '', Colors.fg.red)


    def check_status(self):
        self.printer.title("STATUS Check")

        try:
            response = requests.get('http://' + self.domain, allow_redirects = True, timeout = 8)

            for r in response.history:
                self.printer.regular(Colors.fg.cyan + str(r.status_code), Colors.fg.darkgrey + r.url + Colors.fg.white + " => " + r.headers['Location'] + Colors.reset)

            if response.status_code == 200:
                self.printer.regular(Colors.fg.green + str(response.status_code), Colors.fg.white + response.url + Colors.reset)
            else:
                self.printer.regular(Colors.fg.red + str(response.status_code), response.url + Colors.reset)

            if len(response.history) > 1:
                self.printer.colored('Too many redirection', '', Colors.fg.red)

            if 'https' not in response.url:
                self.printer.colored('No redirection to https', '', Colors.fg.red)

        except Exception as x:
            self.printer.colored(type(x).__doc__, '', Colors.fg.red)


    def check_ping(self):
        self.printer.title("A Check")

        try:
            results = dns.resolver.resolve(self.domain, 'A')
            for r in results:
                self.printer.labeled(self.domain, r.to_text())
                ipwhois = IPWhois(r.to_text())
                res = ipwhois.lookup_rdap(depth=1)
                self.printer.labeled('Server', res['asn_description'])
        except Exception as x:
            self.printer.colored(type(x).__doc__, '', Colors.fg.red)
            self.printer.regular(x)


    def check_mx(self):
        self.printer.title("MX Check")

        try:
            results = dns.resolver.resolve(self.domain, 'MX')
            for r in results:
                self.printer.labeled('MX', r.to_text())

        except:
            self.printer.colored('No MX found on this domain', '', Colors.fg.red)


    def check_spf(self):
        self.printer.title("SPF Check")

        try:
            results = dns.resolver.resolve(self.domain, 'TXT')
            spf = False

            for r in results:
                txt = r.to_text()
                if 'spf' in txt:
                    spf = txt

            if spf:
                spfs = spf.split()
                for index in range(len(spfs)):
                    if index > 0: 
                        if ':' in spfs[index]:
                            info = spfs[index].split(':')
                            self.printer.labeled(info[0], info[1])
                        else:
                            self.printer.regular(spfs[index].replace('"', ''))

            else:
                self.printer.colored('No SPF found on this domain', '', Colors.fg.red)

        except:
            self.printer.colored('No SPF found on this domain', '', Colors.fg.red)


    def check_dkim(self):
        self.printer.title("DKIM Check")

        try:
            results = dns.resolver.resolve('default._domainkey.' + self.domain, 'TXT')
            for r in results:
                self.printer.labeled('default._domainkey.' + self.domain, r.to_text())

        except:
            self.printer.colored('No default DKIM found on this domain: default._domainkey.' + self.domain, '', Colors.fg.red)


    def check_txt(self):
        self.printer.title("TXT Check")

        try:
            results = dns.resolver.resolve(self.domain, 'TXT')
            results_count = 0
            for r in results:
                if 'spf' not in r.to_text():
                    results_count = results_count + 1
                    self.printer.labeled(self.domain, r.to_text())

            if results_count == 0:
                self.printer.colored('No other TXT found on this domain', '', Colors.fg.darkgrey)

        except:
            self.printer.colored('No other TXT found on this domain', '', Colors.fg.darkgrey)

    def clean_date(self, data):
        if isinstance(data, list):
            return data[0]
        else:
            return data