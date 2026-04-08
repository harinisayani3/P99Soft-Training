from flask import Flask,jsonify,request
app=Flask(__name__)


@app.route("/")
def home():
    return "<h1>Welcome to home page</h1>"
#get
@app.route("/users",methods=["GET"])
def get_users():
    return jsonify({"users":["Harini","Harika"]})

#post
@app.route("/users",methods=["POST"])
def create_user():
    data=request.json
    return jsonify({"message":"User created","data":data})


if __name__=="__main__":
    app.run(debug=True)