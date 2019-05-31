import 'package:aula2/pages/favorites_page.dart';
import 'package:aula2/pages/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:aula2/domain/carro.dart';
import 'package:aula2/domain/carro_service.dart';
import 'package:aula2/drawer_list.dart';
import 'package:aula2/utils/alert.dart';

TabController tabController;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController.index = 0;
    tabController.addListener(() async {
      int idx = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text("POSITIVO"),
          bottom: TabBar(
            indicatorColor: Colors.greenAccent[400],
            controller: tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.greenAccent[400],
//            unselectedLabelStyle: ,
            tabs: <Widget>[
              Tab(
                text: "Filmes",
                icon: Icon(Icons.movie),
              ),Tab(
                text: "Meus filmes",
                icon: Icon(Icons.favorite),
              )
            ],
          ),
      ),
      body: _body(context),
//      drawer: DrawerList(),
    );
  }

  _body(context){
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        MoviesPage(),
        FavoritesPage()
      ],
    );
  }
}



