import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Todo"),),
      bottomNavigationBar: SizedBox(
        height: 60.0,
              child: BottomAppBar(
          shape:CircularNotchedRectangle(),
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:<Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: null),
            IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          ],)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(child: FloatingActionButton(onPressed: (){},child:Icon(Icons.add),)),
      body: Text("Hello"),
    );
  }
}