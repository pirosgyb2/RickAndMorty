import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/data/repos/common_repo.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Repository<Character> get characterRepository {
    return new Repository<Character>();
  }

  Repository<Episode> get episodeRepository {
    return new Repository<Episode>();
  }

  Repository<Location> get locationRepository {
    return new Repository<Location>();
  }

  Repository<T> repository<T>() {
    return new Repository<T>();
  }
}
