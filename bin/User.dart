library User;

import 'Address.dart';
import 'dart:convert';

class User {
  var email, password;
  num id;
  Address address;
  
  static num idCounter = 0;
  static List<User> users = new List<User>();
  static Map<String, User> emailToUser = new Map<String, User>();
  
  User(this.email, this.password, this.address) {
    this.id = idCounter;
    idCounter += 1;
  }
  
  static void addUser(user) {
    users.add(user);
    emailToUser[user.email] = user;
  }
  
  static void printUsers() {
    print(users);
  }
  
  static User getByEmail(String email) {
    return emailToUser[email];
  }
  
  String toJson() {
    var userMap = new Map();
    userMap['email'] = this.email;
    userMap['password'] = this.password;
    userMap['address'] = this.address.toJson();
    
    return JSON.encode(userMap);
  }
  
  String toString() => "User object: " + this.toJson();
}