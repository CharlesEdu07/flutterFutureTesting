import 'package:flutter/material.dart';

class ListObjects extends StatelessWidget {
  final List objects;
  final List? propertyNames;
  final List? columnNames;

  const ListObjects({super.key, 
    required this.objects,
    required this.propertyNames,
    this.columnNames,
  });

  @override
  Widget build(BuildContext context) {
    print("Build da classe: ${toStringShort()}");

    List<DataColumn> columns = [];
    List<DataRow> rows = [];

    if (columnNames == null) {
      if (propertyNames == null) {
        if (objects.isNotEmpty) {
          columns = objects[0]
              .entries
              .map((entry) => DataColumn(label: Text(entry.key)))
              .toList();
        }
      } else {
        columns = propertyNames!
            .map((property) => DataColumn(label: Text(property)))
            .toList();
      }
    } else {
      columns = columnNames!
          .map((column) => DataColumn(label: Text(column)))
          .toList();
    }

    rows = objects
        .map((drink) => DataRow(
              cells: propertyNames == null
                  ? drink.entries
                      .map((entry) => DataCell(Text(entry.value.toString())))
                      .toList()
                  : propertyNames!
                      .map((property) =>
                          DataCell(Text(drink[property].toString())))
                      .toList(),
            ))
        .toList();

    return SizedBox(
        child: objects.isEmpty
            ? Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 150),
                    const Text(
                      'Nenhum item selecionado',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              )
            : ListView(
                children: [
                  DataTable(
                    columns: columns,
                    rows: rows,
                  ),
                ],
              ));
  }
}
