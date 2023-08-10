import 'package:app_emblem/Screens/Offer/components/list_item.dart';
import 'package:app_emblem/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final _controller = ScrollController();

  double get maxHeight => MediaQuery.of(context).size.height * 0.27;

  double get minHeight => MediaQuery.of(context).size.height * 0.23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollEndNotification>(
      onNotification: (_) {
        _snapAppbar();
        return false;
      },
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        slivers: [
          CustomAppBar(
            minHeight: minHeight,
            maxHeight: maxHeight,
          ),
          ListItem()
        ],
      ),
    ));
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}

class CustomAppBar extends StatelessWidget {
  final double minHeight;
  final double maxHeight;

  const CustomAppBar(
      {Key? key, required this.minHeight, required this.maxHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      flexibleSpace: Header(
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      collapsedHeight: minHeight - MediaQuery.of(context).padding.top,
      expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
    );
  }
}

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const Header({Key? key, required this.maxHeight, required this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);

        return Stack(
          fit: StackFit.expand,
          children: [
            _buildGradient(animation),
            _buildTitle(animation),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    print(expandRatio);
    return expandRatio;
  }

  Container _buildTitle(Animation<double> animation) {
    return Container(
        //height: minHeight,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: AlignmentTween(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomCenter)
                    .evaluate(animation),
                child: Text(
                  "Offres",
                  style: TextStyle(
                    fontSize:
                        Tween<double>(begin: 35, end: 50).evaluate(animation),
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              Container(height: minHeight / 6, child: Categories()),

              SizedBox(
                height: minHeight / 8,
              ),
              //Expanded
              Container(
                height: minHeight / 5,
                alignment: Alignment.center,
                //margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent.withOpacity(0.1)),
                child: Center(child: AutocompleteEmblem()),
              ),
              //)
            ],
          ),
        ));
  }

  Container _buildGradient(Animation<double> animation) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 0.5, 1],
        colors: [kAppPrimaryColor, kAppSecondaryColor, kBackgroundColor],
      )
          /*gradient: LinearGradient(
          colors: [
              Colors.transparent,
              ColorTween(begin: kAppPrimaryColor, end: kAppSecondaryColor)
                  .evaluate(animation)!
            ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),*/
          ),
    );
  }
}

class AutocompleteEmblem extends StatelessWidget {
  const AutocompleteEmblem({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'Barberousse',
    'San luigi',
    'Tonneau de diogene',
    'Brugs'
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
            //border: OutlineInputBorder(),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "Quel choix d'activité?",
            icon: Icon(Icons.search),
          ),
          //style: const TextStyle(fontWeight: FontWeight.bold),
        );
      },
      onSelected: (String selection) {
        print('You just selected $selection');
      },
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Bar",
    "Restaurant",
    "Loisirs",
    "Utilités",
    "mama",
    "delta",
    "etc"
  ];
  List<bool> selectedIndex = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: selectedIndex[index]?kAppPrimaryColorDark.withOpacity(0.6):kAppPrimaryColor.withOpacity(0.3),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex[index] = !selectedIndex[index];
                        });
                      },
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 20,
                          //fontWeight: selectedIndex[index]?FontWeight.bold : null,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      //stops: [0,1.3],
                      colors: [
                        selectedIndex[index]?kAppPrimaryColor:kAppPrimaryColor.withOpacity(0.1),
                        selectedIndex[index]?kAppSecondaryColor:kAppSecondaryColor.withOpacity(0.2),
                        //kBackgroundColor
                      ],
                    )),
                  ),
                ),
              );
            },
            childCount: categories.length,
          ),
        )
      ],
    );
  }
}
