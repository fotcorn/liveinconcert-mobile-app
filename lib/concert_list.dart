import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data.dart';

class ConcertList extends StatefulWidget {
  final String rsvp;

  ConcertList({Key key, this.rsvp}) : super(key: key);

  @override
  _ConcertListState createState() => new _ConcertListState(this.rsvp);
}

class _ConcertListState extends State<ConcertList> {

  _ConcertListState(this.rsvp);

  final String rsvp;
  final DateFormat formatter = new DateFormat('dd.MM.yyyy HH:mm');
  List<Concert> concerts = new List<Concert>();

  @override
  void initState() {
    super.initState();
    fetchConcerts(rsvp: this.rsvp).then((data) {
      setState(() {
        this.concerts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: this.concerts.length,
      itemBuilder: (context, index) {
        return this.listItem(index);
      });
  }

  Widget listItem(int index) {
    final concert = this.concerts[index];
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
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
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                        child: Text("Yes"),
                        onPressed: () => yesButtonPressed(index),
                        color: Colors.green),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                      child: Text("No"),
                      onPressed: () => noButtonPressed(index),
                      color: Colors.red),
                ),
              ]),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }

  void yesButtonPressed(int index) {
    this.setState(() {
      this.concerts.removeAt(index);
    });
  }

  void noButtonPressed(int index) {
    this.setState(() {
      this.concerts.removeAt(index);
    });
  }
}
