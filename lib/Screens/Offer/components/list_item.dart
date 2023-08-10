import 'package:flutter/material.dart';
import 'item.dart';


class _MyInherited extends InheritedWidget {
  _MyInherited({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final MyInheritedWidgetState data;

  @override
  bool updateShouldNotify(_MyInherited oldWidget) {
    return true;
  }
}

class MyInheritedWidget extends StatefulWidget {
  MyInheritedWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  MyInheritedWidgetState createState() => new MyInheritedWidgetState();

  static MyInheritedWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_MyInherited>()
    as _MyInherited)
        .data;
  }
}

class MyInheritedWidgetState extends State<MyInheritedWidget> {
  int selection = -1;

  void selectionne(int index){
    setState(() {
      if(index==selection){
        selection=-1;
      }
      else{
        selection=index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _MyInherited(
      data: this,
      child: widget.child,
    );
  }
}

class ListItem extends StatefulWidget {

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List partenaires = [["Barberousse","Ici c'est trop bien on boit des coups..."],
    ["Tonneau de Diogène","Ici c'est trop bien on boit des coups..."],
    ["Pizza San Luigi","Ici c'est trop bien on mange des pizzas"],
    ["Prout","Ici c'est trop bien on boit des coups..."],
    ["Brugs","Ici c'est trop bien on boit des coups..."],
    ["CinémaFolies","Ici c'est trop bien on boit des coups..."]];


  @override
  Widget build(BuildContext context) {


    return MyInheritedWidget(
      child: SliverList(
          delegate: SliverChildBuilderDelegate(
              (BuildContext context , int index){
                Item item=Item(partenaires[index][0],partenaires[index][1],index);
                return item;
              },
              childCount: partenaires.length,
          )
        ),
    );
  }
}

