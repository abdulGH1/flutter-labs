import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: ListPage(),
  ));
}


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<Map<String, dynamic>> _items = [];
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addItem() {
    String item = _itemController.text.trim();
    String qty = _quantityController.text.trim();

    if (item.isNotEmpty && qty.isNotEmpty) {
      setState(() {
        _items.add({"item": item, "quantity": int.tryParse(qty) ?? 1});
        _itemController.clear();
        _quantityController.clear();
      });
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete Item"),
        content: Text("Do you want to delete '${_items[index]['item']}'?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _items.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Demo Home Page")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _itemController,
                  decoration: InputDecoration(hintText: "Type the item here"),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Type the quantity here"),
                ),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                onPressed: _addItem,
                child: Text("Click here"),
              )
            ]),
            SizedBox(height: 20),
            Expanded(
              child: _items.isEmpty
                  ? Center(child: Text("There are no items in the list"))
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (ctx, index) {
                  final item = _items[index];
                  return GestureDetector(
                    onLongPress: () => _confirmDelete(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("${index + 1}: ${item['item']}"),
                          ),
                          Text("quantity: ${item['quantity']}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
