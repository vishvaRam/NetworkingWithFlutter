import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=>runApp(MyApp());

String url = 'https://swapi.co/api/people/';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List data;
  List l;
  @override
  void initState() {
    getDataFromHttp();
    super.initState();
  }

  Future<String> getDataFromHttp() async{
      var temp;
      http.Response res = await http.get(url);
      var decoded = jsonDecode(res.body);
      if(res.statusCode == 200){
        temp = decoded['results'];
        print("200");
        setState(() {
          data = temp;
        });
      }
      else{
        print("404");
      }
      return 'Success';
  }

   Widget listViewer (dynamic data ){
    return ListView.builder(
      itemCount: data == null ? 0: data.length ,
      itemBuilder: (BuildContext context,int i){
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                    child: Column(
                      children: <Widget>[
                        Text(
                          data[i]['name'],
                          style: TextStyle(fontSize: 24.0)
                          ,),
                        Column(
                          children: <Widget>[
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        );
      },
    );
   }

    Widget spinner (){
          return Center(
            child: SpinKitDoubleBounce(
              color: Colors.blue,
              size: 55.0,
            ),
          );
    }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("List"),),
        body: data == null ? spinner() : listViewer(data)
      ),
    );
  }
}

