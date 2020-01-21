import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'map.dart';

void main()=>runApp(MyApp());

String url = 'https://swapi.co/api/people/';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Data> _datas = List<Data>();

  @override
  void initState() {
    getDataFromHttp().then( (data){
      setState(() {
        _datas.addAll(data);
      });
      print(data[0].name);
      print("Printed");
    });
    super.initState();
  }

  Future<List<Data>> getDataFromHttp() async{

    http.Response res = await http.get(url);

    List details = List<Data>();

    if(res.statusCode==200){
      var decodedData = jsonDecode(res.body)['results'];
      for(var i in decodedData){
        details.add(Data.fromJson(i));
      }
    }
    return details;

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
                          data[i].name,
                          style: TextStyle(fontSize: 24.0)
                          ,),
                        Column(
                          children: <Widget>[
                            Container(
                              height:120.0,
                              child: ListView.builder(
                                itemCount: data[i].films.length,
                                itemBuilder: (BuildContext context,int i1){
                                  return Container(
                                    child: Text(data[i].films[i1]),
                                  );
                                },
                            )
                              ,)
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
        appBar: AppBar(
          title: Text("List"),
        ),
        body: _datas == null ? spinner() : listViewer(_datas)
      ),
    );
  }
}

