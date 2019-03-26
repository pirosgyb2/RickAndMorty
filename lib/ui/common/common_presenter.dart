import 'package:rick_and_morty_app/data/repos/common_repo.dart';
import 'package:rick_and_morty_app/injection/dependency_injection.dart';

enum LoadMoreStatus { LOADING, STABLE }

abstract class ListViewContract<T> {
  void onLoadComplete(List<T> items);

  void onLoadError();
}

class ListPresenter<T> {
  ListViewContract<T> _view;
  Repository<T> _repository;
  int currentPage = 0;

  ListPresenter(this._view) {
    _repository = new Injector().repository<T>();
  }

  void loadItems() {
    assert(_view != null);
    if (_repository.responseInfo != null &&
        _repository.responseInfo.nextURL != "") {
      _repository
          .fetch(currentPage + 1)
          .then((items) {
        _view.onLoadComplete(items);
        currentPage = currentPage + 1;
      })
          .catchError((onError) {
        print(onError);
        _view.onLoadError();
      });
    }
  }
}
