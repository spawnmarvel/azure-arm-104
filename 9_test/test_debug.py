rv = 10

def mult(x:int):
    global rv
    rv = x * 2
    return rv

print(rv)
print(mult(12))
print(rv)