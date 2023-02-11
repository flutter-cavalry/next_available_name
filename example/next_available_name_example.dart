import 'package:next_available_name/next_available_name.dart';

void main() async {
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
}
