import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NewConcerts extends StatefulWidget {
  NewConcerts({Key key}) : super(key: key);

  @override
  _NewConcertsState createState() => new _NewConcertsState();
}

class Concert {
  final String artist;
  final String location;
  final DateTime dateTime;

  Concert({this.artist, this.location, this.dateTime});

  factory Concert.fromJson(Map<String, dynamic> json) {
    return Concert(
      artist: json['node']['event']['artist']['name'],
      location: json['node']['event']['location'],
      dateTime: DateTime.parse(json['node']['event']['dateTime']),
    );
  }
}

Future<List<Concert>> fetchConcerts() async {
  final response = await http.post('http://10.0.0.27/graphql/');
  if (response.statusCode == 200) {
    final body = json.decode(response.body);

    List<Concert> concerts = new List();
    for (var concert in body['data']['eventRsvps']['edges']) {
      concerts.add(Concert.fromJson(concert));
    }
    return concerts;
  } else {
    throw new Exception('failed to fetch concerts');
  }
}

class _NewConcertsState extends State<NewConcerts> {
  final DateFormat formatter = new DateFormat('dd.MM.yyyy HH:mm');
  final List<Concert> concerts = new List();

  @override
  void initState() {
    super.initState();
    concerts.add(new Concert('Metallica', 'Wankdorfstation', new DateTime(2018, 08, 16, 20, 30, 0)));
    concerts.add(new Concert('Rammstein', 'Allmend Luzern', new DateTime(2018, 08, 16, 20, 30, 0)));
    concerts.add(new Concert('Heaven Shall Burn', 'Bierhübeli', new DateTime(2018, 08, 16, 20, 30, 0)));
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: this.concerts.length,
      itemBuilder: (context, index) {
        final concert = this.concerts[index];
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  concert.artist,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
              ),
              Row(
                children: [
                  Text(
                    concert.location,
                    style: TextStyle(fontSize: 18.0)
                  ),
                  Text(
                    formatter.format(concert.dateTime),
                    style: TextStyle(fontSize: 18.0)
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
                
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        );
      }
    );
  }
}
