import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/colors.dart';

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

class InfoItem extends StatelessWidget {
  final IconData icon;
  final bool bigPadding;
  final List<String> lines;

  InfoItem(
      {Key key,
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
          onPressed: () => {},
        ),
      ),
    ];
  }
}

class Info extends StatelessWidget {
  final IconData icon;
  final List<InfoItem> children;

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
