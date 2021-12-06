
class User {
  String role;
  String email;

  User._(this.role, this.email);

  factory User.fromJSON(Map<String, dynamic> json) {

    return User._(
      json["role"].toString(),
      json["email"].toString()
    );
  }
}

// extension ParseToString on Role {
//   String toShortString() {
//     return this.toString().split('.').last;
//   }
// }
