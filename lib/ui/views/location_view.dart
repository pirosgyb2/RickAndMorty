import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';

class LocationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
      ),
      body: LocationList(),
    );
  }
}

// -------- Location List ----------

class LocationList extends StatefulWidget {
  LocationList({Key key}) : super(key: key);

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList>
    implements ListViewContract<Location> {
  ListPresenter<Location> _presenter;
  List<Location> _locations;
  bool _isSearching;

  _LocationListState() {
    _presenter = ListPresenter<Location>(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _presenter.loadItems();
  }

  @override
  void onLoadComplete(List<Location> items) {
    setState(() {
      _locations = items;
      _isSearching = false;
    });
  }

  @override
  void onLoadError() {}

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
          children: _buildLocationList());
    }

    return widget;
  }

  List<_LocationListItem> _buildLocationList() {
    return _locations.map((location) => _LocationListItem(location)).toList();
  }
}

// -------- Location List Item ---------

class _LocationListItem extends ListTile {
  _LocationListItem(Location location)
      : super(
            title: Text(location.name),
            subtitle: Text(location.type),
            leading: CircleAvatar(child: Text(location.name[0])));
}
