import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_search.dart';
import '../../../../Search/presentation/manager/filter_search_cubit/filter_search_cubit.dart';
import '../../../../Search/presentation/views/search_view.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    Key? key,
    this.insidePharmacy,
    this.pharmacyName,
  }) : super(key: key);

  final bool? insidePharmacy;
  final String? pharmacyName;
  @override
  Widget build(BuildContext context) {
    return CustomSearch(
      hintText: 'Find your drugs',
      autofocus: false,
      onTap: () {
        BlocProvider.of<FilterSearchCubit>(context)
            .filterState(filterName: 'fetchProductInPharmacy');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchView(pharmacyId: pharmacyName),
          ),
        );
      },
      prefixIconButton: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
      ),
      
    );
  }
}
