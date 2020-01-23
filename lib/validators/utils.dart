import 'package:flutter/material.dart';

class Val {
  static String ValidateName(String val) {
    RegExp exp = new RegExp(r"^[a-z\s]{3,20}$");
    if (val.isEmpty) {
      return "Name cannot be empty";
    } else if (exp.hasMatch(val)) {
      return "Invalid name format";
    }
  }

  static String ValidateEmailUsername(String val) {
    RegExp username =
        new RegExp(r"^[\w-.\_]{5,12}$", caseSensitive: false, multiLine: false);
    RegExp email = new RegExp(
      r"^[\w-.]+@([\w-]+.)+[\w-]{2,4}$",
      caseSensitive: false,
      multiLine: false,
    );

    if (val.isEmpty) {
      return "Email or Username cannot be empty";
    } else if (!username.hasMatch(val) || !email.hasMatch(val)) {
      return "Invalid format";
    }
  }

  static String ValidateUsername(String val) {
    RegExp exp =
        new RegExp(r"^[\w-.\_]{5,12}$", caseSensitive: false, multiLine: false);
    if (val.isEmpty) {
      return "Username cannot be empty";
    } else if (exp.hasMatch(val.trim()) == false) {
      return "Invalid email format";
    }
  }

  static String ValidateEmail(String val) {
    RegExp exp = new RegExp(
      r"^[\w-.]+@([\w-]+.)+[\w-]{2,4}$",
      caseSensitive: false,
      multiLine: false,
    );

    if (val.isEmpty) {
      return "Email cannot be empty";
    } else if (exp.hasMatch(val.trim()) == false) {
      return "Invalid email format";
    }
  }

  static String ValidatePassword(String val) {
    RegExp exp = new RegExp(
      r"^(?=.*\d).{6,16}$",
      multiLine: false,
    );

    if (val.isEmpty) {
      return "Password cannot be empty";
    } else if (exp.hasMatch(val.trim()) == false) {
      return "Must be 6-16 digits and at least one numeric digit";
    }
  }

  static String ValidateAmount(String val) {
    if (val.isEmpty) {
      return "Amount can\'t be empty";
    } else if (int.parse(val) < 1000) {
      return "Amount can\'t less than Rp.1,000,-";
    } else if (int.parse(val) > 100000000) {
      return "Amount can\'t more than Rp.100,000,000,-";
    }
  }

  static String ValidateCardExp(String val) {
    RegExp exp = new RegExp(r"^(0[1-9]|1[0-2])[0-9][0-9]$");
    if (exp.hasMatch(val) == false) {
      return "Please input valid date";
    }
  }

  static String ValidateTextField(String val) {
    if (val.isEmpty) {
      return "This field cannot be empty";
    }
  }

  static String ValidatePhone(String val) {
    RegExp exp = new RegExp(
      r"^[0-9]{8,15}$",
      multiLine: false,
    );

    if (val.isEmpty) {
      return "This field cannot be empty";
    } else if (exp.hasMatch(val.trim()) == false) {
      return "Must be 8-15 digits and only numeric digit";
    }
  }
}
