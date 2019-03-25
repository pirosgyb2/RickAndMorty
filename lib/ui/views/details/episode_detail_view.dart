import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/ui/views/details/common_detail_elements.dart';

class EpisodeDetailPage extends StatelessWidget implements DetailPage {
  static const String routeName = '/episode';
  final Episode _episode;

  const EpisodeDetailPage(this._episode);

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
            FlexibleAppBar(_episode.name, ""),
            SliverList(
              delegate: SliverChildListDelegate(
                <Info>[
                  buildImportantInfoBlock(),
                  buildCharactersBlock(),
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
      icon: Icons.local_movies,
      children: <InfoItem>[
        InfoItem(
            icon: null,
            lines: <String>[_episode.episode, "Episode"],
            bigPadding: false),
        InfoItem(
            icon: null,
            lines: <String>[_episode.airDate, "Air date"],
            bigPadding: false),
      ],
    );
  }

  Info buildCharactersBlock() {
    List<InfoItem> infoItems = <InfoItem>[
      InfoItem(
        icon: null,
        lines: <String>["", "Characters"],
        bigPadding: false,
      ),
    ];

    infoItems.addAll(_episode.characters
        .map((characterURL) => InfoItem(
              icon: null,
              lines: <String>[characterURL, ""],
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
