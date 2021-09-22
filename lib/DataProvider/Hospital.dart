import 'package:xml/xml.dart';
import 'package:latlong/latlong.dart';

class Hospital {
  String providerId;
  String name;
  String address;
  String city;
  String state;
  String zip;
  String county;
  String phone;
  String type;
  String ownership;
  double lat;
  double long;
  double distance;
  bool emergency;

  Hospital._(
      this.providerId,
      this.name,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.county,
      this.phone,
      this.type,
      this.ownership,
      this.lat,
      this.long,
      this.emergency,
      this.distance
      );

  factory Hospital.fromElement(XmlElement hospitalElement) {
    return Hospital._(
        hospitalElement.getElement("provider_id").text,
        hospitalElement.getElement("hospital_name").text,
        hospitalElement.getElement("address").text,
        hospitalElement.getElement("city").text,
        hospitalElement.getElement("state").text,
        hospitalElement.getElement("zip_code").text,
        hospitalElement.getElement("county_name").text,
        hospitalElement.getElement("phone_number").getAttribute("phone_number"),
        hospitalElement.getElement("hospital_type").text,
        hospitalElement.getElement("hospital_ownership").text,
        double.parse(hospitalElement.getElement("latitude").text),
        double.parse(hospitalElement.getElement("longitude").text),
        hospitalElement.getElement("emergency_services").text == "true",
        0.0
    );
  }

  int compareTo(Hospital o, LatLng curLocation) {
    final Distance distance = new Distance();

    LatLng h1 = LatLng(this.lat, this.long);
    LatLng h2 = LatLng(o.lat, o.long);

    this.distance = distance(h1, curLocation);
    o.distance = distance(h2, curLocation);

    if (this.distance > o.distance) {
      return 1;
    } else if (this.distance < o.distance) {
      return -1;
    } else {
      return 0;
    }
  }



}

/*
<row _id="1179" _uuid="32B65388-034F-4CE4-9D70-933CD8A74D26" _position="1179" _address="http://data.medicare.gov/resource/xubh-q36u/1179">
<provider_id>140116</provider_id>
<hospital_name>CENTEGRA HEALTH SYSTEM - MC HENRY HOSPITAL</hospital_name>
<address>4201 MEDICAL CENTER DRIVE</address>
<city>MCHENRY</city>
<state>IL</state>
<zip_code>60050</zip_code>
<county_name>MCHENRY</county_name>
<phone_number phone_number="8153445000"/>
<hospital_type>Acute Care Hospitals</hospital_type>
<hospital_ownership>Voluntary non-profit - Other</hospital_ownership>
<emergency_services>true</emergency_services>
<location human_address="{"address":"4201 MEDICAL CENTER DRIVE","city":"MCHENRY","state":"IL","zip":"60050"}" latitude="42.31890191600047" longitude="-88.28040986499968" needs_recoding="false"/>
</row>
 */