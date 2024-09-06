import 'dart:io';
import 'dart:math';

void main() {
  final random = Random();
  int lowerBound = 0;
  int upperBound = 100;
  int bombNumber = random.nextInt(101);

  print("Welcome to the BOM Number Game!");
  print("Avoid the bomb number between $lowerBound and $upperBound.");

  while (true) {
    print("Enter a number between $lowerBound and $upperBound:");
    String? input = stdin.readLineSync();
    
    if (input == null) {
      print("Invalid input. Please enter a number.");
      continue;
    }

    int guess;
    try {
      guess = int.parse(input);
    } catch (e) {
      print("Invalid input. Please enter a valid number.");
      continue;
    }

    if (guess < lowerBound || guess > upperBound) {
      print("Number out of range. Please try again.");
      continue;
    }

    if (guess == bombNumber) {
      print("Ooofff! You've hit the bomb number $bombNumber.");
      break;
    } else if (guess < bombNumber) {
      lowerBound = guess + 1;
      print("Great you avoiding the bomb number!");
    } else {
      upperBound = guess - 1;
      print("Great you avoiding the bomb number!");
    }

    if (lowerBound > upperBound) {
      print("The range has become invalid. The bomb number was $bombNumber.");
      break;
    } else if (lowerBound == upperBound) {
      print("Congratulation you win the game! The bomb number was $bombNumber.");
      break;
    }
  }
}
