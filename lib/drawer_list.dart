import 'package:flutter/material.dart';
import 'package:aula2/domain/usuario.dart';
import 'package:aula2/utils/nav.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future future = Usuario.getPrefs();

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Container();
        }

        Usuario usuario = snapshot.data;

        return _menu(context, usuario);
      },
    );
  }

  _menu(context, Usuario usuario) {
    return SafeArea(
      child: Container(
        color: Colors.grey[200],
        width: 320,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(usuario != null ? usuario.nome : ""),
              accountEmail: Text(usuario != null ? usuario.email : ""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.iconscout.com/icon/free/png-256/avatar-372-456324.png"),
              ),
              otherAccountsPictures: <Widget>[
                Image.asset("assets/imgs/android.png")
              ],
            ),
            Column(
              children: <Widget>[
                _menuItem("Home", Icons.home),
                _menuItem("Star", Icons.star),
                _menuItem("Favoritos", Icons.favorite),
                _menuItem("Logout", Icons.arrow_back,
                    onClick: () => _onClickLogout(context)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _menuItem(title, icon, {Function onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: ListTile(
        leading: Icon(
          icon,
          size: 50,
          color: Colors.red,
        ),
        trailing: Icon(
          Icons.forward,
          size: 50,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
          ),
        ),
        subtitle: Text(
          "mais informações...",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  _onClickLogout(context) {
    pop(context);
    pop(context);
    print("Logout");
  }
}