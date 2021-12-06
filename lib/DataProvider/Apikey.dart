
class Apikey {
  String name;
  String apikey;

  Apikey._(this.name, this.apikey);

  factory Apikey.fromJSON(Map<String, dynamic> json) {

    return Apikey._(
        json["name"].toString(),
        json["apiKey"].toString()
    );
  }
}

// extension ParseToString on Role {
//   String toShortString() {
//     return this.toString().split('.').last;
//   }
// }
