import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import '../models/category.dart';
import '../scoped_model/main_model.dart';

class CategoriesSearchField extends StatefulWidget {
  @override
  _CategoriesSearchFieldState createState() => _CategoriesSearchFieldState();
}

class _CategoriesSearchFieldState extends State<CategoriesSearchField> {

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Category>> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return searchTextField = AutoCompleteTextField<Category>(
          key: key,
          clearOnSubmit: false,
          suggestions: model.allCategories,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search for categories'),
          itemFilter: (category, query) {
            return category.name
                .toLowerCase()
                .startsWith(query.toLowerCase());
          },
          itemSorter: (a, b) {
            return a.name.compareTo(b.name);
          },
          itemSubmitted: (category) {
            setState(() {
              searchTextField.textField.controller.text =
                  category.name;
            });
          },
          itemBuilder: (BuildContext context, Category category) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(category.name),
            );
          },
        );
      },
    );
  }
}
