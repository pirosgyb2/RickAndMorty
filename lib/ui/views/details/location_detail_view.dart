import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/ui/views/details/common_detail_elements.dart';

class LocationDetailPage extends StatelessWidget implements DetailPage {
  static const String routeName = '/location';
  final Location _location;

  const LocationDetailPage(this._location);

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
            FlexibleAppBar(_location.name, ""),
            SliverList(
              delegate: SliverChildListDelegate(
                <Info>[
                  buildImportantInfoBlock(),
//                  buildSingleInfo(Icons.home, Icons.arrow_forward,
//                      <String>[_location.origin.name, "Origin"]),
//                  buildSingleInfo(Icons.location_on, Icons.arrow_forward,
//                      <String>[_character.location.name, "Location"]),
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
    // TODO: implement buildImportantInfoBlock
    return null;
  }

  @override
  Info buildSingleInfo(IconData icon, IconData itemIcon, List<String> lines) {
    // TODO: implement buildSingleInfo
    return null;
  }
}
