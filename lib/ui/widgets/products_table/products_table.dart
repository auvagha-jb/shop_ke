import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';

class ProductsTableWidget extends StatefulWidget {
  final List<Product> products;

  const ProductsTableWidget(this.products, {Key key}) : super(key: key);

  @override
  _ProductsTableWidgetState createState() => _ProductsTableWidgetState();
}

class _ProductsTableWidgetState extends State<ProductsTableWidget> {
  final List<String> productsHeaders = ['#', 'Name', 'Price', 'Num'];

  List<DataColumn> _buildHeaders() {
    return List.generate(
      productsHeaders.length,
      (index) {
        String header = productsHeaders[index];
        return DataColumn(
          label: Text(
            header,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  List<DataRow> _buildRows(products) {
    return List.generate(
      products.length,
      (index) {
        Product product = products[index];
        return DataRow(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(product.productName)),
              DataCell(Text('${product.price}')),
              DataCell(Text('${product.numInStock}')),
            ],
            onSelectChanged: (bool selected) {
              if (selected) {
                Product product = products[index];
                print(product.toMap());
              }
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DataTable(
          columns: _buildHeaders(),
          rows: _buildRows(widget.products),
        ),
      ],
    );
  }
}
