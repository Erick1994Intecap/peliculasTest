import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en Cines'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
        ],
      ),
      // body: Container(
      //   child: Center(
      //     child: Text('Home Screen'),
      //   ),
      // ),
      // body: Column(
      //   children: [CardSwiper(), MovieSlider()],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [CardSwiper(), MovieSlider()],
        ),
      ),
    );
  }
}
