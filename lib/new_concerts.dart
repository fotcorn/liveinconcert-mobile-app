import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewConcerts extends StatefulWidget {
  NewConcerts({Key key}) : super(key: key);

  @override
  _NewConcertsState createState() => new _NewConcertsState();
}

class Concert {
  Concert(this.artist, this.location, this.dateTime);
  String artist;
  String location;
  DateTime dateTime;
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
