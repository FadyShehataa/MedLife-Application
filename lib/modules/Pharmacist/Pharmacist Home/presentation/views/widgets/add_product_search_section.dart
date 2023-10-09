import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_search.dart';
import '../../../../Pharmacist%20Home/presentation/manager/add_product_cubit/add_product_cubit.dart';

class AddProductSearchSection extends StatelessWidget {
  AddProductSearchSection({Key? key}) : super(key: key);

  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CustomSearch(
            readonly: false,
            autofocus: false,
            controller: chatController,
            hintText: 'Search Product..',
            suffixIconButton: IconButton(
              onPressed: () {
                BlocProvider.of<AddProductCubit>(context)
                    .searchAddProductQuery(chatController.text);
              },
              icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
            ),
            onSubmitted: (_) {
              BlocProvider.of<AddProductCubit>(context)
                  .searchAddProductQuery(chatController.text);
            },
          ),
        );
      },
    );
  }
}
