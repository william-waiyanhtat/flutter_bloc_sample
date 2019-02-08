class User {
  String firstName;
  String lastName;

  User(this.firstName, this.lastName);

  toJson() {
    return {"first_name": firstName, "last_name": lastName};
  }
}
