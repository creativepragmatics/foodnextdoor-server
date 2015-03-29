library Offer;

import 'User.dart';
import 'dart:convert';

class Offer {
  num id;
  String imageUrl, title, description;
  DateTime expirationDate;
  bool sealed, taken, reserved;
  User offeredBy;
  static num idCounter = 0;
  
  static List<Offer> offers = new List<Offer>();
  
  Offer(this.title, this.imageUrl, this.description, this.sealed, this.offeredBy) {
    this.taken = false;
    this.reserved = false;
    this.id = idCounter;
    idCounter += 1;
  }
  
  static void addOffer(Offer offer) {
    offers.add(offer);
  }
  
  static List<Offer> getOffers() {
    return offers;
  }
  
  String toJson() {
    var offerMap = new Map();
    //TODO: add expiration date
    offerMap['id'] = this.id;
    offerMap['image_url'] = this.imageUrl;
    offerMap['title'] = this.title;
    offerMap['description'] = this.description;
    offerMap['sealed'] = this.sealed;
    offerMap['taken'] = this.taken;
    offerMap['offered_by'] = this.offeredBy.toJson();
    
    return JSON.encode(offerMap);
  }
}