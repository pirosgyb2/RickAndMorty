import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/repos/character_data_impl.dart';
import 'package:rick_and_morty_app/injection/dependency_injection.dart';

abstract class CharacterListViewContract {
  void onLoadCharactersComplete(List<Character> items);

  void onLoadCharactersError();
}

class CharacterListPresenter {
  CharacterListViewContract _view;
  CharacterRepository _repository;

  CharacterListPresenter(this._view) {
    _repository = new Injector().characterRepository;
  }

  void loadCharacters() {
    assert(_view != null);

    _repository
        .fetch()
        .then((characters) => _view.onLoadCharactersComplete(characters))
        .catchError((onError) {
      print(onError);
      _view.onLoadCharactersError();
    });
  }
}
