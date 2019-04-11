import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';
import 'package:rick_and_morty_app/ui/views/details/episode_detail_view.dart';

class EpisodesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Episodes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, delegate: CustomSearchDelegate<Episode>(),);
            },
          ),
        ],
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
  List<Episode> _episodes = new List<Episode>();
  bool _isSearching;
  bool _isError;

  final ScrollController scrollController = new ScrollController();
  LoadMorePageStatus loadMoreStatus = LoadMorePageStatus.STABLE;

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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onLoadComplete(List<Episode> items) {
    setState(() {
      loadMoreStatus = LoadMorePageStatus.STABLE;
      _episodes.addAll(items);
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
        widget = NotificationListener(
            onNotification: _onNotification,
            child: ListView(
                controller: scrollController,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                children: _buildEpisodesList()));
      }
    }
    return widget;
  }

  List<_EpisodesListItem> _buildEpisodesList() {
    return _episodes.map((episode) =>
        _EpisodesListItem(episode: episode, onTap: () {
          _showEpisodeDetailsPage(context, episode);
        },)).toList();
  }

  void _showEpisodeDetailsPage(BuildContext context, Episode episode) {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
        settings: const RouteSettings(name: EpisodeDetailPage.routeName),
        builder: (BuildContext context) => EpisodeDetailPage(episode),
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

// -------- Episode List Item ---------

class _EpisodesListItem extends ListTile {
  _EpisodesListItem({Episode episode, GestureTapCallback onTap})
      : super(
            title: Text(episode.name),
            subtitle: Text(episode.episode),
      leading: CircleAvatar(child: Text(episode.name[0])),
      onTap: onTap);
}
