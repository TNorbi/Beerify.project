from pymongo import MongoClient
import pymongo

def get_database():
    

    # Provide the mongodb atlas url to connect python to mongodb using pymongo
    CONNECTION_STRING = "mongodb+srv://VTibi:12345@beerifydb.yyvtc.mongodb.net/Breefy-Database?retryWrites=true&w=majority"

    client = MongoClient(CONNECTION_STRING)

    
    #Ide meg kell adni az adatbazis nevet
    return client['Breefy-Database']
# This is added so that many files can reuse the function get_database()
if __name__ == "__main__":    
    
    # Get the database
    dbname = get_database()
    item_details = dbname.Beers.find()
    for item in item_details:
        # This does not give a very readable output
        print(item)
    

    

    
    
