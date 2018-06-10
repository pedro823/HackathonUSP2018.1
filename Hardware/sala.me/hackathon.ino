#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>
#include <ESP8266HTTPClient.h>

#define KEY1 D5
#define KEY2 D6

#define LED1R D4
#define LED1V D3

#define LED2R D2
#define LED2V D1

const char *ssid = "HackathonUSP 2018.1";  //ENTER YOUR WIFI SETTINGS
const char *password = "ExcelIsNotDataScience";
const char *host = "67.205.137.236";   

bool K1_old = false, K2_old = false;

void setup() {
  delay(1000);
  pinMode(KEY1, INPUT_PULLUP);
  pinMode(KEY2, INPUT_PULLUP);
  pinMode(LED1R, OUTPUT);
  pinMode(LED1V, OUTPUT);
  pinMode(LED2R, OUTPUT);
  pinMode(LED2V, OUTPUT);
  digitalWrite(LED2V, LOW);
  digitalWrite(LED2R, HIGH);
  digitalWrite(LED1V, LOW);
  digitalWrite(LED1R, HIGH);
  Serial.begin(115200);
  WiFi.mode(WIFI_OFF);        //Prevents reconnection issue (taking too long to connect)
  delay(1000);
  WiFi.mode(WIFI_STA);        //This line hides the viewing of ESP as wifi hotspot
  WiFi.begin(ssid, password);     //Connect to your WiFi router
  Serial.println();
  Serial.print("Connecting");
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  //If connection successful show IP address in serial monitor
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());  //IP address assigned to your ESP
}
 
void loop() {
  HTTPClient http;    //Declare object of class HTTPClient
  String ADCData, station, postData;
  
  boolean K1 = !digitalRead(KEY1);
  boolean K2 = !digitalRead(KEY2);
  
  if(K1 != K1_old || K2!= K2_old) {
   
    
    if(K1 != K1_old ) {
      if(K1) {
        postData = "{\"free\":false,\"id\":1}";
        digitalWrite(LED1V, LOW);
        digitalWrite(LED1R, HIGH);
      }
      else {
        postData = "{\"free\":true,\"id\":1}";
        digitalWrite(LED1V, HIGH);
        digitalWrite(LED1R, LOW);
      }
    }
    if(K2 != K2_old ) {
       if(K2) {
        postData = "{\"free\":false,\"id\":2}";
        digitalWrite(LED2V, LOW);
        digitalWrite(LED2R, HIGH);
       }
      else {
        postData = "{\"free\":true,\"id\":2}";
         digitalWrite(LED2V, HIGH);
        digitalWrite(LED2R, LOW);
      }
    }

    K1_old = K1;
    K2_old = K2;
    
    Serial.println(postData);

    //postData = "id=" + clicked + "&free" ;
  
    http.begin("http://67.205.137.236:80/study");                                //Specify request destination
    http.addHeader("Content-Type", "application/json");    //Specify content-type header
    http.addHeader("Content-Type", "Accept: application/json");
    int httpCode = http.POST(postData);   //Send the request
    String payload = http.getString();    //Get the response payload
 
    Serial.println(httpCode);   //Print HTTP return code
    Serial.println(payload);    //Print request response payload
 
    http.end();  //Close connection
  
    delay(5000);  //Post Data at every 5 seconds
  }
}
//=================================================
