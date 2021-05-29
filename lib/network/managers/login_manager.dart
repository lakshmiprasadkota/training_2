import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base_network.dart';
import '../base_response.dart';


class AuthManager {
  Future<ResponseData> createSignUpToken(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);

      Response response = await dioClient.tokenRef.post("/register/", data: formData);
      if (response?.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (response.statusCode == 200) {
          prefs.setString("access_token", response.data['access_token']);
          print(response);
          return ResponseData("", ResponseStatus.SUCCESS,
              data: response.data);

        } else {
          return ResponseData(response.data['message'], ResponseStatus.FAILED);
        } }
      else {
        return ResponseData(response.data['message'], ResponseStatus.FAILED);
      }
    }




  Future<dynamic> createLoginToken(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
    Response response = await dioClient.tokenRef.post("/login/", data: formData,);

    if (response?.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (response.statusCode==200) {
        prefs.setString("access_token", response.data['access_token']);
        print(response);
        return ResponseData("", ResponseStatus.SUCCESS,
            data: response.data);

      } else {
        return ResponseData(response.data['message'], ResponseStatus.FAILED);
      }
    } else {
      return ResponseData("Failed to get data", ResponseStatus.FAILED);
    }
  }
}

final authManager = AuthManager();

// class LoginManager {
//   Future<dynamic> createLoginToken(Map<String, dynamic> data) async {
//     FormData formData = FormData.fromMap(data);
//     Response response = await dioClient.tokenRef.post("/login/", data: formData,);
//
//     if (response?.statusCode == 200) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       if (response.statusCode==200) {
//         prefs.setString("access_token", response.data['access_token']);
//         print(response);
//         return ResponseData("", ResponseStatus.SUCCESS,
//             data: response.data);
//
//       } else {
//         return ResponseData(response.data['message'], ResponseStatus.FAILED);
//       }
//     } else {
//       return ResponseData("Failed to get data", ResponseStatus.FAILED);
//     }
//   }
// }
//
// final loginManager = LoginManager();