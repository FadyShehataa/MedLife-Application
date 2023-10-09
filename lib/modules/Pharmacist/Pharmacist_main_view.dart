import 'package:flutter/material.dart';
import '../PATIENT/Chat/presentation/views/chats_view.dart';
import 'Pharmacist%20Home/presentation/views/add_product_view.dart';
import 'Pharmacist%20Home/presentation/views/pharmacist_home_view.dart';
import 'Pharmacist%20Profile/presentation/views/pharmacist_profile_view.dart';
import 'Pharmacist Orders/presentation/pharmacist_orders_view.dart';
import '../../core/utils/constants.dart';

import 'Pharmacist Predict/presentation/views/pharmacist_predict_view.dart';
import 'Pharmacist Profile/presentation/views/widgets/edit_pharmacist_view.dart';

class PharmacistMainView extends StatefulWidget {
  PharmacistMainView([this._selectedIndex = 0, Key? key]) : super(key: key);

  int _selectedIndex;

  @override
  State<PharmacistMainView> createState() => _PharmacistMainViewState();
}

class _PharmacistMainViewState extends State<PharmacistMainView> {
  final List<Widget> _widgetOptions = <Widget>[
    const PharmacistHomeView(),
    const PharmacistOrdersView(),
    const AddProductView(),
    const ChatsView(),
    const PharmacistProfileView()
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            (widget._selectedIndex == -2 || widget._selectedIndex == 5)
                ? 4
                : widget._selectedIndex,
        selectedItemColor:
            widget._selectedIndex == -2 ? Colors.grey : MyColors.myBlue,
        selectedLabelStyle: TextStyle(
          color: widget._selectedIndex == -2 ? Colors.grey : MyColors.myBlue,
        ),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: widget._selectedIndex == -2 ? 14 : 16,
        selectedIconTheme:
            widget._selectedIndex == -2 ? null : const IconThemeData(size: 32),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) async {
          setState(() => widget._selectedIndex = index);
        },
      ),
      body: (widget._selectedIndex == 5)
          ? const EditPharmacistProfileView()
          : widget._selectedIndex == -2
              ? const PharmacistPredictView()
              : _widgetOptions.elementAt(widget._selectedIndex),
    );
  }
}
