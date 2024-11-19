import 'package:flutter/material.dart';

class ProductDetailsView extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailsView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['thumbnail']),
            SizedBox(height: 16),
            Text(
              product['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 8),
            Text('\$${product['price']}',
                style: TextStyle(color: Colors.green, fontSize: 16)),
            SizedBox(height: 16),
            Text('Description:'),
            SizedBox(height: 8),
            Text(product['description'] ?? 'No description available'),
          ],
        ),
      ),
    );
  }
}
