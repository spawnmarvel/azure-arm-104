dict = {}
dict["key1"] = 123456
dict["key2"] = 456789
dict["key3"] = 789456
for k, v in dict.items():
    print(k, v)
print(dict.get("key2"))
rm_v = dict.pop("key3")
print(dict)
new_v = {"key4":99999}
dict.update(new_v)
print(dict)

# new clone

  