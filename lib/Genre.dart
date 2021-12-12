import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Movie.dart';
import 'database-provider.dart';

class GenreScreen extends StatefulWidget {
  String title = "";
  List list;
  List<List<Movie>> list2;
  GenreScreen(this.title, this.list, this.list2);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<GenreScreen> with TickerProviderStateMixin {
  late int _startingTabCount;

  List<Tab> _tabs = <Tab>[];
  List<Widget> _generalWidgets = <Widget>[];
  late TabController _tabController;

  @override
  void initState() {
    _startingTabCount = 9;
    _tabs = getTabs(_startingTabCount);
    _tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          isScrollable: true,
          tabs: _tabs,
          controller: _tabController,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.black87,
              ],
              stops: [0.3, 1.0],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.skip_previous),
            color: Colors.white,
            onPressed: () {
              goToPreviousPage();
            },
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.skip_next),
              color: Colors.white,
              onPressed: () {
                goToNextPage();
              },
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: getWidgets(),
            ),
          ),
        ],
      ),
    );
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this)
      ..addListener(_updatePage);
  }

  Tab getTab(int widgetNumber) {
    return Tab(
      text: widget.list[widgetNumber].toString(),
    );
  }

  Widget getWidget(int widgetNumber) {
    return Center(
      child: Consumer<Databasemodules>(builder: (context, value, child) {
        value.getCategory();
        return ListView.builder(
            itemCount: widget.list2[widgetNumber].length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(4),
                height: 130,
                child: Card(
                  child: Row(
                    children: [
                      Image.network(
                        widget.list2[widgetNumber][index].image,
                        height: 90,
                        width: 90,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                              height: 80,
                              width: 100,
                              color: Colors.indigoAccent,
                              alignment: Alignment.center,
                              child: Icon(Icons.image));
                        },
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.list2[widgetNumber][index].title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(widget.list2[widgetNumber][index].year
                                .toString()),
                            Text(widget.list2[widgetNumber][index].genre),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                widget.list2[widgetNumber][index].type,
                                style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    color: Colors.redAccent[500]),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (int i = 0; i < count; i++) {
      _tabs.add(getTab(i));
    }
    return _tabs;
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _generalWidgets.add(getWidget(i));
    }
    return _generalWidgets;
  }

  void _updatePage() {
    setState(() {});
  }

  //Tab helpers

  bool isFirstPage() {
    return _tabController.index == 0;
  }

  bool isLastPage() {
    return _tabController.index == _tabController.length - 1;
  }

  void goToPreviousPage() {
    _tabController.animateTo(_tabController.index - 1);
  }

  void goToNextPage() {
    isLastPage()
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text("End reached"),
                content: Text("This is the last page.")))
        : _tabController.animateTo(_tabController.index + 1);
  }
}
