import 'package:app_emblem/constants.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class Item extends StatelessWidget {
  String nomItem;
  String description;
  int indexList;

  Item(this.nomItem, this.description, this.indexList);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "index :" + indexList.toString();
  }

  @override
  Widget build(BuildContext context) {
    // Permet de connaitre les dimensions du téléphone sur lequel l'application se lance
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    //Création de l'élément
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: queryData.size.height / 100,
          horizontal: queryData.size.width / 20),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: state.selection == indexList
              ? queryData.size.height / 3
              : queryData.size.height / 7,
          width: queryData.size.width - queryData.size.width / 10,
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              state.selectionne(indexList);
            },
            child:
                getWidget(context, queryData, (state.selection == indexList)),
          ),
        ),
      ),
    );
  }

  Widget getWidget(
      BuildContext context, MediaQueryData queryData, bool selection) {
    if (selection == false) {
      return Stack(
        children: [
          Positioned(
            bottom: 50,
            left: 100,
            child: Container(
              child: Text(
                nomItem,
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              height: 70,
              width: 70,
              child: Image.asset("assets/Images/logo-Barberousse.png"),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Positioned(
            top: 15,
            left: 5,
            child: Container(
              height: 100,
              width: 100,
              child: Image.asset("assets/Images/logo-Barberousse.png"),
            ),
          ),
          Positioned(
            left: 75,
            child: Text(
              nomItem,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Positioned(
            right: 50,
            bottom: 100,
            child: Text(
              description,
            ),
          ),
        ],
      );
    }
    //Otherwise if already open we are closing and going to the short edition of the item
  }
}
