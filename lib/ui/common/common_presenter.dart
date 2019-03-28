import 'package:rick_and_morty_app/data/repos/common_repo.dart';
import 'package:rick_and_morty_app/injection/dependency_injection.dart';

enum LoadMorePageStatus { LOADING, STABLE }

//---------- One Item Presenter things ------------
abstract class ViewContract<T> {
  void onLoadComplete(T item);

  void onLoadError();
}

class OnePresenter<T> {
  ViewContract<T> view;
  Repository<T> repository;

  void loadItem(String uri) {
    assert(view != null);

    repository
        .fetchOne(uri)
        .then((item) => view.onLoadComplete(item))
        .catchError((onError) {
      print(onError);
      view.onLoadError();
    });
  }
}

//-------- List of Item Presenter things ----------
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
      _repository.fetchList(currentPage + 1).then((items) {
        _view.onLoadComplete(items);
        currentPage = currentPage + 1;
      }).catchError((onError) {
        print(onError);
        _view.onLoadError();
      });
    }
  }
}
