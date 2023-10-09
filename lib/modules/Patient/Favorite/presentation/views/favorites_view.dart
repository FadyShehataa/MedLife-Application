import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../main.dart';
import '../manager/favorite_cubit/favorite_cubit.dart';
import 'widgets/favorites_body.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    fetchFavorite();
  }

  Future<void> fetchFavorite() async {
    BlocProvider.of<FavoriteCubit>(context).fetchFavorite();
  }

  @override
  Widget build(BuildContext context) {
    double scale = MyApp.isMobile ? 1 : 1.5 * 0.75;
    return Scaffold(
      body: SafeArea(
        child: FavoritesViewBody(scale: scale),
      ),
    );
  }
}
