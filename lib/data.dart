import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

Future<List<Concert>> fetchConcerts({String rsvp = 'not_yet_answered'}) async {
  final response = await http.post('http://172.20.10.7:8000/graphql/', body: {
    'query': '''
{
  eventRsvps(rsvp:"$rsvp") {
    edges {
      node {
        rsvp
        event {
          dateTime
          location
          artist {
            name
          }
        }
      }
    }
  }
}
'''
  });
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
