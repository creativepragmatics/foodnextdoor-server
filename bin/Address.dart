library Address;

import 'dart:convert';

class Address {
  var zipcode, streetNumber, streetExtra;
  num id;
  String country, city, street;
  
  Address(this.country, this.city, this.street,
      this.zipcode, this.streetNumber, this.streetExtra);
  
  String toJson() {
    var addressMap = new Map();
    addressMap['zipcode'] = this.zipcode;
    addressMap['streetNumber'] = this.streetNumber;
    addressMap['streetExtra'] = this.streetExtra;
    addressMap['country'] = this.country;
    addressMap['city'] = this.city;
    addressMap['street'] = this.street;
    
    return JSON.encode(addressMap);
  }
  
  String toString() => "Address object: " + this.toJson();
}