import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './models/data_service.dart';
import './components/bottom_navbar_items.dart';
import './components/list_objects.dart';

final dataService = DataService();

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(1);
    final quantity = useState(5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              dataService.loadObjects(selectedIndex.value);
            },
          ),
          PopupMenuButton(
            initialValue: quantity.value,
            onSelected: (value) {
              quantity.value = value;
              dataService.buildQuantity = value;
              dataService.loadObjects(selectedIndex.value);
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 5,
                  child: Text("5 items"),
                ),
                const PopupMenuItem(
                  value: 10,
                  child: Text("10 items"),
                ),
                const PopupMenuItem(
                  value: 15,
                  child: Text("15 items"),
                ),
              ];
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: dataService.tableStateNotifier,
        builder: (_, value, __) {
          return ListObjects(
            objects: value,
            propertyNames: value.isNotEmpty ? value[0].keys.toList() : null,
            columnNames: value.isNotEmpty
                ? value[0]
                    .keys
                    .toList()
                    .map((key) => key.replaceRange(0, 1, key[0].toUpperCase()))
                    .toList()
                : null,
          );
        },
      ),
      bottomNavigationBar: BottomNavbarItems(
        buttons: const [
          {"label": "Coffe", "icon": Icons.coffee_maker},
          {"label": "Drinks", "icon": Icons.local_drink},
          {"label": "Nações", "icon": Icons.flag},
        ],
        itemSelectedCallback: (index) {
          selectedIndex.value = index;
          dataService.loadObjects(index);
        },
      ),
    );
  }
}
