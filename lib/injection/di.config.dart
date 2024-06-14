// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shoppingcart/blocs/order_bloc/order_bloc.dart' as _i3;
import 'package:shoppingcart/data/order_dao/i_order_dao.dart' as _i7;
import 'package:shoppingcart/data/order_dao/order_dao.dart' as _i8;
import 'package:shoppingcart/data/product_dao/i_product_dao.dart' as _i5;
import 'package:shoppingcart/data/product_dao/product_dao.dart' as _i6;
import 'package:shoppingcart/pages/home/blocs/home_bloc.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.OrderBloc>(() => _i3.OrderBloc());
    gh.lazySingleton<_i4.HomeBloc>(() => _i4.HomeBloc());
    gh.lazySingleton<_i5.IProductDao>(() => _i6.ProductDao());
    gh.lazySingleton<_i7.IOrderDao>(() => _i8.OrderDao());
    return this;
  }
}
