import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
    home: MainScreen(),
    title: 'Nav Basics',
  ),
  );
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen();
          }));
        },
        child: Hero(
          tag: 'pehla hero',
          child: Image.network(
          'https://picsum.photos/250?image=9',
        ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'pehla hero',
            child: Image.network(
            'https://picsum.photos/250?image=9',
          ),
          ),
        ),
      ),
    );
  }
}