import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main_model.dart';


class CategoriesGrid extends StatefulWidget {
  @override
  _CategoriesGridState createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
          itemCount: model.allCategories.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Expanded(
                    child: CircleAvatar(
                     radius: 70,
                      backgroundImage: AssetImage(
                          model.allCategories[index].imageUrl),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(model.allCategories[index].name, style: TextStyle(fontSize: 16),),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
