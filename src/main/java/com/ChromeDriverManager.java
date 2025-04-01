package com;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class ChromeDriverManager {
  private static ChromeDriver driver;

  private ChromeDriverManager() {}

  public static void start() {
    String swaggerUiUrl = "http://localhost:8080/swagger-ui.html";
    String webSiteUrl = "http://localhost:8080/";

    System.setProperty("webdriver.chrome.driver", "chromedriver.exe");
    ChromeOptions options = new ChromeOptions();
    options.addArguments("--remote-allow-origins=*");
    driver = new ChromeDriver(options);
    driver.get(swaggerUiUrl);
    // Open a new tab
    ((JavascriptExecutor) driver).executeScript("window.open()");

    // Switch to the newly opened tab
    driver.switchTo().window(driver.getWindowHandles().toArray()[1].toString());

    // Open a URL in the second tab
    driver.get(webSiteUrl);
  }

  public static void stop() {
    if (driver != null) {
      driver.quit();
    }
  }
}
