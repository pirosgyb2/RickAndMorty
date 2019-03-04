import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/character_data.dart';

import 'character_presenter.dart';

class CharactersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters"),
      ),
      body: CharacterList(),
    );
  }
}

///
///   Character List
///

class CharacterList extends StatefulWidget {
  CharacterList({Key key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList>
    implements CharacterListViewContract {
  CharacterListPresenter _presenter;

  List<Character> _characters;

  bool _isSearching;

  _CharacterListState() {
    _presenter = CharacterListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _presenter.loadCharacters();
  }

  @override
  void onLoadCharactersComplete(List<Character> items) {
    setState(() {
      _characters = items;
      _isSearching = false;
    });
  }

  @override
  void onLoadCharactersError() {
    // TODO: implement onLoadCharactersError
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isSearching) {
      widget = Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
    } else {
      widget = ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _buildCharacterList());
    }

    return widget;
  }

  List<_CharacterListItem> _buildCharacterList() {
    return _characters
        .map((character) => _CharacterListItem(character))
        .toList();
  }
}

///
///   Character List Item
///

class _CharacterListItem extends ListTile {
  _CharacterListItem(Character character)
      : super(
      title: Text(character.name),
      subtitle: Text(character.species),
      leading: CircleAvatar(child: Text(character.name[0])));
}
