import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider extends ChangeNotifier {
  final String baseUrl;

  ApiProvider({required this.baseUrl});

  Future<dynamic> getData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<dynamic> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'USERNAME': username, 'PASSWORD': password}),
  );

  print('Request body: ${json.encode({'username': username, 'password': password})}');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to login: ${response.body}');
  }
}

  Future<dynamic> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<dynamic> getGroupMessages(int loadSize, int idGroup) async {
    final response = await http.get(Uri.parse('$baseUrl/getMessages/$loadSize/$idGroup'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get group messages');
    }
  }

  Future<dynamic> createGroup(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/createGroup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create group');
    }
  }

  Future<dynamic> getUsersMessages(int loadSize, String user1, String user2) async {
    final response = await http.get(Uri.parse('$baseUrl/getMessages/$loadSize/$user1/$user2'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get user messages');
    }
  }

  Future<dynamic> getHome() async {
    final response = await http.get(Uri.parse('$baseUrl/home'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get home data');
    }
  }

  Future<dynamic> getFriends(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/getFriends/$username'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get friends');
    }
  }

  Future<void> checkMessage(int messageId) async {
    final response = await http.get(Uri.parse('$baseUrl/check/$messageId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to check message');
    }
  }

  Future<void> sendMessage(Map<String, dynamic> message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Token: $token');

    if (token != null) {
      final response = await http.post(
        Uri.parse('$baseUrl/sendMessage'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Cookie': 'token=$token',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Failed to send message: ${response.statusCode}');
      }
    } else {
      throw Exception('Failed to send message');
    }
  }

  Future<dynamic> updateUserAdminStatus(int userId, int groupId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/updateUserAdminStatus'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'groupId': groupId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update user admin status');
    }
  }

  Future<dynamic> deleteUserFromGroup(int userId, int groupId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/deleteUserFromGroup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'groupId': groupId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete user from group');
    }
  }

  Future<dynamic> addUserToGroup(Map<String, dynamic> userGroup) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addUserToGroup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userGroup),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add user to group');
    }
  }

  Future<dynamic> updateProfile(Map<String, dynamic> updatedUser) async {
    final response = await http.post(
      Uri.parse('$baseUrl/updateProfile'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedUser),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update profile');
    }
  }
}