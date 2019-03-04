import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'contact_data.dart';

class RandomUserRepository implements ContactRepository {
  static const _kRandomuserUri = 'http://api.randomuser.me/?results=15';
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Contact>> fetch() async {
    final response = await http.get(_kRandomuserUri);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final contactsContainer = _decoder.convert(jsonBody);
    final List contactItems = contactsContainer['results'];

    return contactItems
        .map((contactRaw) => Contact.fromMap(contactRaw))
        .toList();
  }
}
