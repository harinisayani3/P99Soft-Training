from fastapi import FastAPI
from pydantic import BaseModel
app=FastAPI()

@app.get("/")
def my_api():
    return {"message":"api created"}

class User(BaseModel):
    age:int

@app.post("/")
def my_post_api(body:str):
    return body

@app.post("/user/{id}")
def func_1(id:int):
    return {"message":f"user{id} created"}

@app.post("/user")
def func_2(user:User):
    return user