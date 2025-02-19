from Colors import Colors
import math
import pprint
import datetime

class Printer:

    line_width = 80


    def colored(self, txt, bg, fg):
        self.regular(bg + fg + str(txt) + Colors.reset)


    def labeled(self, title, value):
        self.regular(Colors.fg.darkgrey + str(title) + Colors.reset, str(value))


    def title(self, txt):
        title = " --- " + txt + " "
        to_add = self.line_width - len(title)
        title = title + "-"*(to_add-1) + " "
        title = Colors.bg.darkgrey + Colors.fg.black + str(title) + Colors.reset
        print(title)


    def success(self, title, value):
        self.labeled(str(title), Colors.fg.green + str(value) + Colors.reset)


    def warning(self, title, value):
        self.labeled(str(title), Colors.fg.yellow + str(value) + Colors.reset)


    def danger(self, title, value):
        self.labeled(str(title), Colors.fg.red + str(value) + Colors.reset)


    def regular(self, *args):
        print(*args)


    def header(self, domain):
        print()
        print("TESTING DOMAIN" + " : " + Colors.fg.magenta + domain.lower() + Colors.reset)
        print()


    def footer(self, domain):
        print(Colors.bg.darkgrey + Colors.fg.black + " "*self.line_width + Colors.reset)
        domain = " " + domain
        date = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') + " "
        spacer = self.line_width - (len(domain) + len(date))
        print(Colors.bg.darkgrey + Colors.fg.black + domain + " "*spacer + date + Colors.reset)
        print(Colors.bg.darkgrey + Colors.fg.black + " "*self.line_width + Colors.reset)