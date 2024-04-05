import 'package:flutter/material.dart';
import 'package:level4_belajar_dio/screen/widget/card_widget.dart';
import 'package:level4_belajar_dio/service/api_service.dart';
import 'package:level4_belajar_dio/model/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fetch API with Dio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your Product',
            ),
            const SizedBox(height: 5),
            FutureBuilder<List<Product>?>(
                // future: ApiService().getProducts(), //get data online
                future: ApiService().getProductsOffline(), //get data offline
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product> listProducts = snapshot.data!;
                    // tampilkan data
                    return Expanded(
                      child: ListView.builder(
                          itemCount: listProducts.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: listProducts[index],
                            );
                          }),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}