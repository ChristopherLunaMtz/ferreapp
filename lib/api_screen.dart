import 'dart:convert';

import 'package:ferreapp/articulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  var list = <Articulo>[];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _getInint();
    super.initState();
  }

  _getInint() async {
    setState(() {});
    await _get();
  }

  _get() async {
    final response = await http.get(Uri.parse('http://192.168.137.1:5000/data'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      data = jsonDecode(utf8.decode(response.bodyBytes));
      var Array = data;
      for (final json in Array) {
        final object = Articulo.fromJson(json);

        list.add(object);
      }
      // return list;
      Future.delayed(Duration(seconds: 1)).then((value) {
        _isLoading = false;
        setState(() {});
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ferreteria Cat')),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Placeholder for image
                        Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(Icons.image, size: 40, color: Colors.grey[700]),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Precio: \$${item.price?.toStringAsFixed(2) ?? 'N/A'}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Cant.: ${item.quantity ?? 'N/A'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
