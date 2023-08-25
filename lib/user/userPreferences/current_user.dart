
import 'package:get/get.dart';
import 'package:shop_zone/user/models/user.dart';
import 'package:shop_zone/user/userPreferences/user_preferences.dart';

class CurrentUser extends GetxController
{
  Rx<User> _currentUser = User(0,'','','','').obs;

  User get user => _currentUser.value;


  getUserInfo() async
  {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}


