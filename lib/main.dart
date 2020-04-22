import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gotapp/episodes_page.dart';
import 'package:http/http.dart' as http;

import 'got.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";

  GOT got;

  Widget myCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: "g1",
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(got.image.original),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              got.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.green),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Runtime: ${got.runtimeType.toString()}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(got.summary,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,

                    MaterialPageRoute(builder: (context)=> EpisodesPage(
                      episodes: got.eEmbedded.episodes, myImage: got.image,
                    ))
                );
              },
              color: Colors.red,
              child: Text(
                "All Episodes",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget myBody() {
    return got == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : myCard();
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  void fetchEpisodes() async {
    var res = await http.get(url);
    var decodedRes = jsonDecode(res.body);
    got = GOT.fromJson(decodedRes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game OF Thrones"),
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          fetchEpisodes();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
