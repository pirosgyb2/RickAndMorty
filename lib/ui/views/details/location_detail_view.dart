import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';
import 'package:rick_and_morty_app/ui/common/one_presenters.dart';
import 'package:rick_and_morty_app/ui/views/details/common_detail_elements.dart';

class LocationDetailPage extends StatefulWidget {
  static const String routeName = '/location';
  final Location _location;
  final bool shouldDownloadAllData;

  const LocationDetailPage(this._location, {this.shouldDownloadAllData});

  @override
  _LocationDetailPageState createState() =>
      _LocationDetailPageState(
          _location, shouldDownloadAllData: shouldDownloadAllData);
}

class _LocationDetailPageState extends State<LocationDetailPage>
    implements DetailPage, ViewContract<Location> {
  Location _location;
  final bool shouldDownloadAllData;
  List<String> type; //TODO: ezekkel kell kezdeni valamit szerintem
  List<String> dimension;
  List<String> residents;
  List<InfoItem> children;

  _LocationDetailPageState(this._location, {this.shouldDownloadAllData}) {
    if (shouldDownloadAllData != null && shouldDownloadAllData) {
      new OneLocationPresenter(this).loadItem(_location.url);
    }
  }

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
    children = <InfoItem>[
      InfoItem(
          icon: null,
          lines: <String>[
            _location.type == null ? "Unknown" : _location.type,
            "Type"
          ],
          bigPadding: false),
      InfoItem(
          icon: null,
          lines: <String>[
            _location.dimension == null ? "Unknown" : _location.dimension,
            "Dimenson"
          ],
          bigPadding: false),
    ];

    return Info(
      icon: Icons.location_city,
      children: children,
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

    if (_location.residents != null) {
      infoItems.addAll(_location.residents
          .map((residentURL) =>
          InfoItem(
            icon: Icons.arrow_forward,
            lines: <String>["Loading...", "", residentURL],
            bigPadding: false,
          ))
          .toList());

      // 1-tol kezdve h a 'Residents' feliraton ne hívja meg
      for (int i = 1; i < infoItems.length; i++) {
        infoItems[i].loadItem();
      }
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

  @override
  void onLoadComplete(Location location) {
    setState(() {
      children[0].changeLines(<String>[
        location.type == null ? "Unknown" : location.type,
        "Type"
      ]);

      children[1].changeLines(<String>[
        location.dimension == null ? "Unknown" : location.dimension,
        "Dimenson"
      ]);

      _location = location;
      build(context);
    });
  }

  @override
  void onLoadError() {}
}
