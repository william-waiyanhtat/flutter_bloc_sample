class Employee {
  int id;
  String firstname;
  String lastname;

  Employee(this.id, this.firstname, this.lastname);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'firstname': firstname,
      'lastname': lastname
    };
    return map;
  }

  Employee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstname = map['firstname'];
    lastname = map['lastname'];
  }
}
