from flask import Flask, render_template, request
import jwt
from datetime import datetime,timedelta

app = Flask(__name__)
SECRET_KEY="1234"
users = {
    "harini":"harini",
    "harika":"harika"
}
@app.route('/')
def home():
    return render_template("login.html")

@app.route('/login',methods=['POST'])
def login():
    username=request.form.get("username")
    password=request.form.get("password")
    stored_password = users.get(username)
    if not stored_password or password!=stored_password:
        return "Invalide Username or password"
    token = jwt.encode(
        {"user":username,"exp":datetime.utcnow()+timedelta(minutes=30)},
        SECRET_KEY,
        algorithm="HS256"
    )
    print(token)
    return "login Successful"

if __name__=="__main__":
    app.run(debug=True)

