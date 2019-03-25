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
                  buildResidentsBlock(),
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
      icon: Icons.location_city,
      children: <InfoItem>[
        InfoItem(
            icon: null,
            lines: <String>[_location.type, "Type"],
            bigPadding: false),
        InfoItem(
            icon: null,
            lines: <String>[_location.dimension, "Dimenson"],
            bigPadding: false),
      ],
    );
  }

  Info buildResidentsBlock() {
    List<InfoItem> infoItems = <InfoItem>[
      InfoItem(
        icon: null,
        lines: <String>["", "Residents"],
        bigPadding: false,
      ),
    ];

    infoItems.addAll(_location.residents
        .map((residentURL) =>
        InfoItem(
          icon: null,
          lines: <String>[residentURL, ""],
          bigPadding: false,
        ))
        .toList());
    return Info(
      icon: Icons.person,
      children: infoItems,
    );
  }

  @override
  Info buildSingleInfo(IconData icon, IconData itemIcon, List<String> lines) {
    return Info(
      icon: icon,
      children: <InfoItem>[
        InfoItem(
          icon: itemIcon,
          lines: lines,
          bigPadding: true,
        ),
      ],
    );
  }
}
