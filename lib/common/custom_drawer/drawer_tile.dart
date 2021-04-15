import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/page_manager.dart';

class DrawerTile extends StatelessWidget {

 // ignore: use_key_in_widget_constructors
 const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().page;
    final Color primColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Icon(
                  iconData,
                  size: 32,
                  color:currentPage == page ? primColor : Colors.grey[700],
                ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: currentPage == page ? primColor : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
