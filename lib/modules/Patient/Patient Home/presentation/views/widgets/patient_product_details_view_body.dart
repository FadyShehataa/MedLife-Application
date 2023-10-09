import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Cart/presentation/manager/cart_cubit/cart_cubit.dart';
import '../../../../Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../../Favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import '../../../../../PHARMACIST/Pharmacist%20Home/data/models/pharmacist_product_model/pharmacist_product_model.dart';
import '../../../../../../core/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../PATIENT/Patient Home/presentation/views/widgets/custom_title.dart';

class PatientProductsDetailsViewBody extends StatelessWidget {
  PatientProductsDetailsViewBody(
      {Key? key, this.images, this.price, this.name, this.id})
      : super(key: key);

  final PharmacistProductModel pharmacistProductModel =
      PharmacistProductModel();

  final pageController = PageController(viewportFraction: 0.8, keepPage: true);

  final List<String>? images;
  final int? price;
  final String? name;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.myBlack),
        actions: [
          BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              bool itemInFavorite = BlocProvider.of<FavoriteCubit>(context)
                  .favorites
                  .any((element) => element.id == id);
              return IconButton(
                padding: const EdgeInsets.only(right: 25),
                icon: Icon(
                  Icons.favorite,
                  color: itemInFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  if (itemInFavorite) {
                    BlocProvider.of<FavoriteCubit>(context)
                        .deleteItemFromFavorite(cartID: id!);
                  } else {
                    BlocProvider.of<FavoriteCubit>(context)
                        .addItemToFavorite(cartID: id!);
                  }
                },
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: [
                Container(
                  height: 300,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 240,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: images!.length,
                          itemBuilder: (_, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.grey.shade300,
                              ),
                              child: SizedBox(
                                height: 280,
                                child: Center(
                                  child: Image.network(
                                    images![index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: images!.length,
                        effect: const WormEffect(
                          dotHeight: 16,
                          dotWidth: 16,
                          type: WormType.thinUnderground,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          readOnly: true,
                          initialValue: name,
                        ),
                      ),
                      const SizedBox(width: 35),
                      const Text(
                        'Price:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          readOnly: true,
                          initialValue: price.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    bool itemInCart = BlocProvider.of<CartCubit>(context)
                        .cart
                        .any((element) => element.id == id);
                    return CustomElevatedButton(
                      radius: 8,
                      backgroundColor: itemInCart
                          ? Colors.grey
                          : MyColors.myBlue, //Colors.blue,
                      onPressed: () {
                        if (itemInCart) {
                          String quantity = BlocProvider.of<CartCubit>(context)
                              .cart
                              .firstWhere((element) => element.id == id)
                              .quantity!
                              .toString();

                          BlocProvider.of<CartCubit>(context)
                              .deleteItemFromCart(
                                  cartID: id!, quantity: quantity);
                        } else {
                          BlocProvider.of<CartCubit>(context)
                              .addItemToCart(cartID: id!);
                        }
                      },
                      child: itemInCart
                          ? const Text(
                              'Added to cart',
                              style: TextStyle(fontSize: 20),
                            )
                          : const Text(
                              'Add to cart',
                              style: TextStyle(fontSize: 20),
                            ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomTitle(text: 'Details'),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                    return DetailsItem(
                      detailHeader: details[index],
                      // detailCollapsed: jsonDecode(jsonEncode(
                      //         pharmacistProductModel.product))[details[index]]
                      //     .cast<String>()
                      //     .join('\n'),
                      detailCollapsed: 'Details',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<String> details = [
    "description",
    "indication",
    "sideEffects",
    "dosage",
    "overdoseEffects",
    "precautions",
    "interactions",
    "storage"
  ];
}

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    Key? key,
    required this.detailHeader,
    required this.detailCollapsed,
  }) : super(key: key);

  final String detailHeader;
  final String detailCollapsed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ExpandablePanel(
          controller: ExpandableController(initialExpanded: true),
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Text(
            detailHeader,
            style: const TextStyle(fontSize: 18),
          ),
          collapsed: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              detailCollapsed,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          expanded: const SizedBox(),
        ),
      ),
    );
  }
}
