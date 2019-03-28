import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';
import 'package:rick_and_morty_app/ui/views/details/character_detail_view.dart';

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

// -------- Character List ----------

class CharacterList extends StatefulWidget {
  CharacterList({Key key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList>
    implements ListViewContract<Character> {

  final ScrollController scrollController = new ScrollController();
  LoadMorePageStatus loadMoreStatus = LoadMorePageStatus.STABLE;

  ListPresenter<Character> _presenter;
  List<Character> _characters = new List<Character>();
  bool _isSearching;
  bool _isError;

  _CharacterListState() {
    _presenter = ListPresenter<Character>(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _isError = false;
    _presenter.loadItems();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onLoadComplete(List<Character> items) {
    setState(() {
      loadMoreStatus = LoadMorePageStatus.STABLE;
      _characters.addAll(items);
      _isSearching = false;
      _isError = false;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      _isError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isError) {
      widget = Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text("Cannot load characters.")));
    } else {
      if (_isSearching) {
        widget = Center(
            child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: CircularProgressIndicator()));
      } else {
        widget = NotificationListener(
            onNotification: _onNotification,
            child: ListView(
                controller: scrollController,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                children: _buildCharacterList()));
      }
    }
    return widget;
  }

  List<_CharacterListItem> _buildCharacterList() {
    return _characters
        .map((character) =>
        _CharacterListItem(
            character: character,
            onTap: () {
              _showCharacterDetailsPage(context, character);
            }))
        .toList();
  }

  void _showCharacterDetailsPage(BuildContext context, Character character) {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
        settings: const RouteSettings(name: CharacterDetailPage.routeName),
        builder: (BuildContext context) => CharacterDetailPage(character),
      ),
    );
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == LoadMorePageStatus.STABLE) {
          loadMoreStatus = LoadMorePageStatus.LOADING;
          _presenter.loadItems();
        }
        ;
      }
    }
    return true;
  }
}

// -------- Character List Item ---------

class _CharacterListItem extends ListTile {
  _CharacterListItem({Character character, GestureTapCallback onTap})
      : super(
      title: Text(character.name),
      subtitle: Text(character.species),
      leading: CircleAvatar(child: Text(character.name[0])),
      onTap: onTap);
}
