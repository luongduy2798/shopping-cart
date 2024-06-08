part of 'home_bloc.dart';

enum GetListProductStatus { initial, loading, success, failure }

enum LoadMoreProductStatus { initial, loading, success, failure }

class HomeState {
  HomeState(
      {this.products,
      this.getListProductStatus = GetListProductStatus.initial,
      this.loadMoreProductStatus = LoadMoreProductStatus.initial});
  List<ProductModel>? products;
  GetListProductStatus getListProductStatus;
  LoadMoreProductStatus loadMoreProductStatus;

  HomeState copyWith({
    GetListProductStatus? getListProductStatus,
    LoadMoreProductStatus? loadMoreProductStatus,
    List<ProductModel>? products,
  }) {
    return HomeState(
        getListProductStatus: getListProductStatus ?? this.getListProductStatus,
        loadMoreProductStatus:
            loadMoreProductStatus ?? this.loadMoreProductStatus,
        products: products ?? this.products);
  }
}
