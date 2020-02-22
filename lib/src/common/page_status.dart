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
  RefreshFail,
  LoadMoreComplete,
  LoadMoreFail,
  LoadMoreNoData
}
