import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/injection/dependency_injection.dart';
import 'package:rick_and_morty_app/ui/common/common_presenter.dart';

class OneCharacterPresenter extends OnePresenter<Character> {
  OneCharacterPresenter(ViewContract<Character> view) {
    super.view = view;
    super.repository = Injector().specCharacterRepository;
  }
}

class OneEpisodePresenter extends OnePresenter<Episode> {
  OneEpisodePresenter(ViewContract<Episode> view) {
    super.view = view;
    super.repository = Injector().specEpisodeRepository;
  }
}

class OneLocationPresenter extends OnePresenter<Location> {
  OneLocationPresenter(ViewContract<Location> view) {
    super.view = view;
    super.repository = Injector().specLocationRepository;
  }
}
