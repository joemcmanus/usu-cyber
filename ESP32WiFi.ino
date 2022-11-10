#include <WiFi.h>

// WiFi network name and password:
const char *networkName = "YourSSID";
const char *networkPswd = "YourPass";

int ledPin = 13;

void setup_wifi() {
  Serial.print("\nConnecting to ");
  Serial.println(networkName);

  WiFi.begin(networkName, networkPswd);  // Connect to network

  while (WiFi.status() != WL_CONNECTED) {  // Wait for connection
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
}

WiFiServer server(80);

void setup() {
  Serial.begin(115200);  // Start serial communication at 115200 baud
  delay(100);
  setup_wifi();  // Connect to network
  server.begin();
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, HIGH);
}

void loop() {
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  // Read the first line of the request
  String req = client.readStringUntil('\r');
  Serial.println(req);
  // Match the request
  int val = -1;  // We'll use 'val' to keep track of both the
                 // request type (read/set) and value if set.
  if (req.indexOf("/led/0") != -1) {
    val = 1;  // Will write LED high
  } else if (req.indexOf("/led/1") != -1) {
    val = 0;  // Will write LED low
  }

  // Set GPI13 according to the request
  if (val >= 0) {
    digitalWrite(ledPin, val);
  }
  // Prepare the response. Start with the common header:
  String s = "HTTP/1.1 200 OK\r\n";
  s += "Content-Type: text/html\r\n\r\n";
  s += "<!DOCTYPE HTML>\r\n<html>\r\n";
  // If we're setting the LED, print out a message saying we did
  if (val >= 0) {
    s += "LED is now ";
    s += (val) ? "on" : "off";
    s += "<br> <a href=/> home </a>";
  } else {
    s += "Welcome IS5800 to the IoT using the ESP32 Thing Dev Board <br>";
    s += "Turn an LED <a href=/led/1> Off </a> or <a href=/led/0> On </a> <br>";
  }
  s += "</html>\n";
  client.print(s);
  delay(10);
  Serial.println("Client disonnected");
}