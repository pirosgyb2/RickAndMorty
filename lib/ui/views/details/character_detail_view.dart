import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
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
                  _buildSingleInfo(
                      Icons.home,
                      Icons.arrow_forward,
                      <String>[_character.origin.name, "Origin"],
                      _character.origin),
                  _buildSingleInfo(
                      Icons.location_on,
                      Icons.arrow_forward,
                      <String>[_character.location.name, "Last Location"],
                      _character.location),
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
  Info buildSingleInfo(IconData categoryIcon, IconData categoryItemIcon,
      List<String> lines) {}

  Info _buildSingleInfo(IconData categoryIcon, IconData categoryItemIcon,
      List<String> lines, Location location) {
    return Info(
      icon: categoryIcon,
      children: <InfoItem>[
        InfoItem(
          icon: categoryItemIcon,
          lines: lines,
          bigPadding: true,
          location: location,
        ),
      ],
    );
  }
}
