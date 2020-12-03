class Student {
  int _nim;
  String _name;
  String _phone;

  // constructor default dari class student
  Student(this._name, this._phone);

  // memetakan input dalam bentuk tipe data Map ke object student
  Student.fromMap(Map<String, dynamic> map) {
    this._nim = map['nim'];
    this._name = map['name'];
    this._phone = map['phone'];
  }

  // konfigurasi getter class student
  int get nim => _nim;
  String get name => _name;
  String get phone => _phone;

  // konfigurasi setter class student
  set name(String value) {
    _name = value;
  }

  set phone(String value) {
    _phone = value;
  }

  // konversi dari object student ke tipe data Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['nim'] = this._nim;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }
}