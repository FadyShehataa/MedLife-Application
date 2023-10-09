import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../../core/widgets/custom_search.dart';
import '../../../../Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../manager/filter_search_cubit/filter_search_cubit.dart';
import '../../manager/search_cubit/search_cubit.dart';

import '../../../../../../core/utils/constants.dart';

class CustomSearchPharmacy extends StatefulWidget {
  const CustomSearchPharmacy({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSearchPharmacy> createState() => _CustomSearchPharmacyState();
}

class _CustomSearchPharmacyState extends State<CustomSearchPharmacy> {
  final TextEditingController searchPharmacyController =
      TextEditingController();

  double? latitude;
  double? longitude;
  bool isShown = false;
  bool requiredLoc = false;
  bool req = false;
  String? dropVal = 'Find Pharmacy';
  Color? color =  MyColors.myBlue;//Colors.blue;
  String? global;

  @override
  Widget build(BuildContext context) {
    var Categories = [
      'Find Pharmacy',
      'Find Product in Nearest Pharmacy',
    ];
    Future<bool> _handleLocationPermission(context) async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }

    Future<void> getCurrentPosition(context) async {
      final hasPermission = await _handleLocationPermission(context);

      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        FilterSearchCubit.get(context).updatePosition(position);
      }).catchError((e) {
        debugPrint(e);
      });
    }

    return Row(
      children: [
        BlocBuilder<FilterSearchCubit, FilterSearchState>(
          builder: (context, state) {
            return Flexible(
              child: CustomSearch(
                readonly: false,
                hintText: BlocProvider.of<FilterSearchCubit>(context).type,
                controller: searchPharmacyController,
                prefixIconButton: IconButton(
                  onPressed: () => BlocProvider.of<FilterSearchCubit>(context)
                              .type ==
                          'Find Pharmacy'
                      ? BlocProvider.of<SearchCubit>(context).fetchPharmacies(
                          searchKey: searchPharmacyController.text)
                      : BlocProvider.of<SearchCubit>(context)
                          .fetchProductInPharmacies(
                          productName: searchPharmacyController.text,
                          lat: latitude,
                          long: longitude,
                        ),
                  icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
                ),
                onSubmitted: (_) =>
                    BlocProvider.of<FilterSearchCubit>(context).type ==
                            'Find Pharmacy'
                        ? BlocProvider.of<SearchCubit>(context).fetchPharmacies(
                            searchKey: searchPharmacyController.text)
                        : BlocProvider.of<SearchCubit>(context)
                            .fetchProductInPharmacies(
                            productName: searchPharmacyController.text,
                            lat: latitude,
                            long: longitude,
                          ),
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enableDrag: false,
              isDismissible: true,
              isScrollControlled: true,
              context: context,
              builder: ((builder) {
                return FractionallySizedBox(
                  heightFactor: 0.6,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 8.0,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text("Set Filters",
                              style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(height: 15),
                        BlocBuilder<FilterSearchCubit, FilterSearchState>(
                          builder: (context, state) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                      value: dropVal,
                                      isExpanded: true,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_sharp),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                      iconSize: 30,
                                      items: Categories.map((String e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                      onChanged: (v) {
                                        BlocProvider.of<FilterSearchCubit>(
                                                context)
                                            .searchType(
                                                filterName: v.toString());
                                        global = v.toString();
                                        dropVal =
                                            BlocProvider.of<FilterSearchCubit>(
                                                    context)
                                                .type;
                                      }),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        BlocBuilder<FilterSearchCubit, FilterSearchState>(
                          builder: ((context, state) {
                            if (state is FindProductInNearestPharmacyType) {
                              requiredLoc = false;
                              return Column(
                                children: [
                                  const Center(
                                    child: Text(
                                      "My Location",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await getCurrentPosition(context);
                                      latitude = FilterSearchCubit.get(context)
                                          .currentPosition
                                          ?.latitude;
                                      longitude = FilterSearchCubit.get(context)
                                          .currentPosition
                                          ?.longitude;
                                      isShown = true;
                                      requiredLoc = true;
                                      BlocProvider.of<FilterSearchCubit>(
                                              context)
                                          .searchType(filterName: global);
                                    },
                                    child: DottedBorder(
                                      strokeWidth: 2,
                                      color: MyColors.myBlue,
                                      //color: Colors.blue,
                                      radius: const Radius.circular(30),
                                      child: Container(
                                        height: 150,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.location_pin,
                                              size: 50,
                                              color: MyColors.myBlue,
                                              //color: Colors.blue,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: isShown
                                                  ? Visibility(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Latitude: ${latitude?.toStringAsFixed(2)}',
                                                            style:
                                                                const TextStyle(
                                                                  color: MyColors.myBlue,
                                                                  //color:
                                                                  //Colors.blue,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            'longitude: ${longitude?.toStringAsFixed(2)}',
                                                            style:
                                                                const TextStyle(
                                                                  color: MyColors.myBlue,
                                                                  //color:
                                                                  //Colors.blue,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Visibility(
                                                      child: Text(
                                                        'Get Current Location',
                                                        style: TextStyle(
                                                          color: color,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              requiredLoc = true;
                            }

                            return Container();
                          }),
                        ),
                        const SizedBox(height: 20),
                        CustomElevatedButton(
                          onPressed: () {

                            if (requiredLoc || isShown) {
                              BlocProvider.of<FilterSearchCubit>(context)
                                  .filterState(filterName: dropVal);
                              Navigator.of(context).pop();
                            } else {
                              color = Colors.red;
                              BlocProvider.of<FilterSearchCubit>(context)
                                  .searchType(filterName: global);
                            }
                          },
                          radius: 8,
                          child: const Text(
                            'Apply',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            );
          },
          icon: const Icon(
            Icons.filter_alt_sharp,
            color: MyColors.myBlue,
            //color: Colors.blue,
          ),
        )
      ],
    );
  }
}
