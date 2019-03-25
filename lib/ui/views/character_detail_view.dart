import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/colors.dart';
import 'package:rick_and_morty_app/data/models/character_data.dart';

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

class _CharacterCategoryItem extends StatelessWidget {
  final IconData icon;
  final bool bigPadding;
  final List<String> lines;

  _CharacterCategoryItem({Key key,
    @required this.icon,
    @required this.lines,
    @required this.bigPadding})
      : super(key: key);

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

  List<Widget> _buildRow(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    //final List<Widget> firstColumn = lines.map((line) => Text(line)).toList();
    final List<Widget> firstColumn = <Text>[
      Text(lines[0]), Text(lines[1], style: TextStyle(color: subtitleGray),)];

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
          onPressed: () => {},
        ),
      ),
    ];
  }
}

class _CharacterCategory extends StatelessWidget {
  final IconData icon;
  final List<_CharacterCategoryItem> children;

  _CharacterCategory({Key key, this.icon, this.children}) : super(key: key);

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

class CharacterDetailsPage extends StatelessWidget {
  static const String routeName = '/character';
  final Character _character;

  const CharacterDetailsPage(this._character);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        //primarySwatch: _character.species...
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            FlexibleAppBar(_character.name, _character.imageUrl),
            SliverList(
              delegate: SliverChildListDelegate(
                <_CharacterCategory>[
                  _buildImportantDataCategory(),
                  _buildCategory(Icons.home, Icons.arrow_forward,
                      <String>[_character.origin.name, "Origin"]),
                  _buildCategory(Icons.location_on, Icons.arrow_forward,
                      <String>[_character.location.name, "Location"]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _CharacterCategory _buildImportantDataCategory() {
    return _CharacterCategory(
      icon: Icons.accessibility,
      children: <_CharacterCategoryItem>[
        _CharacterCategoryItem(
            icon: null,
            lines: <String>[_character.gender, "Gender"],
            bigPadding: false),
        _CharacterCategoryItem(
            icon: null,
            lines: <String>[_character.species, "Spieces"],
            bigPadding: false),
        _CharacterCategoryItem(
            icon: null,
            lines: <String>[_character.type, "Type"],
            bigPadding: false),
        _CharacterCategoryItem(
            icon: null,
            lines: <String>[_character.status, "Status"],
            bigPadding: false),
      ],
    );
  }

  _CharacterCategory _buildCategory(
      IconData categoryIcon, IconData categoryItemIcon, List<String> lines) {
    return _CharacterCategory(
      icon: categoryIcon,
      children: <_CharacterCategoryItem>[
        _CharacterCategoryItem(
          icon: categoryItemIcon,
          lines: lines,
          bigPadding: true,
        ),
      ],
    );
  }
}
