/// 页面状态
/// [Loading] 初始化加载
/// [RefreshComplete] 数据加载成功
/// [Empty] 数据为空
/// [Error] 加载失败
enum ScreenStatus {
  Loading,
  Empty,
  Error,
  RefreshComplete,
  LoadSuccess,
  RefreshFail,
  LoadMoreComplete,
  LoadMoreFail,
  LoadMoreNoData
}

class PageStatus<T> {
  PageStatus._();

  factory PageStatus.success(T data) = LoadSuccess<T>;

  factory PageStatus.error({String msg}) = Error<T>;

  factory PageStatus.refreshFail({String msg}) = RefreshFail<T>;

  factory PageStatus.loading() = Loading<T>;

  factory PageStatus.empty() = Empty<T>;

  factory PageStatus.refreshComplete(T data) = RefreshComplete<T>;

  factory PageStatus.loadMoreComplete(T data) = LoadMoreComplete<T>;

  factory PageStatus.loadMoreFail({String msg}) = LoadMoreFail<T>;

  factory PageStatus.loadMoreNoData() = LoadMoreNoData<T>;
}

class LoadSuccess<T> extends PageStatus<T> {
  LoadSuccess(this.data) : super._();
  final T data;
}

class Error<T> extends PageStatus<T> {
  Error({this.msg}) : super._();
  final String msg;
}

class Loading<T> extends PageStatus<T> {
  Loading() : super._();
}

class Empty<T> extends PageStatus<T> {
  Empty() : super._();
}

class RefreshComplete<T> extends PageStatus<T> {
  RefreshComplete(this.data) : super._();
  final dynamic data;
}

class RefreshFail<T> extends PageStatus<T> {
  final String msg;

  RefreshFail({this.msg}) : super._();
}

class LoadMoreComplete<T> extends PageStatus<T> {
  LoadMoreComplete(this.data) : super._();
  final dynamic data;
}

class LoadMoreFail<T> extends PageStatus<T> {
  LoadMoreFail({this.msg}) : super._();
  final String msg;
}

class LoadMoreNoData<T> extends PageStatus<T> {
  LoadMoreNoData() : super._();
}
