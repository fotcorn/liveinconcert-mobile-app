import 'package:flutter/material.dart';
import 'concert_list.dart';

class NewConcerts extends StatelessWidget {
  // NewConcerts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ConcertList(rsvp: 'not_yet_answered');
  }
}
