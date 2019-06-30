import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main_model.dart';
import '../models/category.dart';

class CategoriesGrid extends StatefulWidget {
  @override
  _CategoriesGridState createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var model = ScopedModel.of<MainModel>(context);
    model.fetchUserCategories();
  }


  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
          itemCount: model.allCategories.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                print('tap action');
                Category category = model.allCategories.singleWhere((category) {
                  return category.id == index.toString();
                }, orElse: () => null);
                if (model.selectedCategories.contains(category)) {
                  // already selected => unselect
                  setState(() {
                    model.removeCategory('$index');
                  });
                } else {
                  // not selected => select
                  setState(() {
                    model.selectCategory('$index');
                  });
                }
              },
              child: Card(
                color: model.selectedCategories.singleWhere((category) {
                          return category.id == '$index';
                        },
                            orElse: () => Category(
                                id: '-1', name: ' ', imageUrl: ' ')).id ==
                        index.toString()
                    ? Colors.grey
                    : Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Expanded(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage(model.allCategories[index].imageUrl),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        model.allCategories[index].name,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
