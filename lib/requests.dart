import 'dart:convert';
import 'dart:io';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/components/eventBody.dart';
import 'package:gamma_v1/structs.dart';
import 'package:http/http.dart' as http;
import 'package:gamma_v1/main.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

const url = 'http://localhost:8080';
const _signup = '/auth/signup';
const _login = '/auth/login';

var dio = Dio();
var cookieJar = CookieJar();

Future<String> getJWT() async {
  var jwt = await storage.read(key: 'jwt');
  if (isValid(jwt!)) {
    return jwt;
  }
  var newjwt = await getAccess();
  return newjwt;
}

List<String> split(String string, String separator, {int max = 0}) {
  var result = <String>[];

  if (separator.isEmpty) {
    result.add(string);
    return result;
  }

  while (true) {
    var index = string.indexOf(separator, 0);
    if (index == -1 || (max > 0 && result.length >= max)) {
      result.add(string);
      break;
    }

    result.add(string.substring(0, index));
    string = string.substring(index + separator.length);
  }

  return result;
}

bool isValid(String jwt) {
  var test = split(jwt, '.');

  if (test.length != 3 && jwt != null) {
    return false;
  } else {
    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(test[1]))));
    if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
        .isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }
}

Future<int> attemptSignUp(
    String FIRSTNAME, LASTNAME, USERNAME, EMAIL, PHONE, PASSWORD) async {
  var res = await http.post(Uri.parse(url + _signup),
      body: json.encode({
        "first_name": FIRSTNAME,
        "last_name": LASTNAME,
        "username": USERNAME,
        "email": EMAIL,
        "phone_number": PHONE,
        "password": PASSWORD
      }),
      headers: {'Content-Type': 'application/json'});
  if (res.statusCode == 200) {
    var body = json.decode(res.body);
    String token = body['data']['bearer_token'];
    storage.write(key: "jwt", value: token);
    print(res.headers.toString());
    // String setCookie = res.headers.map['set-cookie']!;
    // print(setCookie);
  }
  //print(res.statusCode);
  return res.statusCode;
}

Future<int> attemptSignIn(String PASSWORD, EMAIL) async {
  dio.interceptors.add(CookieManager(cookieJar));
  var response = await dio
      .post(url + _login, data: {"email": EMAIL, "password": PASSWORD});
  if (response.statusCode == 200) {
    var body = response.data;
    storage.write(key: "jwt", value: body['data']['bearer_token']);
    return 200;
  }
  return response.statusCode!;
  // try {
  //   var res = await http.post(Uri.parse(url + _login),
  //       body: json.encode({"email": EMAIL, "password": PASSWORD}),
  //       headers: {'Content-Type': 'application/json'});
  //   if (res.statusCode == 200) {
  //     var body = json.decode(res.body);
  //     String token = body['data']['bearer_token'];
  //     storage.write(key: "jwt", value: token);
  //     return 200;
  //   } else {
  //     return res.statusCode;
  //   }
  // } catch (error) {
  //   print(error);
  // }
  // return 0;
}

Future<dynamic> get(String req) async {
  var jwt = await getJWT();
  var res = await http.get(Uri.parse(url + req), headers: {
    'Content-Type': 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $jwt'
  });
  if (res.statusCode == 200) {
    var body = json.decode(res.body);
    return [res.statusCode, body];
  } else {
    throw Exception(res.reasonPhrase);
  }
}

Future<dynamic> post(Map<String, String> data, String req) async {
  var jwt = await getJWT();
  try {
    var res = await http
        .post(Uri.parse(url + req), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $jwt'
    });
    var body = json.decode(res.body);
    return body;
  } catch (error) {
    print(error);
    return error;
  }
}

Future<String> getAccess() async {
  dio.interceptors.add(CookieManager(cookieJar));
  var res = await dio.get(url + '/auth/refresh');
  print(res.data.toString());
  return '';
  // var res = await http.get(Uri.parse(url + '/auth/refresh'));
  // var body = json.decode(res.body);
  // print(body);
  // if (res.statusCode == 200) {
  //   var body = json.decode(res.body);
  //   String token = body['data']['bearer_token'];
  //   print(token);
  //   storage.write(key: "jwt", value: token);
  //   return token;
  // }
  // return '';
}
