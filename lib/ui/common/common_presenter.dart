import 'package:rick_and_morty_app/data/repos/common_repo.dart';
import 'package:rick_and_morty_app/injection/dependency_injection.dart';

abstract class ListViewContract<T> {
  void onLoadComplete(List<T> items);

  void onLoadError();
}

class ListPresenter<T> {
  ListViewContract<T> _view;
  Repository<T> _repository;

  ListPresenter(this._view) {
    _repository = new Injector().repository<T>();
  }

  void loadItems() {
    assert(_view != null);

    _repository
        .fetch()
        .then((items) => _view.onLoadComplete(items))
        .catchError((onError) {
      print(onError);
      _view.onLoadError();
    });
  }
}
