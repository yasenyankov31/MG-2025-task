package com.game_classes;

import static org.testng.Assert.assertEquals;

import java.io.FileNotFoundException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

public class UsersUITest {
	private static ChromeDriver driver;

	@BeforeTest
	void openBrowser() {
		System.setProperty("webdriver.chrome.driver", "chromedriver.exe");
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--remote-allow-origins=*");
		driver = new ChromeDriver(options);
	}

	@Test
	void createUserTest() throws InterruptedException, FileNotFoundException {
		driver.get("http://localhost:8080/users");
		driver.findElement(By.id("openAddModal")).click();
		Thread.sleep(1500);

		WebElement usernameInput = driver.findElement(By.id("addUsernameInput"));
		usernameInput.sendKeys("JohnDoe");
		Thread.sleep(1500);

		// Find the password input field and enter a value
		WebElement passwordInput = driver.findElement(By.id("addPasswordInput"));
		passwordInput.sendKeys("Password123");
		Thread.sleep(1500);

		// Find the age input field and enter a value
		WebElement ageInput = driver.findElement(By.id("addAgeInput"));
		ageInput.sendKeys("30");
		Thread.sleep(1500);

		// Find the birth date input field and enter a value
		WebElement birthDateInput = driver.findElement(By.id("addDateInput"));
		birthDateInput.sendKeys("01/01/2022");
		Thread.sleep(1500);

		// Submit the form
		WebElement addButton = driver.findElement(By.id("addUserBtn"));
		addButton.click();
		Thread.sleep(3000);
		WebElement ulElement = driver.findElement(By.id("pagination"));

		// Find all the <li> elements within the <ul>
		List<WebElement> liElements = ulElement.findElements(By.tagName("li"));

		// Get the last <li> element
		WebElement lastLiElement = liElements.get(liElements.size() - 2);

		// Click on the last <li> element
		lastLiElement.findElement(By.tagName("a")).click();
		// Find the <table> element
		WebElement tableElement = driver.findElement(By.tagName("table"));

		// Find all the rows (<tr> elements) in the table
		List<WebElement> rowElements = tableElement.findElements(By.tagName("tr"));

		// Get the last row
		WebElement lastRow = rowElements.get(rowElements.size() - 1);

		assertEquals(lastRow.findElement(By.id("username")).getText(), "JohnDoe");
		assertEquals(lastRow.findElement(By.id("password")).getText(), "Password123");
		assertEquals(lastRow.findElement(By.id("age")).getText(), "30");
		assertEquals(lastRow.findElement(By.id("birthDate")).getText(), "2022-01-01");
	}

	@Test
	void updateUserTest() throws InterruptedException, FileNotFoundException {
		driver.get("http://localhost:8080/users");

		WebElement tableElement = driver.findElement(By.tagName("table"));

		// Find all the rows (<tr> elements) in the table
		List<WebElement> rowElements = tableElement.findElements(By.tagName("tr"));

		// Get the last row
		WebElement lastRow = rowElements.get(rowElements.size() - 1);

		// Find all the cells (<td> elements) in the last row
		List<WebElement> cellElements = lastRow.findElements(By.tagName("td"));
		cellElements.get(cellElements.size() - 2).findElements(By.tagName("a")).get(0).click();
		Thread.sleep(1500);

		WebElement usernameInput = driver.findElement(By.id("updateUsernameInput"));
		usernameInput.clear();
		usernameInput.sendKeys("JohnDoeChanged");
		Thread.sleep(1500);

		// Find the password input field and enter a value
		WebElement passwordInput = driver.findElement(By.id("updatePasswordInput"));
		passwordInput.clear();
		passwordInput.sendKeys("PasswordChanged");
		Thread.sleep(1500);

		// Find the age input field and enter a value
		WebElement ageInput = driver.findElement(By.id("updateAgeInput"));
		ageInput.clear();
		ageInput.sendKeys("3");
		Thread.sleep(1500);

		// Find the birth date input field and enter a value
		WebElement birthDateInput = driver.findElement(By.id("updateDateInput"));
		birthDateInput.clear();
		birthDateInput.sendKeys("01/01/2021");
		Thread.sleep(1500);

		// Submit the form
		WebElement updateButton = driver.findElement(By.id("updateUserBtn"));
		updateButton.click();
		Thread.sleep(3000);
		tableElement = driver.findElement(By.tagName("table"));

		// Find all the rows (<tr> elements) in the table
		rowElements = tableElement.findElements(By.tagName("tr"));

		// Get the last row
		lastRow = rowElements.get(rowElements.size() - 1);

		assertEquals(lastRow.findElement(By.id("username")).getText(), "JohnDoeChanged");
		assertEquals(lastRow.findElement(By.id("password")).getText(), "PasswordChanged");
		assertEquals(lastRow.findElement(By.id("age")).getText(), "3");
		assertEquals(lastRow.findElement(By.id("birthDate")).getText(), "2021-01-01");
	}

	@Test
	void deleteUserTest() throws InterruptedException, FileNotFoundException {
		driver.get("http://localhost:8080/users");
		Integer totalUsersBefore = Integer.parseInt(driver.findElement(By.id("totalUsers")).getText()) - 1;
		WebElement tableElement = driver.findElement(By.tagName("table"));

		// Find all the rows (<tr> elements) in the table
		List<WebElement> rowElements = tableElement.findElements(By.tagName("tr"));

		// Get the last row
		WebElement lastRow = rowElements.get(rowElements.size() - 1);

		// Find all the cells (<td> elements) in the last row
		List<WebElement> cellElements = lastRow.findElements(By.tagName("td"));

		cellElements.get(cellElements.size() - 2).findElements(By.tagName("a")).get(1).click();
		Thread.sleep(1500);
		driver.findElement(By.id("deleteConfirm")).click();
		Thread.sleep(3000);
		Integer totalUsersAfter = Integer.parseInt(driver.findElement(By.id("totalUsers")).getText());
		assertEquals(totalUsersBefore, totalUsersAfter);
	}

	@AfterTest
	public void closeBrowser() {
		driver.close();
	}
}
