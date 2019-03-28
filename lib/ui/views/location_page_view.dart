import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';
import 'package:rick_and_morty_app/ui/views/details/location_detail_view.dart';

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

  final ScrollController scrollController = new ScrollController();
  LoadMorePageStatus loadMoreStatus = LoadMorePageStatus.STABLE;

  ListPresenter<Location> _presenter;
  List<Location> _locations = new List<Location>();
  bool _isSearching;
  bool _isError;

  _LocationListState() {
    _presenter = ListPresenter<Location>(this);
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
  void onLoadComplete(List<Location> items) {
    setState(() {
      loadMoreStatus = LoadMorePageStatus.STABLE;
      _locations.addAll(items);
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
              child: Text("Cannot load locations.")));
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
                children: _buildLocationList()));
      }
    }
    return widget;
  }

  List<_LocationListItem> _buildLocationList() {
    return _locations.map((location) =>
        _LocationListItem(location: location, onTap: () {
          _showLocationDetailsPage(context, location);
        })).toList();
  }

  void _showLocationDetailsPage(BuildContext context, Location location) {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
        settings: const RouteSettings(name: LocationDetailPage.routeName),
        builder: (BuildContext context) => LocationDetailPage(location),
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

// -------- Location List Item ---------

class _LocationListItem extends ListTile {
  _LocationListItem({Location location, GestureTapCallback onTap})
      : super(
            title: Text(location.name),
            subtitle: Text(location.type),
      leading: CircleAvatar(child: Text(location.name[0])),
      onTap: onTap);
}
