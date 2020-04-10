from flask import Flask, render_template, request, session, logging, url_for, redirect, flash
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

from passlib.hash import sha256_crypt
engine = create_engine("mysql+pymysql://root:password@localhost/bookstore")

db = scoped_session(sessionmaker(bind=engine))

#engine = create_engine("mysql+pymysql://username:password@localhost/databasename")
# import mysql.connector

# mydb = mysql.connector.connect(
#     host="localhost",
#     user="root",
#     passwd="password",  # you workbench local host password
#     auth_plugin='mysql_native_password',
#     database='bookstore'
# )

# mycursor = mydb.cursor()

# mycursor.execute("SHOW TABLES")
# for table in mycursor:
#     print(table)

app = Flask(__name__)

# homePage
@app.route("/")
def home():
    return render_template("bookHome.html")

# register
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
        cctype = request.form.get("cctype")
        billadd = request.form.get("billadd")

        #trying to add to paymentCard table in database
        # if ccnum is "":
        #     render_template("bookHome.html")

        emaildata = db.execute("SELECT email FROM users WHERE email=:email", {
            "email": email}).fetchone()

        if emaildata is not None:
            flash("Email taken", "danger")
            return render_template("bookRegistration.html")

        if password == confirm:
            db.execute("INSERT INTO users (first_name, last_name, email, pass) VALUES (:fname, :lname, :email, :password)", {
                       "fname": fname, "lname": lname, "email": email, "password": secure_password})
            # sqlformula = "INSERT INTO users (first_name, last_name, email, pass) VALUES (%s,%s,%s,%s)"
            # new_user = (fname, lname, email, secure_password)
            # mycursor.execute(sqlformula,new_user)
            if request.form.get("ccnum"):
                db.execute()
            elif request.form.get("expdate"):
                db.execute()
            elif request.form.get("ccv"):
                db.execute()
            elif request.form.get("cctype"):
                db.execute()
            elif request.form.get("billadd"):
                db.execute
            db.commit()
            flash("You are registered. Please login", "success")
            return redirect(url_for('login'))
        else:
            flash("Passwords do not match", "danger")
            return render_template("bookRegistration.html")

    return render_template("bookRegistration.html")

# login
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("password")

        emaildata = db.execute("SELECT email FROM users WHERE email=:email", {
            "email": email}).fetchone()
        passwordData = db.execute("SELECT pass FROM users WHERE email=:email", {
                                  "email": email}).fetchone()
        userTypeData = db.execute("SELECT userType FROM users WHERE email=:email AND userType=1", {
                                  "email": email}).fetchone()

        if emaildata is None:
            flash("Email not found. Please try again.", "danger")
            return render_template("bookLogin.html")
        else:
            for password_data in passwordData:
                if sha256_crypt.verify(password, password_data):
                    session["log"] = True
                    #login as admin if userTypeData returns a value which it only does if usertype equals 1
                    if userTypeData != None:
                        flash("You are logged in as an admin.")
                        return redirect(url_for('admin'))
                    flash("You are logged in.")
                    session["USER"] = email
                    return render_template("bookHome.html")
                else:
                    flash("Incorrect password", "danger")
                    return render_template("bookLogin.html")
    return render_template("bookLogin.html")

#logout
@app.route("/logout")
def logout():
    session.clear()
    flash("You are logged out", "success")
    return redirect(url_for('login'))

#admin
@app.route("/admin")
def admin():
    return render_template("bookAdminLogin.html")


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
    app.secret_key = "key"
    app.run(debug=True)
