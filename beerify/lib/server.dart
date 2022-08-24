import 'dart:typed_data';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';
import 'dart:io' as Io;
import 'dart:convert';

var db, beers, beerresult;
var fileKey, filename, fileBinaryKey, fileBinaryData;

Future<bool> connect() async {
  db = await Db.create(
      'mongodb+srv://VTibi:12345@beerifydb.yyvtc.mongodb.net/Breefy-Database?retryWrites=true&w=majority');
  await db.open();
  if (db != null) {
    return true;
  }
  return false;
}

Future<bool> login(String username, String password) async {
  final users = db.collection('Users');
  final userDatas = await users.findOne(
      where.eq("userName", username).and(where.eq("password", password)));
  if (userDatas == null) {
    return false;
  }
  return true;
}

Future<bool> register(String firstname, String lastname, String username, String password) async {
  final users = db.collection('Users');
  final result = await users.findOne(where.eq("userName", username));

  if (result == null) {
    //hogyha nincs ilyen nevezetu username-unk az adatbazisban, akkor feltoltjuk az adatbazisba a Usert a meglevo adatokkal e ; gyutt.
    await users.insert({
      'userName': username,
      'password': password,
      'firstName': firstname,
      'lastName': lastname
    });
    return true;
  }

  //ide eljutok abban az esetben,ha mar van ilyen nevezetu Userem(resultban van adatok, nem ures!)
  return false;
}

class beerCardViewData{
   String? beerName;
   String? beerBrand;
   BsonBinary? imageBinary;

   beerCardViewData(String name, String brand, BsonBinary image){
     this.beerName = name;
     this.beerBrand = brand;
     this.imageBinary = image;
   }
}

Future<List> waitingToGetEveryBeerFromDatabase() async {
  List beerStringList = [];
  beers = db.collection('Beers');
  beerresult = await beers.find().toList();
  for (var v in beerresult) {
    Map<String, dynamic> kepfile = v['image'];
    var beerName = v['name'];
    var beerBrand = v['brand'];
    //var fileKey = kepfile.keys.first;
    //var filename = kepfile[fileKey];
    var fileBinaryKey = kepfile.keys.last;
    var fileBinaryData = kepfile[fileBinaryKey];
    if (isNotNumeric(fileBinaryData.toString())){
      //beerStringList.add(fileBinaryData);
      //1 sor: 3 elem(listaba): Kep, nev, brand
      beerStringList.add(beerCardViewData(beerName, beerBrand, fileBinaryData));
      print(beerName.toString());
      print(beerBrand.toString());
      print(fileBinaryData.toString());
      print("Next one:\n");
    }
    //print("filename: " + filename);
    //print("\nBinary Data: " + fileBinaryData.toString() + "\n");
  }
  return beerStringList;
}

bool isNotNumeric(String checktext) {
  final number = num.tryParse(checktext);
    if (number == null)
      return true;
    return false;
}