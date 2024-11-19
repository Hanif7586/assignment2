import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_view/ProductProvider.dart';


class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final favorites = productProvider.favorites;

    if (favorites.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Favorites')),
        body: const Center(
          child: Text('No favorite products yet!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return ListTile(
            leading: Image.network(
              product['thumbnail'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product['title']),
            subtitle: Text('\$${product['price']}'),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                productProvider.toggleFavorite(product);
              },
            ),
          );
        },
      ),
    );
  }
}
