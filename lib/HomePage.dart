import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Pokemon.dart';

class HomePage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final String url = 'https://pokeapi.co/api/v2/pokemon/';
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
    print(response.body);

    setState((){
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
      
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    if(data == null) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Loading..."),
        ),
      );
    } else { 
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokémon List', 
          style: TextStyle(
            fontSize: 32, 
            color: Color(0xfff3d3d3d),
          )
        ),
        backgroundColor: Colors.yellow[500],
        centerTitle: true
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          var cardColor;
          if(index % 2 == 0) {
            if(index % 4 == 0) {
              cardColor = Color(0xff6F1E51);
            } else {
              cardColor = Color(0xff11289A7);
            }
          } else {
            if(index % 3 == 0){
              cardColor = Color(0xffFFC312);
            } else {
              cardColor = Color(0xffA3CB38);
            }
          }
          return Container(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 25.0, right: 25.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (BuildContext context)  => Pokemon(
                              name: data[index]['name'],
                              cardColor: cardColor,
                              url: data[index]['url'], 
                              image: 'https://pokeres.bastionbot.org/images/pokemon/${index + 1}.png'
                            ), 
                          )
                        );
                      },
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.all(Radius.circular(50.0)),
                              ),
                              height: 50.0,   
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(data[index]['name'].toUpperCase(), style: TextStyle( fontSize: 23, color: Colors.white, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                            Container(  
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Image.network(
                                  'https://pokeres.bastionbot.org/images/pokemon/${index + 1}.png',
                                  height: 280.0,
                                  width: 300.0,
                                  fit: BoxFit.fill, 
                                ),
                              ),
                            ),
                          ],
                        )
                      )
                    )
                  )
                ],
              )
            )
          );
        }
      )
    );
    }
  }
}