import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{


  Future<void> setString(String item) async{
    final instance =  await SharedPreferences.getInstance();
    instance.setString(item, item);
  }

  Future<String> getString(String item) async{
    final instance =  await SharedPreferences.getInstance();
    final value = instance.getString(item);
    return value!;
  }
}