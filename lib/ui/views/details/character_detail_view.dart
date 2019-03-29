import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/ui/views/details/common_detail_elements.dart';

class CharacterDetailPage extends StatelessWidget implements DetailPage {
  static const String routeName = '/character';
  final Character _character;

  const CharacterDetailPage(this._character);

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
                <Info>[
                  buildImportantInfoBlock(),
                  buildSingleInfo(Icons.home, null,
                      <String>[_character.origin.name, "Origin"]),
                  buildSingleInfo(Icons.location_on, null,
                      <String>[_character.location.name, "Location"]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Info buildImportantInfoBlock() {
    return Info(
      icon: Icons.accessibility,
      children: <InfoItem>[
        InfoItem(
            icon: null,
            lines: <String>[_character.gender, "Gender"],
            bigPadding: false),
        InfoItem(
            icon: null,
            lines: <String>[_character.species, "Spieces"],
            bigPadding: false),
        InfoItem(
            icon: null,
            lines: <String>[_character.type, "Type"],
            bigPadding: false),
        InfoItem(
            icon: null,
            lines: <String>[_character.status, "Status"],
            bigPadding: false),
      ],
    );
  }

  @override
  Info buildSingleInfo(
      IconData categoryIcon, IconData categoryItemIcon, List<String> lines) {
    return Info(
      icon: categoryIcon,
      children: <InfoItem>[
        InfoItem(
          icon: categoryItemIcon,
          lines: lines,
          bigPadding: true,
        ),
      ],
    );
  }
}
