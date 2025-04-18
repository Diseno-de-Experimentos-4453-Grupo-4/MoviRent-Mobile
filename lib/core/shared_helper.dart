import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  Future<void> setToken(String item) async{
    final instance =  await SharedPreferences.getInstance();
    await instance.setString("token", item);
  }

  Future<String?> getToken() async{
    final instance =  await SharedPreferences.getInstance();
    return instance.getString("token");
  }
}