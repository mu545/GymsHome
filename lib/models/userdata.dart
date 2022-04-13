import 'package:shared_preferences/shared_preferences.dart';

import '../provider/customer.dart';

class UserData {
  // static final SharedPreferences _userdata= await SharedPreferences.getInstance();

  static Future init() async {
    // _userdata = await SharedPreferences.getInstance();
  }

//get userid
  static Future<String?> getUserId() async {
    SharedPreferences _userdata = await SharedPreferences.getInstance();
    return _userdata.getString('uid');
  }

// is customer or not
  static Future<bool?> isCustomer() async {
    SharedPreferences _userdata = await SharedPreferences.getInstance();
    return _userdata.getBool('iscustomer');
  }

// set Customer
  static void setUserDate(
      bool iscustomer, String uid, String name, String email) async {
    SharedPreferences _userdata = await SharedPreferences.getInstance();
    _userdata.setBool('iscustomer', iscustomer);
    _userdata.setString('email', email);
    _userdata.setString('name', name);
    _userdata.setString('uid', uid);
  }

  static void deleteUserData() async {
    SharedPreferences _userdata = await SharedPreferences.getInstance();
    _userdata.remove('iscustomer');
    _userdata.remove('email');
    _userdata.remove('name');
    _userdata.remove('uid');
  }

// get Customer
  static Future<Customer> getCustomer() async {
    SharedPreferences _userdata = await SharedPreferences.getInstance();
    String? email = _userdata.getString('email');
    String? name = _userdata.getString('name');
    String? uid = _userdata.getString('uid');

    return Customer(
        email: email ?? '',
        profilePicture: '',
        uid: uid ?? '',
        name: name ?? '');
  }
}
