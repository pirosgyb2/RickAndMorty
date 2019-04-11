import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/basic_data.dart';
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/data/repos/common_repo.dart';
import 'package:rick_and_morty_app/injection/dependency_injection.dart';
import 'package:rick_and_morty_app/ui/views/details/character_detail_view.dart';
import 'package:rick_and_morty_app/ui/views/details/episode_detail_view.dart';
import 'package:rick_and_morty_app/ui/views/details/location_detail_view.dart';

enum LoadMorePageStatus { LOADING, STABLE }

//---------- One Item Presenter things ------------
abstract class ViewContract<T> {
  void onLoadComplete(T item);

  void onLoadError();
}

class OnePresenter<T> {
  ViewContract<T> view;
  Repository<T> repository;

  void loadItem(String uri) {
    assert(view != null);

    repository
        .fetchOne(uri)
        .then((item) => view.onLoadComplete(item))
        .catchError((onError) {
      print(onError);
      view.onLoadError();
    });
  }
}

//-------- List of Item Presenter things ----------
abstract class ListViewContract<T> {
  void onLoadComplete(List<T> items);

  void onLoadError();
}

class ListPresenter<T> {
  ListViewContract<T> _view;
  Repository<T> _repository;
  int currentPage = 0;

  ListPresenter(this._view) {
    _repository = new Injector().repository<T>();
  }

  void loadItems() {
    assert(_view != null);
    if (_repository.responseInfo != null &&
        _repository.responseInfo.nextURL != "") {
      _repository.fetchList(currentPage + 1).then((items) {
        _view.onLoadComplete(items);
        currentPage = currentPage + 1;
      }).catchError((onError) {
        print(onError);
        _view.onLoadError();
      });
    }
  }

  void search(String query) {
    assert(_view != null);
    _repository.search(query).then((items) {
      _view.onLoadComplete(items);
    }).catchError((onError) {
      print(onError);
      _view.onLoadError();
    });
  }
}

//------------ Search things ----------------

class CustomSearchDelegate<T extends BasicData> extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return SearchResultList<T>(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}

class SearchResultList<T extends BasicData> extends StatefulWidget {
  final String query;

  SearchResultList(this.query);

  @override
  _SearchResultListState createState() => _SearchResultListState<T>(query);
}

class _SearchResultListState<T extends BasicData>
    extends State<SearchResultList<T>>
    implements ListViewContract<T> {
  bool _isSearching;
  bool _isError;
  String query;
  ListPresenter<T> _presenter;
  List<T> _items = new List<T>();
  String searchURL = "";

  _SearchResultListState(this.query) {
    _presenter = ListPresenter<T>(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _isError = false;
    _presenter.search(query);
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isError) {
      widget = Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text("Cannot load results.")));
    } else {
      if (_isSearching) {
        widget = Center(
            child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: CircularProgressIndicator()));
      } else {
        widget = ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: _buildList());
      }
    }
    return widget;
  }

  @override
  void onLoadComplete(List<T> items) {
    setState(() {
      _items.addAll(items);
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

  List<_ListItem> _buildList<T extends BasicData>() {
    return _items
        .map((item) =>
        _ListItem(
            item: item,
            onTap: () {
              _showDetailPage(context, item);
            }))
        .toList();
  }

  void _showDetailPage(BuildContext context, T item) {
    switch (T) {
      case (Character):
        Navigator.push(
          context,
          MaterialPageRoute<Null>(
            settings: RouteSettings(name: CharacterDetailPage.routeName),
            builder: (BuildContext context) =>
                CharacterDetailPage(item as Character),
          ),
        );
        break;
      case (Episode):
        Navigator.push(
          context,
          MaterialPageRoute<Null>(
            settings: RouteSettings(name: EpisodeDetailPage.routeName),
            builder: (BuildContext context) =>
                EpisodeDetailPage(item as Episode),
          ),
        );
        break;
      case (Location):
        Navigator.push(
          context,
          MaterialPageRoute<Null>(
            settings: RouteSettings(name: LocationDetailPage.routeName),
            builder: (BuildContext context) =>
                LocationDetailPage(item as Location),
          ),
        );
        break;
    };
  }
}

class _ListItem<T extends BasicData> extends ListTile {


  _ListItem({T item, GestureTapCallback onTap})
      : super(
      title: Text(item.name),
      leading: CircleAvatar(child: Text(item.name[0])),
      onTap: onTap);
}