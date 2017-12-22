import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizcircle/RewardsListItem.dart';
import 'package:quizcircle/model/Reward.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsPage extends StatefulWidget {
  @override
  RewardsPageState createState() => new RewardsPageState();
}

class RewardsPageState extends State<RewardsPage> {

  List<Reward> rewards = new List();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  String _accessToken;
  String _url;

  @override
  void initState() async {
    await this.getSharedPreferences();
    this.getData();
  }

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.setState(() {
      _url = prefs.getString("url");
      _accessToken = prefs.getString("token");
    });
    print("get url = ${_url}");
    print("get token = ${_accessToken}");
  }

  Future<Null> getData() async {
    print("data url = ${_url}");
    print("data token = ${_accessToken}");
    http.Response response = await http.post(
      Uri.encodeFull("${_url}/api/rewards.json"),
      body: {"access_token": _accessToken},
      headers: {
        "Accept":"application/json"
      }
    );
    this.setState(() {
      rewards.clear();
      List l = JSON.decode(response.body);
      l.forEach((map) {
        print("processing");
        rewards.add(new Reward(map["id"].toInt(), map["name"], map["cost"].toInt(), map["description"]));
      });
    });
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    this.getData();
    new Timer(const Duration(seconds: 3), () { completer.complete(null); });
    return completer.future.then((_) { print("completed refreshing"); });
  }

  @override
  Widget build(BuildContext context) {
    if(rewards.length > 0) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Rewards"),
	  backgroundColor: Colors.green,
          actions: <Widget>[
	    new FlatButton(
	      child: new Row(
	        children: <Widget>[
	          new Icon(Icons.favorite, color: Colors.red),
	          new Text("100", style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
	      ])
	    ),
          ]
        ),
        body: new RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: new ListView(
            children: rewards.map((Reward reward) {
	      return new RewardsListItem(reward);
	    }).toList()
          )
        )
      );
    } else {
      print("no rewards");
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Rewards"),
        ),
        body: new Container(
          child: new Center(
            child: new Column(
	      mainAxisAlignment: MainAxisAlignment.center,
	      children: <Widget>[
	        new Icon(Icons.favorite),
	        new Text("Sorry, no rewards yet!"),
	      ]
            )
          )
        )
      );
    }
  }
}