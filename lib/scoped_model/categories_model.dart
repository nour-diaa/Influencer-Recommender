import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';

mixin CategoriesModel on Model {
  List<Category> _allCategories =
      _initCategories(); // list of all available categories
  List<Category> _selectedCategories = []; // list of user favorite categories

  // getters
  List<Category> get allCategories => _allCategories;

  List<Category> get selectedCategories => _selectedCategories;

  // ignore: slash_for_doc_comments
  /**
   *  adds a category to the user favorite categories
   *  TODO save the selected category to the user profile in the API
   */
  void selectCategory(String id) async {
    Category category = _allCategories.singleWhere((category) {
      return category.id == id;
    });
    _selectedCategories.add(category);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cats = prefs.getString('cats') ?? '';
    cats += '#$id';
    print('added cats $cats');
    prefs.setString('cats', cats);
    notifyListeners();
  }

  // ignore: slash_for_doc_comments
  /**
   *  removes a category from the user favorite categories
   *  TODO save changes in the user profile at the API
   */
  void removeCategory(String id) async {
    Category category = _selectedCategories.singleWhere((category) {
      return category.id == id;
    });
    final int index = _selectedCategories.indexOf(category);
    _selectedCategories.removeAt(index);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cats = prefs.getString('cats') ?? '';
    cats = cats.replaceAll('#$id', '');
    print('removed cats at #$id');
    print('removed cats current $cats');
    prefs.setString('cats', cats);
    notifyListeners();
  }

  // ignore: slash_for_doc_comments
  /**
   *  removes all categories from the user favorite categories
   *  TODO save changes in the user profile at the API
   */
  void unSelectAllCategories() async {
    _selectedCategories.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cats', '');
    notifyListeners();
  }

  // ignore: slash_for_doc_comments
  /**
   *  gets all the user categories from aPI
   *  TODO when user logs in get his selected categories from API
   */
  void fetchUserCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cats = prefs.getString('cats') ?? '#0';
    var ids = cats.split('#');
    ids.removeAt(0);
    print('ids ${ids.toString()}');
    _selectedCategories.clear();
    for (String s in ids) {
      print('cats $s');
      _selectedCategories.add(_allCategories.firstWhere((category) {
        return category.id == s;
      }));
    }
    notifyListeners();
  }

  static List<Category> _initCategories() {
    List<Category> categories = [];
    categories.add(Category(
        id: '0',
        name: 'Arts & Entertainment',
        imageUrl: 'assets/pics/categories/arts_entertainment.png'));
    categories.add(Category(
        id: '1',
        name: 'Automotive',
        imageUrl: 'assets/pics/categories/automotive.png'));
    categories.add(Category(
        id: '2',
        name: 'Business',
        imageUrl: 'assets/pics/categories/business.png'));
    categories.add(Category(
        id: '3',
        name: 'Careers',
        imageUrl: 'assets/pics/categories/careers.png'));
    categories.add(Category(
        id: '4',
        name: 'Education',
        imageUrl: 'assets/pics/categories/education.png'));
    categories.add(Category(
        id: '5',
        name: 'Family & Parenting',
        imageUrl: 'assets/pics/categories/family_parenting.png'));
    categories.add(Category(
        id: '6',
        name: 'Health & Fitness',
        imageUrl: 'assets/pics/categories/health_fitness.png'));
    categories.add(Category(
        id: '7',
        name: 'Food & Drink',
        imageUrl: 'assets/pics/categories/food_drink.png'));
    categories.add(Category(
        id: '8',
        name: 'Hobbies & Interests',
        imageUrl: 'assets/pics/categories/hobbies_interests.png'));
    categories.add(Category(
        id: '9',
        name: 'Home & Garden',
        imageUrl: 'assets/pics/categories/home_garden.png'));
    categories.add(Category(
        id: '10',
        name: 'Law, Gov’t & Politics',
        imageUrl: 'assets/pics/categories/law_politics.png'));
    categories.add(Category(
        id: '11', name: 'News', imageUrl: 'assets/pics/categories/news.png'));
    categories.add(Category(
        id: '12',
        name: 'Personal Finance',
        imageUrl: 'assets/pics/categories/personal_finance.png'));
    categories.add(Category(
        id: '13',
        name: 'Society',
        imageUrl: 'assets/pics/categories/society.png'));
    categories.add(Category(
        id: '14',
        name: 'Science',
        imageUrl: 'assets/pics/categories/science.png'));
    categories.add(Category(
        id: '15', name: 'Pets', imageUrl: 'assets/pics/categories/pets.png'));
    categories.add(Category(
        id: '16',
        name: 'Sports',
        imageUrl: 'assets/pics/categories/sports.png'));
    categories.add(Category(
        id: '17',
        name: 'Style & Fashion',
        imageUrl: 'assets/pics/categories/style_fashion.png'));
    categories.add(Category(
        id: '18',
        name: 'Technology & Computing',
        imageUrl: 'assets/pics/categories/technology_computing.png'));
    categories.add(Category(
        id: '19',
        name: 'Travel',
        imageUrl: 'assets/pics/categories/travel.png'));
    categories.add(Category(
        id: '20',
        name: 'Real Estate',
        imageUrl: 'assets/pics/categories/real_estate.png'));
    categories.add(Category(
        id: '21',
        name: 'Shopping',
        imageUrl: 'assets/pics/categories/shopping.png'));
    categories.add(Category(
        id: '22',
        name: 'Illegal Content',
        imageUrl: 'assets/pics/categories/illegal_content.png'));

    return categories;
  }
}
