import 'package:app_emblem/Screens/Offer/components/list_item.dart';
import 'package:app_emblem/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final _controller = ScrollController();

  double get maxHeight =>
      MediaQuery
          .of(context)
          .size
          .height * 0.35;

  double get minHeight =>
      MediaQuery
          .of(context)
          .size
          .height * 0.23;

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
              CustomAppBar(minHeight: minHeight,maxHeight: maxHeight,),
              ListItem()
            ],
          ),
        )
    )
    ;
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
      _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(() =>
          _controller.animateTo(snapOffset,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}

class CustomAppBar extends StatelessWidget {
  final double minHeight;
  final double maxHeight;
  const CustomAppBar({Key? key,required this.minHeight,required this.maxHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.brown,
      pinned: true,
      stretch: true,
      flexibleSpace: Header(
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      collapsedHeight: minHeight - MediaQuery
          .of(context)
          .padding
          .top,
      expandedHeight: maxHeight - MediaQuery
          .of(context)
          .padding
          .top,
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
            //_buildImage(),
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
      //margin: EdgeInsets.only(bottom: 12, left: 10,right: 10),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: AlignmentTween(
                    begin: Alignment.bottomCenter, end: Alignment.bottomLeft)
                    .evaluate(animation),
                child: Text(
                  "THE WEEKEND",
                  style: TextStyle(
                    fontSize: Tween<double>(begin: 18, end: 36).evaluate(animation),
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              Container(
                height: 33,
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.blue[200 + index % 4 * 100],
                            height: 100 + index % 4 * 20.0,
                            child: Text('Item: ${index}'),
                          );
                        },
                        childCount: 20,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 14,
              ),
              //Expanded
              Container(
                height: 33,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  decoration: InputDecoration(hintText: "Rechercher..."),
                ),
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
          colors: [
            Colors.transparent,
            ColorTween(begin: Colors.black87, end: Colors.black38)
                .evaluate(animation)!
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Image _buildImage() {
    return Image.network(
      "https://www.rollingstone.com/wp-content/uploads/2020/02/TheWeeknd.jpg",
      fit: BoxFit.cover,
    );
  }
}

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SliverPersistentHeader(
        floating: true,
        pinned: true,
        delegate: MyDelegate(
            Container(
              padding: EdgeInsets.only(top: 10),
              height: queryData.size.height*0.2,
              width: queryData.size.width-queryData.size.width/10,
              color: kAppPrimaryColorDark,
              child: AutocompleteEmblem(),
            ),
            queryData.size.height*0.2
        )
    );
  }
}
/*return SliverAppBar(
      backgroundColor: kBackgroundColor,
      pinned: true,
      floating: false,
      bottom: PreferredSize(
        preferredSize: Size(200, 3),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
          ),
        ),
        child: CupertinoTextField(
          controller: _controller,
        ),
      ),
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
          ),
        ),
      ),
    );
  }
}*/


class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.container,this.height);
  final Container container;
  final double height;



  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return container;
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
      onSelected: (String selection) {
        print('You just selected $selection');
      },
    );
  }
}


