import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final waitingProvider = FutureProvider<int>((ref) async {
  print("response");
  final response =
      await get(Uri.parse('http://15.164.140.53:8000/start/reload'));
  print(response.body);
  if (response.statusCode != 200) {
    return 0;
  }
  final json = jsonDecode(response.body);
  return json['count'];
});
