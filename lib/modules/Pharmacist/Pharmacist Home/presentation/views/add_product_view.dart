import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Pharmacist%20Home/presentation/manager/add_product_cubit/add_product_cubit.dart';
import '../../../Pharmacist%20Home/presentation/views/widgets/add_product_view_body.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  @override
  void initState() {
    super.initState();
    fetchSystemProducts();
  }

  Future<void> fetchSystemProducts() async {
    await BlocProvider.of<AddProductCubit>(context).fetchSystemProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AddProductViewBody(),
      ),
    );
  }
}
