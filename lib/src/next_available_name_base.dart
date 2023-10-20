final _nameCounterRegex = RegExp(r'\((\d+)\)$');

///
/// Gets the next available name.
///
/// [maxAttempts] if no available name found after [maxAttempts] attempts, null is returned.
/// [availableFn] used to check if a name is available.
Future<String?> nextAvailableName(String name, int maxAttempts,
    Future<bool> Function(String name) availableFn) async {
  return nextAvailableNameRaw(name, maxAttempts, (name) async {
    final isAvailable = await availableFn(name);
    if (isAvailable) {
      return name;
    }
    return null;
  });
}

Future<T?> nextAvailableNameRaw<T>(String name, int maxAttempts,
    Future<T?> Function(String name) availableFn) async {
  for (var i = 0; i < maxAttempts; i++) {
    final availableFnRes = await availableFn(name);
    if (availableFnRes != null) {
      return availableFnRes;
    }
    name = _generateNewName(name);
  }
  return null;
}

String _generateNewName(String name) {
  var match = _nameCounterRegex.firstMatch(name);
  var counterStr = match?.group(1);
  if (counterStr == null) {
    return _firstAttempt(name);
  }
  var counter = int.tryParse(counterStr);
  if (counter == null) {
    return _firstAttempt(name);
  }
  counter++;
  return name.replaceFirst(_nameCounterRegex, '($counter)');
}

String _firstAttempt(String name) {
  return '$name (2)';
}
