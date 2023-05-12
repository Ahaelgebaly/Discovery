class Validations {
  static String? validateName(String? value) {
    if (value!.isEmpty) return 'Username is Required.';
    final RegExp nameExp = new RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
  }

  static String? validateEmail(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried)
      return 'Invalid email address';
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6)
      return 'Please enter a valid password.';
  }
  static String? validatePhoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value?.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value!)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
