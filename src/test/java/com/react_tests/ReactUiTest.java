package com.react_tests;

import static org.testng.Assert.assertEquals;
import java.io.FileNotFoundException;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;
import antlr.collections.List;

public class ReactUiTest {
  private static ChromeDriver driver;

  @BeforeTest
  void openBrowser() {
    System.setProperty("webdriver.chrome.driver", "chromedriver.exe");
    ChromeOptions options = new ChromeOptions();
    options.addArguments("--remote-allow-origins=*");
    driver = new ChromeDriver(options);
  }

  @Test
  void createUser() throws InterruptedException {
    driver.get("http://localhost:3000/users/1");
    Thread.sleep(2000);

    // Find the input element by its locator
    WebElement addButton = driver.findElement(By.id("AddBtn"));
    addButton.click();
    Thread.sleep(2000);

    WebElement usernameInput = driver.findElement(By.id("usernameInput"));
    usernameInput.sendKeys("qskathebest");

    WebElement ageInput = driver.findElement(By.id("ageInput"));
    ageInput.sendKeys("123");

    WebElement passwordInput = driver.findElement(By.id("passwordInput"));
    passwordInput.sendKeys("qskathebest");

    WebElement dateInput = driver.findElement(By.id("dateInput"));
    dateInput.sendKeys("11.08.2023");

    WebElement sendButton = driver.findElement(By.id("sendButton"));
    sendButton.click();

    Thread.sleep(2000);
    WebElement successMessage = driver.findElement(By.id("successMessage"));

    assertEquals("User created successfully!", successMessage.getText());
  }

  @Test
  void editUser() throws InterruptedException {
    driver.get("http://localhost:3000/users/1");
    Thread.sleep(2000);

    // Find the input element by its locator
    WebElement recordColumn = driver.findElement(By.id("table-record-0"));

    var rows = recordColumn.findElements(By.tagName("td"));

    WebElement actionsRow = rows.get(rows.size() - 2);

    WebElement editButton = actionsRow.findElements(By.tagName("a")).get(0);
    editButton.click();

    Thread.sleep(2000);

    WebElement usernameInput = driver.findElement(By.id("usernameInput"));
    usernameInput.clear();
    usernameInput.sendKeys("qskathebestChanged");

    WebElement ageInput = driver.findElement(By.id("ageInput"));
    ageInput.clear();
    ageInput.sendKeys("420");

    WebElement passwordInput = driver.findElement(By.id("passwordInput"));
    usernameInput.clear();
    passwordInput.sendKeys("passwordChanged");

    WebElement dateInput = driver.findElement(By.id("dateInput"));
    dateInput.clear();
    dateInput.sendKeys("11.08.2024");

    WebElement sendButton = driver.findElement(By.id("sendButton"));
    sendButton.click();

    Thread.sleep(2000);
    WebElement successMessage = driver.findElement(By.id("successMessage"));

    assertEquals("User updated successfully!", successMessage.getText());


  }

  @AfterTest
  public void closeBrowser() {
    driver.close();
  }

}
