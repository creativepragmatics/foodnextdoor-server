// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library foodnextdoor_server_test;

import 'package:foodnextdoor_server/foodnextdoor_server.dart';
import 'package:unittest/unittest.dart';

import 'package:redstone/server.dart' as app;
import 'package:redstone/mocks.dart';

void main() => defineTests();

void defineTests() {
  group('main tests', () {
    test('create user', () {
      MockRequest req = new MockRequest("/api/user");
      //TODO: add json to request, check response
      // see http://redstonedart.org/doc/Feature-tour.html
      return app.dispatch(req).then((resp) {
        expect(resp.statusCode, equals(200));
      });
    });
  });
}
