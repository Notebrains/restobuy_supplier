
String validateEmptyString(String value) {
  if (value.isEmpty) {
    return "Field is required!";
  }
  return '';
}

String validateEmptyDouble(double value) {
  if (value == 0) {
    return "Field is required!";
  }
  return '';
}

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return '';
}

String validateMobile(String value) {
  if (value.isEmpty) {
    return "Mobile is Required";
  } else if (value.length < 7) {
    return "Please enter valid mobile number";
  }
  return '';
}

String validateZipCode(String value) {
  if (value.isEmpty) {
    return "Zip code is required";
  } else if (value.length < 5) {
    return "Please enter valid zip code";
  }
  return '';
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return '';
  }
}

String validatePass(String value) {
  if (value.isEmpty) {
    return 'Password is Required';
  }
  return '';
}