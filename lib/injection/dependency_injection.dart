import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/common_data.dart';
import 'package:rick_and_morty_app/data/repos/character_data_impl.dart';
import 'package:rick_and_morty_app/data/repos/character_data_mock.dart';

enum Flavor { MOCK, PRO }

class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  CommonRepository<Character> get characterRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockCharacterRepository();
      default: //Flavor.PRO
        return new CharacterRepository();
    }
  }
}
