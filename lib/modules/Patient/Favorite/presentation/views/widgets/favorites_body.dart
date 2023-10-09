import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../Cart/presentation/manager/cart_cubit/cart_cubit.dart';

import '../../manager/favorite_cubit/favorite_cubit.dart';
import 'medicine_favorite_item.dart';

class FavoritesViewBody extends StatefulWidget {
  const FavoritesViewBody({Key? key, required this.scale}) : super(key: key);
  final double scale;

  @override
  State<FavoritesViewBody> createState() => _FavoritesViewBodyState();
}

class _FavoritesViewBodyState extends State<FavoritesViewBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(builder: (context, state) {
      if (state is FavoriteSuccess) {
        if (state.favorites.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: ((context, index) {
                return MedicineFavoriteItem(
                  favItem: state.favorites[index],
                  scale: widget.scale,
                );
              }),
            ),
          );
        } else {
          return const CustomEmptyWidget(
            image: "assets/images/Empty_Fav.png",
            title: 'No Favorites Yet!',
            subTitle: 'Like an Item you see \n Save them here to your favorite',
          );
        }
      } else if (state is FavoriteFailure) {
        return CustomErrorWidget(
          errMessage: state.errMessage,
        );
      } else if (state is FavoriteLoading) {
        return const CustomLoadingIndicator();
      }
      return Container();
    });
  }
}
