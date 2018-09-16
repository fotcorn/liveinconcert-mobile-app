import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Concert {
  final String id;
  final String artist;
  final String location;
  final DateTime dateTime;

  Concert({this.id, this.artist, this.location, this.dateTime});

  factory Concert.fromJson(Map<String, dynamic> json) {
    return Concert(
      id: json['node']['id'],
      artist: json['node']['event']['artist']['name'],
      location: json['node']['event']['location'],
      dateTime: DateTime.parse(json['node']['event']['dateTime']),
    );
  }
}

Future<List<Concert>> fetchConcerts({String rsvp = 'not_yet_answered'}) async {
  final response = await http.post('http://10.0.2.2:8000/graphql/', body: {
    'query': '''
{
  eventRsvps(rsvp:"$rsvp") {
    edges {
      node {
        id
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

void updateRSVP(String id, String rsvp) async {
  final response = await http.post('http://10.0.2.2:8000/graphql/', body: {
    'query': '''
mutation UpdateRSVP {
  updateRsvp(input:{clientMutationId:"$id", rsvp:"$rsvp"}) {
    rsvp
  }
}
    '''
  });
  if (response.statusCode != 200) {
    print(response.body);
  }
}

void addPushToken(String token) async {
    final response = await http.post('http://10.0.2.2:8000/graphql/', body: {
    'query': '''
mutation CreateFirebaseToken {
  createFirebaseToken(token:"$token") {
    token
  }
}
    '''
  });
  if (response.statusCode != 200) {
    print(response.body);
  }
}