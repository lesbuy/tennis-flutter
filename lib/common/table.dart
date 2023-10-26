import 'dart:math';
import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  final List<DataRow> _dataRows;
  DataSource(this._dataRows);

  @override
  DataRow getRow(int index) {
    return _dataRows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _dataRows.length;

  @override
  int get selectedRowCount => 0;
}

class PDataTable extends StatefulWidget {
  const PDataTable({Key? key}) : super(key: key);

  @override
  State<PDataTable> createState() => _PDataTableState();
}

class _PDataTableState extends State<PDataTable> {
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: [
        DataColumn(label: Text("ID")),
        DataColumn(label: Text("排名")),
        DataColumn(label: Text("积分")),
      ],
      source: DataTableSource(),
    );
  }
}
