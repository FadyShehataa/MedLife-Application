// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medlife_app/core/widgets/custom_search.dart';
// import 'package:medlife_app/modules/PATIENT/Search/presentation/manager/search_cubit/search_cubit.dart';

// class CustomSearchProductInPharmacies extends StatelessWidget {
//   CustomSearchProductInPharmacies({
//     Key? key,
//   }) : super(key: key);

//   final TextEditingController searchProductController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return CustomSearch(
//       hintText: 'Find Product',
//       controller: searchProductController,
//       prefixIconButton: IconButton(
//         onPressed: () => BlocProvider.of<SearchCubit>(context)
//             .fetchProductInPharmacies(
//                 productName: searchProductController.text),
//         icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
//       ),
//       onSubmitted: (_) => BlocProvider.of<SearchCubit>(context)
//           .fetchProductInPharmacies(productName: searchProductController.text),
//     );
//   }
// }
