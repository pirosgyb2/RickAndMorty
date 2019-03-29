import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/colors.dart';
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';
import 'package:rick_and_morty_app/ui/common/one_presenters.dart';
import 'package:rick_and_morty_app/ui/views/details/character_detail_view.dart';

class FlexibleAppBar extends SliverAppBar {
  static const double height = 256.0;

  FlexibleAppBar(String title, String imageUrl)
      : super(
            pinned: true,
            expandedHeight: height,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: _buildBackground(imageUrl),
            ));

  static Widget _buildBackground(String imageUrl) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: height,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.5, 0.6),
                end: FractionalOffset(0.5, 1.0),
                colors: <Color>[Color(0x00000000), Color(0x70000000)]),
          ),
        ),
      ],
    );
  }
}

class InfoItem extends StatefulWidget implements ViewContract<Character> {
  final IconData icon;
  final bool bigPadding;
  List<String> lines;
  _InfoItemState state;
  OneCharacterPresenter _characterPresenter;

  InfoItem(
      {@required this.icon, @required this.lines, @required this.bigPadding}) {
    _characterPresenter = new OneCharacterPresenter(this);
  }

  @override
  State<StatefulWidget> createState() {
    state = _InfoItemState(
      icon: icon,
      bigPadding: bigPadding,
      lines: lines,
    );
    return state;
  }

  void loadItem() {
    _characterPresenter.loadItem(lines[0]);
  }

  @override
  void onLoadComplete(Character character) {
    state.updateLines(character);
  }

  @override
  void onLoadError() {
    // TODO: implement onLoadError
  }
}

class _InfoItemState extends State<InfoItem> {
  final IconData icon;
  final bool bigPadding;
  List<String> lines;
  Character character;

  _InfoItemState({
    @required this.icon,
    @required this.lines,
    @required this.bigPadding,
  }) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: bigPadding ? 16.0 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildRow(context),
      ),
    );
  }

  void updateLines(Character character) {
    setState(() {
      this.character = character;
      lines = <String>[character.name, character.species];
    });
  }

  List<Widget> _buildRow(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> firstColumn = <Text>[
      Text(lines[0]),
      Text(
        lines[1],
        style: TextStyle(color: subtitleGray),
      )
    ];

    return <Widget>[
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: firstColumn,
        ),
      ),
      SizedBox(
        width: 72.0,
        child: IconButton(
          icon: Icon(icon),
          color: themeData.primaryColor,
          onPressed: () =>
          {
          _showCharacterDetailsPage(context, character)
          },
        ),
      ),
    ];
  }

  _showCharacterDetailsPage(BuildContext context, Character character) {
    if (character != null) {
      Navigator.push(
        context,
        MaterialPageRoute<Null>(
          settings: const RouteSettings(name: CharacterDetailPage.routeName),
          builder: (BuildContext context) => CharacterDetailPage(character),
        ),
      );
    }
  }
}

class Info extends StatelessWidget {
  final IconData icon;
  List<InfoItem> children;

  Info({Key key, this.icon, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: themeData.primaryColor))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            width: 72.0,
            child: Icon(icon, color: themeData.primaryColor),
          ),
          Flexible(child: Column(children: children)),
        ],
      ),
    );
  }
}

abstract class DetailPage {
  Info buildImportantInfoBlock();

  Info buildSingleInfo(IconData icon, IconData itemIcon, List<String> lines);
}
