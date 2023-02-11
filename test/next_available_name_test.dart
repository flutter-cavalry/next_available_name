import 'package:next_available_name/next_available_name.dart';
import 'package:test/test.dart';

const defName = 'myName';
const defMaxAttempts = 100;

void main() {
  test('0-2-3-5', () async {
    Set<String> set = {'$defName (4)'};
    var name = defName;
    Future<bool> availableFn(String name) async {
      if (!set.contains(name)) {
        set.add(name);
        return true;
      }
      return false;
    }

    expect(
        await nextAvailableName(name, defMaxAttempts, availableFn), 'myName');
    expect(await nextAvailableName(name, defMaxAttempts, availableFn),
        'myName (2)');
    expect(await nextAvailableName(name, defMaxAttempts, availableFn),
        'myName (3)');
    // 'myName (4)' has been preset in the set.
    expect(await nextAvailableName(name, defMaxAttempts, availableFn),
        'myName (5)');
  });

  test('3-4', () async {
    Set<String> set = {defName, '$defName (2)'};
    var name = defName;
    Future<bool> availableFn(String name) async {
      if (!set.contains(name)) {
        set.add(name);
        return true;
      }
      return false;
    }

    expect(await nextAvailableName(name, defMaxAttempts, availableFn),
        'myName (3)');
    expect(await nextAvailableName(name, defMaxAttempts, availableFn),
        'myName (4)');
  });

  test('Start from 3-4', () async {
    Set<String> set = {};
    var name = '$defName (2)';
    Future<bool> availableFn(String name) async {
      if (!set.contains(name)) {
        set.add(name);
        return true;
      }
      return false;
    }

    expect(await nextAvailableName(name, defMaxAttempts, availableFn),
        'myName (3)');
    expect(await nextAvailableName(name, defMaxAttempts, availableFn),
        'myName (4)');
  });
}
