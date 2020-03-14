import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokemon extends StatefulWidget {

  final String name;
  final String url;
  final String image;
  final Color cardColor;

  Pokemon({Key key, this.name, this.url, this.image, this.cardColor}) : super (key: key);

  @override
  PokemonState createState() => PokemonState();
}

class PokemonState extends State<Pokemon> {

  List details;
  
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {

    var response = await http.get(
      Uri.encodeFull(widget.url),
      headers: {"Accept": "application/json"}
    );
    print(response.body);

    setState((){
      var convertDataToJson = json.decode(response.body);
      details = [
        convertDataToJson["id"],
        convertDataToJson["types"]
        ];
      print(details);
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.cardColor,
      // appBar: AppBar(
      //   title: Text("${widget.name.toUpperCase()}", style: TextStyle(color: Colors.black)),
      //   backgroundColor: Colors.yellow[500],
      //   centerTitle: true,
      // ),
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 30.0, right: 260.0,), 
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                        child: InkWell(
                          child: Center(
                            child: Icon(
                              IconData(58820, fontFamily: 'MaterialIcons', matchTextDirection: true),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.only(
                              topLeft:  const  Radius.circular(40.0),
                              topRight: const  Radius.circular(40.0)
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${widget.name[0].toUpperCase()}${widget.name.substring(1)}',
                              style: TextStyle(
                                color: Color(0xffff3838),
                                fontSize: 40, 
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Color(0xfff22222),
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                              ),
                            )
                          )
                        ),
                        Container(
                          height: 200.0,
                          width: 300.0,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Card( 
                                  color: Color(0xfffEA2027),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Name: ${widget.name[0].toUpperCase()}${widget.name.substring(1)}'),
                                  ),
                                ),
                                Card( 
                                  color: Color(0xfffEA2027),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "ID: ${details[0]}.",
                                    ),
                                  ),
                                ),
                                Card( 
                                  color: Color(0xfffEA2027),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Type: ${details[1][0]["type"]["name"]}.",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                             child: Image.network(
                               "${widget.image}",
                               width: 300.0,
                               fit:BoxFit.fill 
                             ),
                          ),
                        ),
                      ],
                    ),
                )
              ]
            ),   
          ),
        ),
      )
    );
    //}
  }
}