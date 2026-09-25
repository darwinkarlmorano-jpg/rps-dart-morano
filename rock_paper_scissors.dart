import 'dart:io';

/// Gets the player name.
String getPlayerName(String playerNumber, String defaultName) {
  stdout.write("Enter $playerNumber name: ");
  String? dkemInput = stdin.readLineSync();

  if (dkemInput == null || dkemInput.trim().isEmpty) {
    print('(No name entered. Using "$defaultName".)');
    return defaultName;
  }

  return dkemInput.trim();
}

/// Checks the player's move.
String? validateMove(String dkemInput, List<String> dkemValidMoves) {
  String dkemMove = dkemInput.trim().toLowerCase();

  if (dkemValidMoves.contains(dkemMove)) {
    return dkemMove;
  }

  return null;
}

/// Gets a valid move.
String getMove(String dkemPlayerName, List<String> dkemValidMoves) {
  while (true) {
    stdout.write(
        "$dkemPlayerName, enter your move (rock/paper/scissors): ");

    String? dkemInput = stdin.readLineSync();

    String? dkemMove =
        validateMove(dkemInput ?? "", dkemValidMoves);

    if (dkemMove != null) {
      return dkemMove;
    }

    print("Invalid move. Please type rock, paper, or scissors.");
  }
}

/// Decides the round winner.
String? decideWinner(
    String dkemPlayerOneName,
    String dkemPlayerTwoName,
    String dkemPlayerOneMove,
    String dkemPlayerTwoMove) {
  if (dkemPlayerOneMove == dkemPlayerTwoMove) {
    return null;
  }

  if ((dkemPlayerOneMove == "rock" &&
          dkemPlayerTwoMove == "scissors") ||
      (dkemPlayerOneMove == "paper" &&
          dkemPlayerTwoMove == "rock") ||
      (dkemPlayerOneMove == "scissors" &&
          dkemPlayerTwoMove == "paper")) {
    return dkemPlayerOneName;
  }

  return dkemPlayerTwoName;
}

void main() {
  print("===== ROCK, PAPER, SCISSORS =====");

  String dkemPlayerOne =
      getPlayerName("Player 1", "Player 1");

  String dkemPlayerTwo =
      getPlayerName("Player 2", "Player 2");

  List<String> dkemValidMoves = [
    "rock",
    "paper",
    "scissors"
  ];

  int dkemPlayerOneScore = 0;
  int dkemPlayerTwoScore = 0;
  int dkemRoundNumber = 1;
  String dkemPlayAgain;

  do {
    print("\n--- Round $dkemRoundNumber ---");

    String dkemPlayerOneMove =
        getMove(dkemPlayerOne, dkemValidMoves);

    // Hide Player 1's move.
    for (int i = 0; i < 30; i++) {
      print("");
    }

    String dkemPlayerTwoMove =
        getMove(dkemPlayerTwo, dkemValidMoves);

    print(
        "$dkemPlayerOne chose $dkemPlayerOneMove. "
        "$dkemPlayerTwo chose $dkemPlayerTwoMove.");

    String? dkemWinner = decideWinner(
      dkemPlayerOne,
      dkemPlayerTwo,
      dkemPlayerOneMove,
      dkemPlayerTwoMove,
    );

    print("Result: ${dkemWinner ?? "It's a draw!"}");

    if (dkemWinner == dkemPlayerOne) {
      dkemPlayerOneScore++;
    } else if (dkemWinner == dkemPlayerTwo) {
      dkemPlayerTwoScore++;
    }

    print(
        "Score -> $dkemPlayerOne: $dkemPlayerOneScore | "
        "$dkemPlayerTwo: $dkemPlayerTwoScore");

    stdout.write("Play again? (y/n): ");
    String? dkemInput = stdin.readLineSync();

    dkemPlayAgain =
        (dkemInput ?? "n").trim().toLowerCase();

    dkemRoundNumber++;
  } while (dkemPlayAgain == "y");

  print("\n===== FINAL SCORE =====");

  print(
      "$dkemPlayerOne: $dkemPlayerOneScore | "
      "$dkemPlayerTwo: $dkemPlayerTwoScore");

  if (dkemPlayerOneScore > dkemPlayerTwoScore) {
    print("Overall winner: $dkemPlayerOne");
  } else if (dkemPlayerTwoScore > dkemPlayerOneScore) {
    print("Overall winner: $dkemPlayerTwo");
  } else {
    print("Overall winner: It's a draw!");
  }
}