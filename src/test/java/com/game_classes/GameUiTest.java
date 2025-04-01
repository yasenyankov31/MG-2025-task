package com.game_classes;

import static org.testng.Assert.assertEquals;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

public class GameUiTest {
	private static ChromeDriver driver;

	@BeforeTest
	void openBrowser() {
		System.setProperty("webdriver.chrome.driver", "chromedriver.exe");
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--remote-allow-origins=*");
		driver = new ChromeDriver(options);
	}

	@Test
	void winGameTest() throws FileNotFoundException, InterruptedException {
		driver.get("http://localhost:8080/new");
		String wordToTest = null;

		// Find the input element by its locator
		WebElement inputElement = driver.findElement(By.id("word_num"));

		// Get the value attribute of the input element
		int wordNum = Integer.parseInt(inputElement.getAttribute("value"));
		File file = new File("wordlist.txt");
		int index = 0;

		try (Scanner reader = new Scanner(file)) {
			while (reader.hasNextLine()) {
				String data = reader.nextLine();
				if (index == wordNum) {
					wordToTest = data;
				}

				index++;
			}
		}
		var letters = wordToTest.toUpperCase().toCharArray();
		Set<Character> letterSet = new HashSet<>();
		for (char c : letters) {
			letterSet.add(c);
		}
		for (var letter : letterSet) {
			WebElement button = driver.findElement(By.id(letter + ""));
			button.click();
			Thread.sleep(1500);
		}
		WebElement usernameInput = driver.findElement(By.tagName("input"));
		usernameInput.sendKeys("qskathebest");

		driver.findElement(By.id("submitButton")).click();
		Thread.sleep(1500);
		WebElement progressDiv = driver.findElement(By.id("progress"));

		WebElement pElement = progressDiv.findElement(By.cssSelector("p.text"));

		assertEquals("Game won! The word was " + wordToTest, pElement.getText());
	}

	@Test
	void looseGameTest() throws InterruptedException, FileNotFoundException {
		driver.get("http://localhost:8080/new");
		String wordToTest = null;

		// Find the input element by its locator
		WebElement inputElement = driver.findElement(By.id("word_num"));

		// Get the value attribute of the input element
		int wordNum = Integer.parseInt(inputElement.getAttribute("value"));

		File file = new File("wordlist.txt");
		int index = 0;

		try (Scanner reader = new Scanner(file)) {
			while (reader.hasNextLine()) {
				String data = reader.nextLine();
				if (index == wordNum) {
					wordToTest = data;
					break;
				}

				index++;
			}
		}

		// Check all the letters that are not contained in the test word
		var missingLetters = getMissingLetters(wordToTest.toUpperCase());
		for (int i = 0; i < 7; i++) {
			WebElement button = driver.findElement(By.id(missingLetters[i] + ""));
			button.click();
			Thread.sleep(1500);
		}
		WebElement usernameInput = driver.findElement(By.id("username"));
		usernameInput.sendKeys("qskathebest");

		driver.findElement(By.id("submitButton")).click();
		Thread.sleep(1500);
		WebElement progressDiv = driver.findElement(By.id("progress"));
		WebElement pElement = progressDiv.findElement(By.cssSelector("p.text"));
		assertEquals("Game over! The word was " + wordToTest, pElement.getText());
	}

	@AfterTest
	public void closeBrowser() {
		driver.close();
	}

	private char[] getMissingLetters(String word) {
		String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuilder missingLetters = new StringBuilder();

		for (char letter : alphabet.toCharArray()) {
			if (word.indexOf(letter) == -1) {
				missingLetters.append(letter);
			}
		}

		return missingLetters.toString().toCharArray();
	}
}
