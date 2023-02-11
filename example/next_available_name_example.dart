import 'package:next_available_name/next_available_name.dart';

void main() async {
  // Use a set to track names that have been taken.
  Set<String> namesTaken = {'liu', 'zheng', 'liu (2)'};

  var nextNames = ['zheng', 'wang', 'liu'];
  var maxAttempts = 100;
  for (var name in nextNames) {
    var assigned = await nextAvailableName(
        name, maxAttempts, (name) async => !namesTaken.contains(name));
    print('$name -> $assigned');
  }
  /**
   * Prints:
   * zheng -> zheng (2)
   * wang -> wang
   * liu -> liu (3)
   */
}
