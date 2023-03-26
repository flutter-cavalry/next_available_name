# next_available_name

[![pub package](https://img.shields.io/pub/v/next_available_name.svg)](https://pub.dev/packages/next_available_name)
[![Build Status](https://github.com/flutter-cavalry/next_available_name/workflows/Build/badge.svg)](https://github.com/flutter-cavalry/next_available_name/actions)

Get next available name.

## Usage

```dart
///
/// Gets next available name.
///
/// [maxAttempts] if no available name found after [maxAttempts] attempts, null is returned.
/// [availableFn] used to check if a name is available.
Future<String?> nextAvailableName(
  String name,
  int maxAttempts,
  Future<bool> Function(String name) availableFn
);
```

## Example

```dart
// Use a set to track names that have been taken.
Set<String> namesTaken = {'liu', 'zheng', 'liu (2)'};

var nextNames = ['zheng', 'wang', 'liu', 'liu'];
var maxAttempts = 100;
for (var name in nextNames) {
  var assigned = await nextAvailableName(name, maxAttempts, (name) async {
    if (!namesTaken.contains(name)) {
      // Don't forget to add new names to the tracking set.
      namesTaken.add(name);
      return true;
    }
    return false;
  });
  print('$name -> $assigned');
}
/**
  * Prints:
  * zheng -> zheng (2)
  * wang -> wang
  * liu -> liu (3)
  * liu -> liu (4)
  */
```
