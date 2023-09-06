bool validateEmail(String value) {
  if (value.isEmpty) return false;
  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) return true;
  return false;
}
