from pymongo import MongoClient
import pymongo

def get_database():
    

    # Provide the mongodb atlas url to connect python to mongodb using pymongo
    CONNECTION_STRING = "mongodb+srv://VTibi:12345@beerifydb.yyvtc.mongodb.net/Breefy-Database?retryWrites=true&w=majority"

    client = MongoClient(CONNECTION_STRING)

    dbname = client['Breefy-Database']
    #Ide meg kell adni az adatbazis nevet


    return dbname
# This is added so that many files can reuse the function get_database()


def help():
    print(
        "returns db\n\nex: item_details = dbname.Beers.find() \n for item in item_details:\n# This does not give a very readable output\n        print(item)")


    

    

    
    
