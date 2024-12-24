# ENGG 300
# Date created: December 2, 2024
# Date last modified: December 9, 2024
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

        if cursor:
            display_result(cursor)
        else:
            print(f"No {tuple} found with {field} {search}")
    except:
        print(f"No {tuple} found with {field} {search}")


# Function to display query result
def display_result(cursor):
    print("-----------------------------------------")
    for tuple in cursor:
        for field, desc in zip(tuple, cursor.description):
            print(f"{desc[0]}:")
            print(field)
            print()
    print("-----------------------------------------")


def execute_file(cursor, path):
    try:
        file = open(path, "r")
    except:
        print("Could not find file")
        return(-1)

    sql_file = file.read()
    file.close()
    sql_commands = sql_file.split(";")

    for command in sql_commands:
        try:
            if command.strip() != "":
                cursor.execute(command)
        except Exception as msg:
            print(f"Command skipped: {msg}")
    
    return 0


def get_table_fields(cursor, table):
    query = f"SELECT * FROM {table} LIMIT 1;"
    fields = []

    try:
        cursor.execute(query)
        cursor.fetchall()
        description = cursor.description

        for desc in description:
            fields.append(desc[0])

        return fields

    except Exception as e:
        print(f"No table named {table}")
        return None


def modify_db(cursor):
    while True:
        print("1. Insert")
        print("2. Update")
        print("3. Delete")

        option = input()
        if option == "1":
            insert_db(cursor)
        elif option == "2":
            update_db(cursor)
        elif option == "3":
            delete_from_db(cursor)

        elif option == "q":
            return 0
        
def insert_db(cursor):
    while True:
        print("Enter the table you want to insert data into: ")

        table = input()
        if table == "q":
            return 0
        
        query = f"SELECT * FROM {table} LIMIT 1;"

        field_list = get_table_fields(cursor, table)
        if field_list == None:
            continue
        
        fields = "("
        field_values = "("
        for i in range(0, len(field_list) - 1):
            print(f"Enter {field_list[i]}: ")
            field_val = input()
            fields += field_list[i] + ", "
            field_values += "'" + field_val + "'" + ", "
        
        print(f"Enter {field_list[i + 1]}: ")
        field_val = input()

        fields += field_list[i + 1] + ")"
        field_values += "'" + field_val + "'" + ")"

        query = f"INSERT INTO {table} {fields} VALUES {field_values};"
        try:
            cursor.execute(query)
            cursor._connection.commit()
            
        except Exception as error:
            print("\nCannot insert:")
            print(error, "\n")
            continue
        
        print("Inserted successfully\n")


def update_db(cursor):
    while True:
        print("Enter the table you want to update: ")
        table = input()
        if table == "q":
            return 0

        field_list = get_table_fields(cursor, table)
        if field_list == None:
            continue
            
        print("\nTable fields:")
        print("|", end="")
        for field in field_list:
            print(field + "|", end="")

        try:
            print("\n")
            print("Enter a field name followed by = followed by your chosen value to specify what enrties to modify:")
            select_expression = input()
            # Make user entered value into a string
            split = select_expression.split("=")
            select_expression = split[0] + "=" + "'" + split[1].strip() + "'"
            
            print("Enter a field name followed by = followed by your chosen value to update the field:")
            set_expression = input()
            # Make user entered value into a string
            split = set_expression.split("=")
            set_expression = split[0] + "=" + "'" + split[1].strip() + "'"
        except:
            print("Invalid input")
            continue

        query = f"UPDATE {table} SET {set_expression} WHERE {select_expression}"
        try:
            cursor.execute(query)
            cursor.fetchall()
            if cursor.rowcount == 0:
                print("Did not update")
                continue
            cursor._connection.commit()
            
        except Exception as error:
            print("\nCannot update:")
            print(error, "\n")
            continue
        
        print("Updated successfully\n")

