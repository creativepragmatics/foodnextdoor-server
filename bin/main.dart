// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'package:foodnextdoor_server/foodnextdoor_server.dart' as foodnextdoor_server;
import 'dart:io';
import 'dart:convert';
import 'package:redstone/server.dart' as app;
import 'package:redstone/query_map.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'User.dart';
import 'Address.dart';
import 'Offer.dart';

// Test data
User petar = new User("petar@creativepragmatics.com", "1234567890",
      new Address("AT", "Vienna", "Pater-Schwartz-Gasse", "1150", "11A", ""));
User john = new User("john@creativepragmatics.com", "1234567890",
      new Address("AT", "Vienna", "Pater-Schwartz-Gasse", "1150", "11A", ""));
Offer bread = new Offer("Bread", "bread_image.png", "This is bread.", false, petar);
Offer butter = new Offer("Butter", "butter_image.png", "This is butter.", true, john);

// create user
@app.Route('/api/users', methods: const[app.POST])
signUp(@app.Body(app.JSON) QueryMap json) {
  // create the user
  // TODO: add validation
  Address address = new Address(
      json.address.country,
      json.address.city,
      json.address.street,
      json.address.zip,
      json.address.number,
      json.address.additional_information);
  User user = new User(
      json.email,
      json.password,
      address);
  User.addUser(user);
  
  // create response
  var userMap = new Map();
  userMap['id'] = user.id;
  //userMap['auth_token'] = "2ea27151cd502f7a03d16da981ab5029"; // e.g. e-mail hash
  
  return new shelf.Response.ok(JSON.encode(userMap));
}

// sign in
@app.Route('/api/user_session', methods: const[app.POST])
signIn(@app.Body(app.JSON) QueryMap json) {
  var email = json.email;
  var password = json.password;
  // TODO: auth_token
  // TODO: check password
  return new shelf.Response.ok(User.getByEmail(email).toJson());
}

@app.Route('/api/offers', methods: const[app.GET, app.POST])
getOffers() {
  // get all offers
  if (app.request.method == app.GET) {
    return new shelf.Response.ok(JSON.encode(Offer.getOffers()));
  }
  // create an offer
  if (app.request.method == app.POST) {
    if (app.request.bodyType == app.JSON) {
      var json = app.request.body;
      Offer offer = new Offer(
          json.title,
          json.image_url,
          json.description,
          json.sealed.toLowerCase() == 'true',
          User.getByEmail(json.user_email));
      Offer.addOffer(offer);
      return offer.toJson();
    } else {
      print("Not supported");
    }
  }
}



addTestUsers() {
  User.addUser(petar);
  User.addUser(john);
}

addTestOffers() {
  Offer.addOffer(bread);
  Offer.addOffer(butter);
}

main() {
  app.setupConsoleLog();
  app.start();
  
  addTestUsers();
  addTestOffers();
}