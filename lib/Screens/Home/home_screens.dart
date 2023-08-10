import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF63BFAE),

      appBar: AppBar(
          backgroundColor: Color(0xFF63BFAE),
          title: Text(widget.title),
      ),
      body: Center(
        child: Text("On est la"),
      ),
    );
  }
}
