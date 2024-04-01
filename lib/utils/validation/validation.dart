class Validation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required.';
    }

    if (value.length > 32 || value.length < 3) {
      return "Username must be between of 3 and 32 characters";
    }

    final usernameRegex = RegExp(r'^[a-z0-9_-]{3,15}$');

    if (!usernameRegex.hasMatch(value)) {
      return 'Username can only be alphanumeric, _, and -';
    }

    return null;
  }

// Add more custom validators as needed for your specific requirements.
}
