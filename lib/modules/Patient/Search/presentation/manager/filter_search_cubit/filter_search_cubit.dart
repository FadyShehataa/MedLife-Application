import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'filter_search_state.dart';

class FilterSearchCubit extends Cubit<FilterSearchState> {
  FilterSearchCubit() : super(FilterSearchInitial());

  late Position? currentPosition;

  static FilterSearchCubit get(context) => BlocProvider.of(context);

  void updatePosition(position) {
    currentPosition = position;
  }

  String type = 'Find Pharmacy';
  void filterState({String? filterName}) {
    if (filterName == 'Find Pharmacy') {
      type = filterName!;
      emit(FilterSearchPharmacies());
    } else if (filterName == 'fetchProductInPharmacy') {
      emit(FilterSearchProductInPharmacy());
    } else if (filterName == 'Find Product in Nearest Pharmacy') {
      type = filterName!;
      emit(FilterSearchProductInPharmacies());
    }
  }

  void searchType({String? filterName}) {
    if (filterName == 'Find Pharmacy') {
      type = filterName!;
      emit(FindPharmacyType());
    } else if (filterName == 'Find Product in Nearest Pharmacy') {
      type = filterName!;
      emit(FindProductInNearestPharmacyType());
    }
  }
}
