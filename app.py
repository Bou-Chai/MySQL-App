# ENGG 300
# Date created: December 2, 2024
# Date last modified: December 3, 2024
# Group 5 (Ali Chaudhary, Ali Awan, Tyseer Ammar Shahriar, Joe Biden)

import mysql.connector

cursor = None
connection = None
user = ""
host = "127.0.0.1"
database = "artsmuseum"
goodbye = "Good riddance..."
invalid_input = "Bad input bro.\n"

def login(user, host, database):
    while True:
        try:
            password = input("Enter password:")
            connection = mysql.connector.connect(user=user, password=password, host=host, database=database)
            cursor = connection.cursor()
            return (cursor, connection)
        except mysql.connector.errors.ProgrammingError as error:
            print(error)

def exec_query(cursor, query, tuple, field, search):
    try:
        cursor.execute(query)
        result = cursor.fetchall()

        if result:
            display_result(result)
        else:
            print(f"No {tuple} found with {field} {search}")
    except:
        print(f"No {tuple} found with {field} {search}")

# Function to display query result
def display_result(result):
    print("-----------------------------------------")
    for tuple in result:
        for field, desc in zip(tuple, cursor.description):
            print(f"{desc[0]}:")
            print(field)
            print()
    print("-----------------------------------------")

def execute_file(cursor, path):
    file = open(path, "r")
    sql_file = file.read()
    file.close()
    sql_commands = sql_file.split(";")

    for command in sql_commands:
        try:
            if command.strip() != "":
                cursor.execute(command)
        except IOError as msg:
            print(f"Command skipped: {msg}")

def general_interface(cursor):
    user_input = ""

    while True:
        user_input = input("Enter sql (or q to quit): ")
        try:
            # Enter q to quit
            if user_input == "q":
                print(goodbye)
                break
            elif user_input == "":
                continue

            cursor.execute(user_input)
        
        # Print errors
        except mysql.connector.Error as error:
            print(error)
            continue

        # Commit if database is changed
        if "delete" in user_input.lower() or "update" in user_input.lower() or "insert" in user_input.lower():
            connection.commit()

        # Display query reslut
        for tuple in cursor:
            print(tuple)

def guest_interface(cursor):
    while True:
        print("What are you looking for?")
        print("1. Art objects")
        print("2. Artists")
        print("3. Exhibitions")
        print("(Enter q to quit)")

        option = input()
        if option == "1":
            search_art_objects(cursor)
        elif option == "2":
            search_artists()
        elif option == "3":
            search_exhibitions()
        elif option == "q":
            return 0
        else:
            print(invalid_input)

def search_art_objects(cursor):
    while True:
        print("What are you looking for?")
        print("1. Permanent art objects")
        print("2. Borrowed art objects")
        print("(Enter b to go back a menu)")

        option = input()
        if option == "1":
            perm = True
        elif option == "2":
            perm = False
        elif option == "b":
            return 0
        else:
            print(invalid_input)

        search_art_type(cursor, perm)

def search_art_type(cursor, perm):
    while True:
        print("What are you looking for?")
        print("1. Paintings")
        print("2. Sculptures")
        print("3. Statues")
        print("4. Other")
        print("(Enter b to go back a menu)")

        if perm:
            ownership = "PERMANENT"
        else:
            ownership = "BORROWED"

        option = input()
        if option == "1":
            type = "PAINTING"
        elif option == "2":
            type = "SCULPTURE"
        elif option == "3":
            type = "STATUE"
        elif option == "4":
            type = "OTHER"
        elif option == "b":
            return 0
        else:
            print(invalid_input)
            continue

        print(f"Enter the art ID of the {type.lower()} you're looking for:")
        search = input()
        #query = f"SELECT * FROM (ART_OBJECTS AS A JOIN {ownership} AS PB ON A.ArtID=PB.ArtID) JOIN {type} as T ON T.ArtID=PB.ArtID WHERE T.ArtID='{search}'"

        exec_query(cursor, query, type.lower(), "id", search)
        try:
            cursor.execute(query)
            result = cursor.fetchall()

            if result:
                display_result()
            else:
                print(f"No {type.lower()} found with id {search}")
        except:
            print(f"No {type.lower()} found with id {search}")

def search_artists(cursor):
    while True:
        print("Enter artist name: ")
        name = input()

        query = f"SELECT * FROM ARTIST WHERE AName={name}"

        try:
            cursor.execute(query)
            result = cursor.fetchall()

            if result:
                display_result()
            else:
                print(f"No artist found with name {name}")
        except:
            print(f"No artist found with name {name}")


def search_exhibitions():
    pass



while True:
    # Prompt user for login
    print("Login as one of the following users (enter 1, 2, or 3 or q to quit)")
    option = input("1. Admin\n2. Data Entry\n3. Guest\n")

    if option == "1":
        cursor, connection = login("admin", host, database)

        # Ask user to enter commands or a file
        user_input = input("\n1. Enter sql commands\n2. Enter a path to an sql file to execute")
        if user_input == "1":
            general_interface(cursor)
        elif user_input == "2":
            path = input("Enter file path: ")
            execute_file(cursor, path)

    elif option == "2": 
        cursor, connection = login("de", host, database)
        general_interface(cursor)

    elif option == "3": 
        connection = mysql.connector.connect(user='guest', password='', host=host, database=database)
        cursor = connection.cursor()
        guest_interface(cursor)

    elif option == "q":
        print(goodbye)
        break

    else:
        print(invalid_input)

if connection != None:
    connection.close()
