import 'package:flutter/material.dart';
import 'package:coric_tennis/base/pair.dart';
import 'package:coric_tennis/common/image.dart';

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
  final List<Pair<String, dynamic>> schema;
  final List<dynamic> rows;
  final Map<String, dynamic>? infoMap;

  const PDataTable(
      {Key? key, required this.schema, required this.rows, this.infoMap})
      : super(key: key);

  @override
  State<PDataTable> createState() => _PDataTableState();
}

class _PDataTableState extends State<PDataTable> {
  final bool _loading = false;
  final int _rowsPerPage = 5;
  DataSource? _rows;

  @override
  void initState() {
    super.initState();
  }

  DataColumn constructColumn(Pair<String, dynamic> element) {
    return DataColumn(label: Text(element.first));
  }

  dynamic getColumnDef(Pair<String, dynamic> element) {
    return element.second;
  }

  List<DataColumn> buildHeaders() {
    List<DataColumn> headers = [];
    for (var entry in widget.schema) {
      final columnDef = getColumnDef(entry);
      if (columnDef["hidden"]) {
        continue;
      }
      headers.add(constructColumn(entry));
    }
    return headers;
  }

  @override
  Widget build(BuildContext context) {
    // print("rows的大小为${widget.rows.length}");
    // 生成每行的数据
    List<DataRow> rs = [];
    if (widget.rows.isNotEmpty) {
      rs = widget.rows.asMap().entries.map((row) {
        List<DataCell> cells = [];
        for (var item in widget.schema) {
          var columnDef = getColumnDef(item);
          if (columnDef["hidden"]) {
            continue;
          }
          if (columnDef.containsKey("mapFunc")) {
            cells.add(DataCell(Text(columnDef["mapFunc"](
                    widget.infoMap?[row.value[columnDef["col"]]])
                .toString())));
          } else if (columnDef.containsKey("itemFunc")) {
            cells.add(DataCell(Text(
                columnDef["itemFunc"](row.value[columnDef["col"]])
                    .toString())));
          } else if (columnDef.containsKey("flag")) {
            cells.add(
                DataCell(IocFlag(row.value[columnDef["col"]], height: 20)));
          } else {
            cells.add(DataCell(Text(row.value[columnDef["col"]].toString())));
          }
        }
        return DataRow(cells: cells);
      }).toList();
    }
    _rows = DataSource(rs);

    return Stack(
      children: [
        SingleChildScrollView(
          child: PaginatedDataTable(
            columnSpacing: 12,
            horizontalMargin: 12,
            headingRowHeight: 40,
            dataRowMinHeight: 40,
            dataRowMaxHeight: 40,
            showFirstLastButtons: true,
            rowsPerPage: _rowsPerPage,
            availableRowsPerPage: const [5, 10, 50],
            columns: buildHeaders(),
            source: _rows ?? DataSource([]),
          ),
        ),
        if (_loading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
