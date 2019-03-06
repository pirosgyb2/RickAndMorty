import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';

class EpisodesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Episodes"),
      ),
      body: EpisodeList(),
    );
  }
}

// -------- Episode List ----------

class EpisodeList extends StatefulWidget {
  EpisodeList({Key key}) : super(key: key);

  @override
  _EpisodeListState createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList>
    implements ListViewContract<Episode> {
  ListPresenter<Episode> _presenter;
  List<Episode> _episodes;
  bool _isSearching;
  bool _isError;

  _EpisodeListState() {
    _presenter = ListPresenter<Episode>(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _isError = false;
    _presenter.loadItems();
  }

  @override
  void onLoadComplete(List<Episode> items) {
    setState(() {
      _episodes = items;
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
              child: Text("Cannot load episodes.")));
    } else {
      if (_isSearching) {
        widget = Center(
            child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: CircularProgressIndicator()));
      } else {
        widget = ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: _buildEpisodesList());
      }
    }
    return widget;
  }

  List<_EpisodesListItem> _buildEpisodesList() {
    return _episodes.map((episode) => _EpisodesListItem(episode)).toList();
  }
}

// -------- Episode List Item ---------

class _EpisodesListItem extends ListTile {
  _EpisodesListItem(Episode episode)
      : super(
            title: Text(episode.name),
            subtitle: Text(episode.episode),
            leading: CircleAvatar(child: Text(episode.name[0])));
}
