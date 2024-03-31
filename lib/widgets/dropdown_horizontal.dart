import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DropdownHorizontal extends StatefulWidget {
  const DropdownHorizontal({
    super.key,
  });

  @override
  State<DropdownHorizontal> createState() => _DropdownHorizontalState();
}

class _DropdownHorizontalState extends State<DropdownHorizontal> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.more_horiz_sharp,
          size: 40,
          color: Colors.white,
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item, context),
            ),
          ),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item, context),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value!);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: MyFilmAppColors.header,
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
            ...List<double>.filled(MenuItems.secondItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [logout];
  static const List<MenuItem> secondItems = [];

  static const logout = MenuItem(text: 'Đăng xuất');
  // static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item, BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    return InkWell(
      onTap: () async {
        final SharedPreferences pref = await prefs;
        pref.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      },
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              item.text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}
