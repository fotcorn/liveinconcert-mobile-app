import 'package:flutter/material.dart';
import 'concert_list.dart';

class AcceptedConcerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ConcertList(rsvp: 'yes');
  }
}
