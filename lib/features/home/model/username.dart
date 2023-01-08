import 'dart:convert';

class Username {
  final String name;

  Username({
    required this.name,
  });

  factory Username.fromJson(Map<String, dynamic> jsonData) {
    return Username(
      name: jsonData['name'],
    );
  }

  static Map<String, dynamic> toMap(Username music) => {
        'name': music.name,
      };

  static String encode(List<Username> users) => json.encode(
        users
            .map<Map<String, dynamic>>((user) => Username.toMap(user))
            .toList(),
      );

  static List<Username> decode(String users) =>
      (json.decode(users) as List<dynamic>)
          .map<Username>((item) => Username.fromJson(item))
          .toList();
}
