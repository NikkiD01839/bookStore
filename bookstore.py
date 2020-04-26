from flask import Flask, render_template, request, session, logging, url_for, redirect, flash
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

from flask_mail import Mail, Message
from itsdangerous import URLSafeTimedSerializer, SignatureExpired

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
app.config.from_pyfile('config.cfg')

mail = Mail(app)

s = URLSafeTimedSerializer('key')


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
        secure_ccnum = sha256_crypt.encrypt(str(ccnum))
        expdate = request.form.get("expdate")
        ccv = request.form.get("ccv")
        cctype = request.form.get("cctype")

        billadd = request.form.get("billadd")

        # trying to add to paymentCard table in database
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
            db.commit()
            # sqlformula = "INSERT INTO users (first_name, last_name, email, pass) VALUES (%s,%s,%s,%s)"
            # new_user = (fname, lname, email, secure_password)
            # mycursor.execute(sqlformula,new_user)
            if request.form.get("ccnum") and request.form.get("expdate") and request.form.get("ccv") and request.form.get("cctype") and request.form.get("billadd"):
                userId = db.execute("SELECT id FROM users WHERE email=:email", {
                                    "email": email}).fetchone()
                name_on_card = fname + " " + lname

                db.execute("INSERT INTO paymentcard (cardNumber, type, exp_date, bill_add, name_on_card, ccv, userId) VALUES (:ccnum, :cctype, :expdate, :billadd, :name_on_card, :ccv, :userId)", {
                           "ccnum": secure_ccnum, "cctype": cctype, "expdate": expdate, "billadd": billadd, "name_on_card": name_on_card, "ccv": ccv, "userId": userId[0]})
                db.commit()

            email = request.form['email']
            token = s.dumps(email, salt='email-confirm')

            msg = Message('Confirm Email',
                          sender='4050bookstore@gmail.com', recipients=[email])

            link = url_for('confirm_email', token=token, _external=True)

            msg.body = 'Your confirmation link is {}'.format(link)
            mail.send(msg)
            session["email"] = email
            flash(
                "A confirmation email has been sent. Please confirm your email.", "success")
            return render_template("bookRegistration.html")

        else:
            flash("Passwords do not match", "danger")
            return render_template("bookRegistration.html")

    return render_template("bookRegistration.html")

# confirmation email
@app.route('/confirm_email/<token>')
def confirm_email(token):
    try:
        email = session["email"]
        db.execute("UPDATE users SET status = 'Active' WHERE email=:email", {
                   "email": email})
        db.commit()
        email = s.loads(token, salt='email-confirm')
        flash("You are registered. Please login", "success")
        return redirect(url_for('login'))
    except SignatureExpired:
        flash("The link has expired. Please register again.", "danger")
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
        status = db.execute("SELECT status FROM users WHERE email=:email AND status='Inactive'", {
            "email": email}).fetchone()

        if emaildata is None:
            flash("Email not found. Please try again.", "danger")
            return render_template("bookLogin.html")
        elif status is not None:
            flash("Please confirm you account through your email.", "danger")
            return render_template("bookLogin.html")
        else:
            for password_data in passwordData:
                if sha256_crypt.verify(password, password_data):
                    session["log"] = True
                    # login as admin if userTypeData returns a value which it only does if usertype equals 1
                    if userTypeData is not None:
                        flash("You are logged in as an admin.")
                        return redirect(url_for('admin'))
                    flash("You are logged in.")
                    session["USER"] = email
                    return render_template("bookHome.html")
                else:
                    flash("Incorrect password", "danger")
                    return render_template("bookLogin.html")
    return render_template("bookLogin.html")

# logout
@app.route("/logout")
def logout():
    session.clear()
    flash("You are logged out", "success")
    return redirect(url_for('login'))

# admin
@app.route("/admin")
def admin():
    return render_template("bookAdminLogin.html")

# forget password
@app.route("/forget_password", methods=["GET", "POST"])
def forget_password():
    if request.form.get("email"):
        email = request.form['email']

        emaildata = db.execute("SELECT email FROM users WHERE email=:email", {
            "email": email}).fetchone()

        if emaildata is None:
            flash("Email not found. Please try again.", "danger")
            return render_template("forgetPassword.html")
        else:
            new_password = sha256_crypt.encrypt(str('new_password'))
            db.execute("UPDATE users SET pass=:password WHERE email=:email", {
                       "password": new_password, "email": email})
            db.commit()
            msg = Message('Forget Password',
                          sender='4050bookstore@gmail.com', recipients=[email])
            msg.body = 'Your new password is: new_password'

            mail.send(msg)
            flash("Your password was sent to your email.", "success")
            return redirect(url_for('login'))
    return render_template("forgetPassword.html")

# change password
@app.route("/change_password", methods=["GET", "POST"])
def change_password():
    email = session['USER']
    password = request.form.get("oldpassword")
    newpassword = request.form.get("newpassword1")
    confirmpassword = request.form.get("newpassword2")

    passwordData = db.execute("SELECT pass FROM users WHERE email=:email", {
        "email": email}).fetchone()

    if sha256_crypt.verify(password, passwordData[0]):
        if newpassword == confirmpassword:
            secure_password = sha256_crypt.encrypt(str(newpassword))
            db.execute("UPDATE users SET pass=:password WHERE email=:email", {
                "password": secure_password, "email": email})
            db.commit()
            flash("Your password has been changed.", "success")
            return render_template("bookViewAccount.html")
        else:
            flash("Passwords do not match.", "danger")
            return render_template("changePassword.html")
    else:
        flash("Incorrect password", "danger")

    return render_template("changePassword.html")

