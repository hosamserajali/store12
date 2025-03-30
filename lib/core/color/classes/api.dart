import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
   Future<dynamic> post(String url, Map body) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Cookie':
          'accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3NDMyNDc2MTUsImV4cCI6MTc0MzI1MTIxNX0.gr3Xt3FLKOyxFb2uHLQxHGTSq73-NpmQVfUzRE_neNY; refreshToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3NDMyNDc2MTUsImV4cCI6MTc0NTgzOTYxNX0.DwLQgBaptUQBYeS2Ms_auHqNUYyY-PoZNBnj9ASkAHI'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return json.decode(await response.stream.bytesToString());
    } else {
      return response.statusCode;
    }
  }
}
