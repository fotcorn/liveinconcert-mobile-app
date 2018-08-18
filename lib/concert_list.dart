import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data.dart';


class ConcertList extends StatelessWidget {
  ConcertList({Key key, this.rsvp}) : super(key: key);

  final String rsvp;
  final DateFormat formatter = new DateFormat('dd.MM.yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<Concert>>(
      future: fetchConcerts(rsvp: rsvp),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final concert = snapshot.data[index];
                return this.listItem(concert);
              });
        } else if (snapshot.hasError) {
          return new Text('Failed to fetch data');
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget listItem(Concert concert) {
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
                Expanded(
                    child: Text(
                  concert.location,
                  style: TextStyle(fontSize: 18.0),
                )),
                Text(formatter.format(concert.dateTime),
                    style: TextStyle(fontSize: 18.0)),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}
