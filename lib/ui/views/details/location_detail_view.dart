import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/ui/views/details/common_detail_elements.dart';

class LocationDetailPage extends StatefulWidget {
  static const String routeName = '/location';
  final Location _location;

  const LocationDetailPage(this._location);

  @override
  _LocationDetailPageState createState() => _LocationDetailPageState(_location);
}

class _LocationDetailPageState extends State<LocationDetailPage>
    implements DetailPage {
  final Location _location;

  _LocationDetailPageState(this._location) {}

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
          icon: Icons.arrow_forward,
          lines: <String>[residentURL, ""],
          bigPadding: false,
        ))
        .toList());

    // 1-tol kezdve h a 'Residents' feliraton ne hívja meg
    for (int i = 1; i < infoItems.length; i++) {
      infoItems[i].loadItem();
    }

    return Info(
      icon: Icons.accessibility,
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
