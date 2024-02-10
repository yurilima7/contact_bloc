import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> routes = [
      '/bloc/example',
      '/bloc/example/freezed',
      '/contacts/list',
      '/contacts/cubit/list',
    ];

    const List<String> titles = [
      'Example',
      'Example Freezed',
      'Contact',
      'Contact Cubit',
    ];

    Widget cards(String title, String route) {
      return InkWell(
        onTap: () => Navigator.of(context).pushNamed(route),
        
        child: Card(
          child: ListTile(
            title: Text(title),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,

          children: List.generate(
            4,
            (index) => cards(
              titles[index],
              routes[index],
            ),
          ),
        ),
      ),
    );
  }
}
