import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BottomNavbarItems extends HookWidget {
  final List buttons;
  final Function itemSelectedCallback;

  const BottomNavbarItems(
      {super.key, required this.buttons, required this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    var selectedIndex = useState(1);

    return BottomNavigationBar(
      onTap: (index) {
        selectedIndex.value = index;
        itemSelectedCallback(index);
      },
      currentIndex: selectedIndex.value,
      type: BottomNavigationBarType.fixed,
      items: buttons
          .map(
            (button) => BottomNavigationBarItem(
              icon: Icon(button["icon"]),
              label: button["label"],
            ),
          )
          .toList(),
    );
  }
}
