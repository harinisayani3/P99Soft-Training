with open("file1.txt","r") as f:
    print(f.read())
with open("file1.txt","r+") as f:
    print(f.read())
    f.write("hello")
    print(f.read())
with open("file1.txt","w") as f:
    f.write("welcome")
    