# view/edit profile
@app.route("/user", methods=["GET", "POST"])
def account():
    email = session['USER']

    userId = db.execute("SELECT id FROM users WHERE email=:email", {
        "email": email}).fetchone()
    address = db.execute("SELECT bill_add FROM paymentcard WHERE userId=:userId", {
                         "userId": userId[0]}).fetchone()

    if address is None:
        data = db.execute(
            "SELECT * FROM users WHERE email=:email", {"email": email}).fetchall()
    else:
        data = db.execute("SELECT * FROM users,paymentcard WHERE users.id=paymentcard.userid and users.email=:email", {
            "email": email}).fetchall()

    if request.method == "POST":
        email = session["USER"]

        if request.form.get("fname"):
            fname = request.form.get("fname")
            db.execute("UPDATE users SET first_name=:fname WHERE email=:email", {
                       "fname": fname, "email": email})
            db.commit()
            flash("First name updated", "success")
            return redirect(url_for('account'))
        elif request.form.get("lname"):
            lname = request.form.get("lname")
            db.execute("UPDATE users SET last_name=:lname WHERE email=:email", {
                       "lname": lname, "email": email})
            db.commit()
            flash("Last name updated", "success")
            return redirect(url_for('account'))
        elif request.form.get("address"):
            address = request.form.get("address")
            db.execute("UPDATE paymentcard SET bill_add=:address WHERE userId=:userId", {
                       "address": address, "userId": userId[0]})
            db.commit()
            flash("Address updated", "success")
            return redirect(url_for('account'))
        elif request.form.get("cardType"):
            cardType = request.form.get("cardType")
            db.execute("UPDATE paymentcard SET type=:cardType WHERE userId=:userId", {
                       "cardType": cardType, "userId": userId[0]})
            db.commit()
            flash("Card type updated", "success")
            return redirect(url_for('account'))
        elif request.form.get("ccnum"):
            ccnum = request.form.get("ccnum")
            secure_ccnum = sha256_crypt.encrypt(str(ccnum))
            db.execute("UPDATE paymentcard SET cardNumber=:ccnum WHERE userId=:userId", {
                       "ccnum": secure_ccnum, "userId": userId[0]})
            db.commit()
            flash("Card number updated", "success")
            return redirect(url_for('account'))
        elif request.form.get("ccv"):
            ccv = request.form.get("ccv")
            db.execute("UPDATE paymentcard SET ccv=:ccv WHERE userId=:userId", {
                       "ccv": ccv, "userId": userId[0]})
            db.commit()
            flash("CCV updated", "success")
            return redirect(url_for('account'))

    return render_template("bookViewAccount.html", data=data)

# viewBooks
@app.route("/viewBooks")
def viewBooks():
    data = db.execute("SELECT title,author,pic_location FROM books").fetchall()
    return render_template("bookViewBooks.html", data=data)

# book details
@app.route("/viewBook/<title>", methods=["GET", "POST"])
def viewBook(title):
    data = db.execute("SELECT title,author,pic_location,price,rating,synopsis,genre,ISBN FROM books WHERE title=:title", {
                      "title": title}).fetchall()
    return render_template("bookViewBook.html", data=data)

# add book
@app.route("/addBook", methods=["GET", "POST"])
def addBook():
    if request.method == "POST":
        title = request.form.get("title")
        author = request.form.get("author")
        price = request.form.get("price")
        rating = request.form.get("rating")
        genre = request.form.get("genre")
        isbn = request.form.get("isbn")
        synopsis = request.form.get("synopsis")
        pic = request.form.get("pic")
        edition = request.form.get("edition")
        publisher = request.form.get("publisher")
        pubYear = request.form.get("pubYear")
        sellPrice = request.form.get("sellPrice")

        db.execute("INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location, edition, publisher, pubYear, salePrice) VALUES (:title, :author, :price, :rating, :genre, :isbn, :synopsis, :pic, :edition, :publisher, :pubYear, :salePrice)",
                   {
                       "title": title, "author": author, "price": price,
                       "rating": rating, "genre": genre, "isbn": isbn,
                       "synopsis": synopsis, "pic": pic, "edition": edition,
                       "publisher": publisher, "pubYear": pubYear, "salePrice": sellPrice})

        db.commit()
        flash("Book Added", "success")
    return render_template("manageBooks.html")

# manage books
@app.route("/manageBooks", methods=["GET", "POST"])
def manageBooks():
    return render_template("manageBooks.html")

# view add to cart
@app.route("/addToCart/<title>", methods=["GET", "POST"])
def addToCart(title):
    email = session['USER']
    userId = db.execute("SELECT id FROM users WHERE email=:email", {
        "email": email}).fetchone()
    bookId = db.execute("SELECT id FROM books WHERE title=:title", {
        "title": title}).fetchone()
    data = db.execute("SELECT title,author,pic_location,price,rating,synopsis,genre,ISBN FROM books WHERE title=:title", {
                      "title": title}).fetchall()
    db.execute("INSERT INTO cart (userId, bookId) VALUES (:userId, :bookId)", {"userId": userId[0], "bookId": bookId[0]})
    db.commit()
    flash("Book added to Cart", "success")
    return render_template("bookViewBook.html", data=data)

# view cart
@app.route("/cart", methods=["GET", "POST"])
def cart():
    email = session['USER']
    userId = db.execute("SELECT id FROM users WHERE email=:email", {
        "email": email}).fetchone()
    bookId = db.execute("SELECT bookId FROM cart WHERE userId=:userId", {
                      "userId": userId[0]}).fetchall()
    data = []
    for x in bookId:
        data.append(db.execute("SELECT title,price,pic_location FROM books WHERE id=:bookId", {
                      "bookId": x[0]}).fetchall())
                      
    return render_template("viewCart.html", data=data)


if __name__ == "__main__":
    app.secret_key = "key"
    app.run(debug=True)
