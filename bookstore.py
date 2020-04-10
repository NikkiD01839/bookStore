from flask import Flask, render_template, request, session, logging, url_for, redirect
from passlib.hash import sha256_crypt
import mysql.connector

bookdb = mysql.connector.connect(host='localhost',
                                 user='root',
                                 passwd='password',
                                 auth_plugin='mysql_native_password',
                                 database='bookstore')

mycursor = bookdb.cursor()

mycursor.execute("SHOW TABLES")

for table in mycursor:
    print(table)

app= Flask(__name__)

@app.route("/")
def home():
    return render_template("bookHome.html")


#registration form
@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        fname = request.form.get("fname")
        lname = request.form.get("lname")
        email = request.form.get("email")
        password = request.form.get("password")
        confirm = request.form.get("confirm")
        secure_password = sha256_crypt.encrypt(str(password))
        ccnum = request.form.get("ccnum")
        expdate = request.form.get("expdate")
        ccv = request.form.get("ccv")

        #if password == confirm:
            #sql stuff!
    return render_template("bookRegistration.html")


#login form
@app.route("/login",methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("password")

    return render_template("bookLogin.html")

@app.route("/user", methods=["GET","POST"])
def account():
    if request.method == "POST":
        if request.form.get("name"):
            print(request.form.get("name"))
        elif request.form.get("email"):
            print(request.form.get("email"))
        elif request.form.get("password"):
            print(request.form.get("password"))
        elif request.form.get("address"):
            print(request.form.get("address"))
        elif request.form.get("card"):
            print(request.form.get("card"))
    return render_template("bookViewAccount.html")

if __name__ == "__main__":
    app.run(debug=True)