def delete_from_db(cursor):
    while True:
        print("Enter the table you want to delete from:")
        table = input()
        if table == "q":
            return 0

        field_list = get_table_fields(cursor, table)
        if field_list == None:
            continue
            
        print("\nTable fields:")
        print("|", end="")
        for field in field_list:
            print(field + "|", end="")

        try:
            print("\n")
            print("Enter a field name followed by = followed by your chosen value to specify what enrties to delete:")
            select_expression = input()
            # Make user entered value into a string
            split = select_expression.split("=")
            select_expression = split[0] + "=" + "'" + split[1].strip() + "'"
        except:
            print("Invalid input")
            continue

        query = f"DELETE FROM {table} WHERE {select_expression}"
        try:
            cursor.execute(query)
            cursor.fetchall()
            if cursor.rowcount == 0:
                print("Did not delete")
                continue
            cursor._connection.commit()
            
        except Exception as error:
            print("\nCannot delete:")
            print(error, "\n")
            continue
        
        print("Deleted successfully\n")


def admin_interface(cursor):
    while True:
        # Ask user to enter commands or a file
        print("1. Enter sql commands")
        print("2. Enter a path to an sql file to execute")

        user_input = input()
        if user_input == "1":
            while True:
                print("Enter sql:")
                user_input = input()
    
                # Enter q to quit
                if user_input == "q":
                    break
                elif user_input == "":
                    continue

                try:
                    cursor.execute(user_input)
            
                # Print errors
                except mysql.connector.Error as error:
                    print(error)
                    continue

                # Commit if database is changed
                if "delete" in user_input.lower() or "update" in user_input.lower() or "insert" in user_input.lower():
                    cursor._connection.commit()

                # Display query result
                for tuple in cursor:
                    print(tuple)

        elif user_input == "2":
            path = input("Enter file path: ")
            if path == "q":
                continue
            execute_file(cursor, path)
        
        elif user_input == "q":
            return 0


def de_interface(cursor):
    while True:
        print("1. Search database")
        print("2. Modify database")

        option = input()
        if option == "1":
            guest_interface(cursor)
        elif option == "2":
            modify_db(cursor)

        elif option == "q":
            return 0

def guest_interface(cursor):
    while True:
        print("What are you looking for?")
        print("1. Art objects")
        print("2. Artists")
        print("3. Exhibitions")

        option = input()
        if option == "1":
            search_art_objects(cursor)
        elif option == "2":
            search_artists(cursor)
        elif option == "3":
            search_exhibitions(cursor)
        elif option == "q":
            return 0
        else:
            print(invalid_input)

def search_art_objects(cursor):
    while True:
        print("What are you looking for?")
        print("1. Permanent art objects")
        print("2. Borrowed art objects")

        option = input()
        if option == "1":
            permanent = True
        elif option == "2":
            permanent = False
        elif option == "q":
            return 0
        else:
            print(invalid_input)

        search_art_type(cursor, permanent)

def search_art_type(cursor, permanent):
    while True:
        print("What are you looking for?")
        print("1. Paintings")
        print("2. Sculptures")
        print("3. Statues")
        print("4. Other")

        if permanent:
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
        elif option == "q":
            return 0
        else:
            print(invalid_input)
            continue
        
        # Prompt user
        print(f"Enter the art ID of the {type.lower()} you're looking for:")
        search = input()

        # Craft query and execute
        query = f"SELECT * FROM (ART_OBJECTS AS A JOIN {ownership} AS PB ON A.ArtID=PB.ArtID) JOIN {type} as T ON T.ArtID=PB.ArtID WHERE T.ArtID='{search}';"
        exec_query(cursor, query, type.lower(), "id", search)

def search_artists(cursor):
    while True:
        print("Enter artist name: ")
        name = input()

        if name == "q":
            return 0

        query = f"SELECT * FROM ARTIST WHERE AName='{name}';"
        exec_query(cursor, query, "artist", "name", name)

def search_exhibitions(cursor):
    while True:
        print("Enter exhibition start date: ")
        date = input()

        if date == "q":
            return 0

        query = f"SELECT * FROM EXHIBITION WHERE Start_date='{date}';"
        exec_query(cursor, query, "exhibition", "start date", date)

def main():
    while True:
        # Prompt user for login
        print("Welome to DDA (Dumb Database Application)")
        print("Note: Throughout most of the application enter 'q' to go back a menu or quit")
        print("Login as one of the following users (enter 1, 2, or 3)")
        option = input("1. Admin\n2. Data Entry\n3. Guest\n")

        if option == "1":
            cursor, connection = login("admin", host, database)
            admin_interface(cursor)

        elif option == "2": 
            cursor, connection = login("de", host, database)
            de_interface(cursor)

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

if __name__ == "__main__":
    main()
