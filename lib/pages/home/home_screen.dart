import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingcart/data/database_helper.dart';
import 'package:shoppingcart/pages/home/blocs/home_bloc.dart';
import 'package:shoppingcart/utils/extensions/extension_context.dart';
import 'package:shoppingcart/widgets/base/base.dart';
import 'package:shoppingcart/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late HomeBloc homeBloc;
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  initData() {
    homeBloc = HomeBloc();
    homeBloc.add(GetListProductEvent());
  }

  void _onRefresh() async {
    homeBloc.add(GetListProductEvent());
  }

  void _onLoading() async {
    homeBloc.add(LoadMoreProductEvent());
  }

  void _listenerGetData(BuildContext context, HomeState state) {
    switch (state.getListProductStatus) {
      case GetListProductStatus.loading:
        showLoading(context);
        break;
      case GetListProductStatus.success:
        _refreshController.refreshCompleted();
        context.pop();
        break;
      case GetListProductStatus.failure:
        _refreshController.refreshCompleted();
        context.pop();
        break;
      default:
    }
  }

  void _listenerLoadMore(BuildContext context, HomeState state) {
    switch (state.loadMoreProductStatus) {
      case LoadMoreProductStatus.success:
        _refreshController.loadComplete();
        break;
      case LoadMoreProductStatus.failure:
        _refreshController.loadComplete();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
                previous.getListProductStatus != current.getListProductStatus,
            listener: _listenerGetData,
          ),
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
                previous.loadMoreProductStatus != current.loadMoreProductStatus,
            listener: _listenerLoadMore,
          ),
        ],
        child: BaseScreen(
          isBack: false,
          title: 'Home',
          actions: const [CardHeader()],
          body: BasePullRefresh(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: const CustomScrollView(
              slivers: [HotProductList(), AllProductGrid()],
            ),
          ),
        ),
      ),
    );
  }
}
