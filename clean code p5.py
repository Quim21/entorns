#PY05 Type error
# Wrong code
age = input("Insert your age: ")
result = age + 5
print(result)
# Correct Version
age = int(input("Insert your age: "))
result = age + 5
print(result)