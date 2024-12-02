# ENGG 300
# Date created: December 2, 2024
# Date last modified: December 2, 2024
# Group 5 (Ali Chaudhary, Ali Awan, Tyseer Ammar Shahriar, Joe Biden)

import mysql.connector

host = "127.0.0.1"
database = "joe"

# Prompt user for login
print("Login as one of the following users (enter 1, 2, or 3)")
option = input("1. Admin\n2. Data Entry\n 3. Guest\n")

if option == "1": 
    connection = mysql.connector.connect(user='root', password='root', host=host, database=database)
elif option == "2": 
    connection = mysql.connector.connect(user='de', password='cleartext', host=host, database=database)
elif option == "3": 
    connection = mysql.connector.connect(user='guest', password='', host=host, database=database)
else:
    print("Bad input bro.")



connection = mysql.connector.connect(user='root', password='root', host='127.0.0.1', database='company')

cursor = connection.cursor()
cursor.execute("SELECT * FROM EMPLOYEE")
print(cursor.fetchall()[0][0])

connection.close()

def admin_interface():
    user_input = ""

    while user_input != "q":
        cursor.execute(user_input)

        # Commit if database is changed
        if "delete" or "update" or "insert" in user_input.lower():
            connection.commit()

        # Display query reslut
        for tuple in cursor:
            print(tuple)
