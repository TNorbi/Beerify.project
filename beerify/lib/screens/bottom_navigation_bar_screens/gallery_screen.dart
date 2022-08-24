import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:beerify/server.dart' as server;
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart' show BsonBinary;
import 'package:path_provider/path_provider.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key? key}) : super(key: key);

  initState() {}

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late List listOfTheBeers;
  late Future<List> photos;
  late int numberofphotos;
  List beerName = [];
  List beerBrand = [];
  List imageBinary = [];
  List images = [];
  String dummyphoto = "4pyTIMOgIGxhIG1vZGU=";

  //TODO: After the get, from database is corrected, show them instead of dummy photo.
  Future<List> getPhoto() async {
    var response = await server.waitingToGetEveryBeerFromDatabase();
    numberofphotos = response.length;
    return response;
  }

  Future<void> detailAnalizator(Future<List> photoanalize) async {
    listOfTheBeers = await photoanalize;
    for (var i = 0; i < numberofphotos; i++) {
      beerName.add(listOfTheBeers[i].beerName);
      beerBrand.add(listOfTheBeers[i].beerBrand);
      imageBinary.add(listOfTheBeers[i].imageBinary);
      //decodeBase64String(listOfTheBeers[i].imageBinary);
      var kep = await createImageFromBinary(listOfTheBeers[i].imageBinary);
      images.add(kep);
      //images.add(base64Decode(listOfTheBeers[i].imageBinary));
      //print(images.toString());
    }
  }

  Uint8List base64Decode(String source) => base64.decode(source);

  Image decodeBase64String(String phototoconvert) {
    final decodedBytes = base64Decode(phototoconvert);
    var file = Io.File("convertedphoto.jpg");
    file.writeAsBytes(decodedBytes);
    return Image.file(file);
  }

  Future<Image> createImageFromBinary(BsonBinary binary) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print("Kep pathje: " + tempPath + "/convertedphoto.jpg");
    var file = Io.File(tempPath + "/convertedphoto.jpg");
    var seged = file.openWrite();
    seged.write(binary);
    seged.close();
    return Image.file(file);
  }

  void initState() {
    super.initState();
    photos = getPhoto();
    //detailAnalizator(photos);
  }

  @override
  Widget build(BuildContext context) {
    var index = 1;
    return Scaffold(
      body: Center(
        child: Card(
          child: FutureBuilder(
            future: photos,
            //snapshot is the actual data, what you get from future
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: numberofphotos,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Scaffold(body: Container()),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              //leading: CircleAvatar(
                              //child: //Image.memory(base64Decode(dummyphoto)),
                              //TODO This works, except for paranthesis. Image.memory(decodeBase64String(snapshot.data[index].imageBinary.toString())),
                              //images[index].toString()),
                              // ),
                              title: Text(snapshot.data[index].beerName),
                              subtitle: Text(snapshot.data[index].beerBrand),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            },
            /*
          child: Column(
              //key: columnKey,
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  leading: new Image.memory(photo),
                  title: Text('Ciuc Premium'),
                  //subtitle: Text('Uploaded by: Username),
                ),
                TextButton(
                  child: const Text('Details'),
                  onPressed: () {},
                ),
              ],
            ),
           */
          ),
        ),
      ),
    );
  }
}
