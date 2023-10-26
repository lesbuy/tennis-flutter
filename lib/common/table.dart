import 'dart:math';
import 'package:flutter/material.dart';
import 'package:coric_tennis/base/pair.dart';
import 'package:flutter/rendering.dart';

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
  List<Pair<String, String>> schema;
  List<dynamic> rows;
  PDataTable({Key? key, required this.schema, required this.rows})
      : super(key: key);

  @override
  State<PDataTable> createState() => _PDataTableState();
}

class _PDataTableState extends State<PDataTable> {
  bool _loading = false;
  int _rowsPerPage = 5;
  DataSource? _rows;

  @override
  void initState() {
    super.initState();
  }

  DataColumn constructColumn(Pair<String, String> element) {
    return DataColumn(label: Text(element.first));
  }

  String getDbColumn(Pair<String, String> element) {
    return element.second;
  }

  List<DataColumn> buildHeaders() {
    return widget.schema.asMap().entries.map((entry) {
      return constructColumn(entry.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // print("rows的大小为${widget.rows.length}");
    List<DataRow> rs = [];
    if (widget.rows.isNotEmpty) {
      rs = widget.rows.asMap().entries.map((row) {
        List<DataCell> cells = widget.schema
            .asMap()
            .entries
            .map((col) {
              return getDbColumn(col.value);
            })
            .toList()
            .asMap()
            .entries
            .map((e) => DataCell(Text(row.value[e.value].toString())))
            .toList();
        return DataRow(cells: cells);
      }).toList();
    }
    _rows = DataSource(rs);
    return Stack(
      children: [
        SingleChildScrollView(
          child: PaginatedDataTable(
            header: const Text('Rankings'),
            rowsPerPage: _rowsPerPage,
            availableRowsPerPage: [5, 10, 20],
            columns: buildHeaders(),
            source: _rows ?? DataSource([]),
          ),
        ),
        if (_loading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
