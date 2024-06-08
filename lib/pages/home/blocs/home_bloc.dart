import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/data/product_dao/i_product_dao.dart';
import 'package:shoppingcart/data/product_dao/product_dao.dart';
import 'package:shoppingcart/models/models.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<GetListProductEvent>(_mapGetListChangedToState);
    on<LoadMoreProductEvent>(_mapLoadMoreChangedToState);
  }
  IProductDao productDao = ProductDao();

  FutureOr<void> _mapGetListChangedToState(
      GetListProductEvent event, emit) async {
    emit(state.copyWith(getListProductStatus: GetListProductStatus.loading));
    await Future.delayed(const Duration(milliseconds: 800));
    final List<ProductModel> results = await productDao.getProducts();
    emit(state.copyWith(
        products: results, getListProductStatus: GetListProductStatus.success));
  }

  FutureOr<void> _mapLoadMoreChangedToState(
      LoadMoreProductEvent event, emit) async {
    emit(state.copyWith(loadMoreProductStatus: LoadMoreProductStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    List<ProductModel> products = state.products ?? [];
    final List<ProductModel> resultsLoadMore =
        await productDao.getProducts(offset: products.length);

    emit(state.copyWith(
        products: [...products, ...resultsLoadMore],
        loadMoreProductStatus: LoadMoreProductStatus.success));
  }
}
