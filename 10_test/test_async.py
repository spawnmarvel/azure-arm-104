async def a_hi(name):
    return "Hi async function " + name

def hi(name):
    return "Hi function " + name

print(hi("Normal"))

# print(a_hi("test func")) # cannot call it as normal function, is must be drived my another function

def drive_a_hi(corutine):
    try:
        corutine.send(None)
    except StopIteration as e:
        return e

print(drive_a_hi(a_hi("Async")))