bool isValidEmail(String? email) {
  final emailRegex = RegExp(
      r"^(?!\.)[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
  if (email == null || email.isEmpty) {
    return false;
  }

  final match = emailRegex.firstMatch(email);
  if (match == null) {
    return false;
  }

  final domain = email.substring(match.start + 1);

  if (!domain.contains('.')) {
    return false;
  }

  final tld = domain.substring(domain.lastIndexOf('.') + 1);
  final validTLDs = ['com', 'net', 'org', 'lk'];
  if (!validTLDs.contains(tld.toLowerCase())) {
    return false;
  }

  return true;
}