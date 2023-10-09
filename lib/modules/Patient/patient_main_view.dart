import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/constants.dart';
import 'Cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'Cart/presentation/views/cart_view.dart';
import 'Chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'Chat/presentation/views/chats_view.dart';
import 'Favorite/presentation/views/favorites_view.dart';
import 'Patient%20Home/presentation/views/pharmacies_home_view.dart';
import 'Patient%20Home/presentation/views/pharmacy_view.dart';
import 'Patient%20Profile/presentation/views/patient_profile_view.dart';
import 'Patient%20Profile/presentation/views/widgets/edit_patient_view.dart';
import 'Reminder/presentation/views/reminder_view.dart';

class PatientMainView extends StatefulWidget {
  PatientMainView([this._selectedIndex = 0, this.pharmacy, Key? key])
      : super(key: key);
  int _selectedIndex;
  dynamic pharmacy;

  @override
  State<PatientMainView> createState() => _PatientMainViewState();
}

class _PatientMainViewState extends State<PatientMainView> {
  final List<Widget> _widgetOptions = <Widget>[
    const PharmaciesHomeView(),
    const FavoritesView(),
    const CartView(),
    const ReminderView(),
    const PatientProfileView()
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: (widget._selectedIndex == 5 || widget._selectedIndex == 6)
            ? 4
            : widget._selectedIndex == 7
                ? 0
                : widget._selectedIndex,
        selectedItemColor: widget._selectedIndex == 6
            ? Colors.grey
            : MyColors.myBlue, //Colors.blue,
        selectedLabelStyle: TextStyle(
          color: widget._selectedIndex == 6
              ? Colors.grey
              : MyColors.myBlue, //Colors.blue,
        ),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: widget._selectedIndex == 6 ? 14 : 16,
        selectedIconTheme:
            widget._selectedIndex == 6 ? null : const IconThemeData(size: 32),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Reminder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            widget._selectedIndex = index;
          });
        },
      ),
      body: (widget._selectedIndex == 5)
          ? const EditPatientProfileView()
          : widget._selectedIndex == 6
              ? const ChatsView()
              : widget._selectedIndex == 7
                  ? PharmacyView(
                      pharmacy: widget.pharmacy,
                    )
                  : _widgetOptions.elementAt(widget._selectedIndex),
      floatingActionButton: (widget._selectedIndex == 0)
          ? FloatingActionButton(
              onPressed: () async {
                await BlocProvider.of<ChatsCubit>(context).fetchChats();

                setState(() => widget._selectedIndex = 6);
              },
              child: const Icon(Icons.chat),
            )
          : null,
    );
  }
}
