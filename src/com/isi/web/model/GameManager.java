package com.isi.web.model;

import java.util.Arrays;

public class GameManager {

	public enum GameStatus {
		NOT_STARTED, STARTED, ENDED
	}

	public GameManager() {
		// TODO Auto-generated constructor stub
	}

	private static String currentWord = "";
	private static int currentWordSize = 0;
	private static char[] predictedword;
	private static int wrongGuessCount = 0;
	private static boolean[] gussedLetters;
	private static GameStatus gameStatus = GameStatus.NOT_STARTED;

	public static int getCurrentWordSize() { return currentWordSize; }

	public static char[] getPredictedWord() { return predictedword; }

	public static int getWrongGuessCount() { return wrongGuessCount; }

	public static boolean[] getGussedLetters() { return gussedLetters; }

	public static GameStatus getGameStatus() { return gameStatus; }

	public static void initGame() {
		currentWord = GameDictionary.getRandomWord();
		currentWordSize = currentWord.length();
		predictedword = new char[currentWordSize];
		Arrays.fill(predictedword, '_');
		gameStatus = GameStatus.STARTED;
		wrongGuessCount = 0;
		gussedLetters = new boolean[26];
		Arrays.fill(gussedLetters, false);
	}

	public static void checkLetter(char letter) {
		gussedLetters[letter - 'a'] = true;
		boolean isFoundLetter = false;
		for (int i = 0; i < currentWordSize; i++) {
			if (currentWord.charAt(i) == letter) {
				predictedword[i] = letter;
				isFoundLetter = true;
			}
		}
		if (!isFoundLetter)
			wrongGuessCount++;

		if (currentWord.equals(new String(predictedword)))
			gameStatus = GameStatus.ENDED;
	}

}
