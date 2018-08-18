import 'package:flutter/material.dart';
import 'concert_list.dart';

class AcceptedConcerts extends StatelessWidget {
  AcceptedConcerts({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return new ConcertList(rsvp: 'yes');
  }
}
