from flask import Flask

application = Flask(__name__)

@application.route("/")
def show_html_page():
    myfile = open("Page.html", mode='r')
    page   = myfile.read()
    myfile.close()
    return page


#--------Main------------------
if __name__ == "__main__":
#    application.debug = True
#    application.env   = "Working Hard"
    application.run()
#------------------------------