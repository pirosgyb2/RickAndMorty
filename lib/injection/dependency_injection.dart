import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/data/repos/common_repo.dart';
import 'package:rick_and_morty_app/data/repos/spec_repos.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Repository<Character> get specCharacterRepository {
    return new SpecCharacterRepository();
  }

  Repository<Episode> get specEpisodeRepository {
    return new SpecEpisodeRepository();
  }

  Repository<Location> get specLocationRepository {
    return new SpecLocationRepository();
  }

  Repository<T> repository<T>() {
    return new Repository<T>();
  }
}
