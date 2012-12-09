//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();

import processing.serial.*;

Serial arduinoPort;

int baudRate = 9600;

String user;
 
void setup() {
  //Set the size of the stage, and the background to black.
  size(550,550);
  arduinoPort = new Serial(this, Serial.list()[4], 9600);
  frameRate(1);
  background(0);
  smooth();
 
  //Credentials
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("YeelEA4qQccaLwePjRFrQ");
  cb.setOAuthConsumerSecret("Spr04RYHcrkTt2swHW2rN3bXQ879xj6uEqnHshrfdb4");
  cb.setOAuthAccessToken("976423152-jFbbDG2E3Vovj1F89kJDEwDI50P8jJ31eK32ffF5");
  cb.setOAuthAccessTokenSecret("bgUW0mZDPbnUkoBHyYdDvin8Jn6FsQdUyKQ0hDSqA0");
 
  //Make the twitter object and prepare the query
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query query = new Query("@ScalextricCar1");
  query.setRpp(100);
  query.setSince("2012-12-01");
  query.setUntil("2012-12-07");
 
  //Try making the query request.
  try {
    QueryResult result = twitter.search(query);
    ArrayList tweets = (ArrayList) result.getTweets();
 
    for (int i = 0; i < tweets.size(); i++) {
      Tweet t = (Tweet) tweets.get(i);
      user = t.getFromUser();
      String msg = t.getText();
      Date d = t.getCreatedAt();
      User thisUser = twitter.showUser(user);      
      println(user + ": " + msg);
      println(user + " has " + thisUser.getFollowersCount() + "followers.");
      int followers = thisUser.getFollowersCount();
      int speed = 0;
        if(followers > 0 && followers < 50) { speed = 100; }
        if(followers > 51 && followers < 100) { speed = 110; }
        if(followers > 101 && followers < 200) { speed = 120; }
        if(followers > 201 && followers < 300) { speed = 130; }
        if(followers > 301 && followers < 400) { speed = 80; }
        if(followers > 400) { speed = 140; }       
      println(user + "'s speed: " + speed);
      arduinoPort.write(speed);
      delay(5000);
      arduinoPort.write(0);
      //println("Tweet by " + user + " at " + d + ": " + msg);
 
      //Break the tweet into words
      String[] input = msg.split(" ");
      for (int j = 0;  j < input.length; j++) {
       //Put each word into the words ArrayList
       words.add(input[j]);
      }
    };
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  };
}


void tweetCheck() {
  
    ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("YeelEA4qQccaLwePjRFrQ");
  cb.setOAuthConsumerSecret("Spr04RYHcrkTt2swHW2rN3bXQ879xj6uEqnHshrfdb4");
  cb.setOAuthAccessToken("976423152-jFbbDG2E3Vovj1F89kJDEwDI50P8jJ31eK32ffF5");
  cb.setOAuthAccessTokenSecret("bgUW0mZDPbnUkoBHyYdDvin8Jn6FsQdUyKQ0hDSqA0");
 
  //Make the twitter object and prepare the query
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query query = new Query("@ScalextricCar1");
  query.setRpp(100);
 
  //Try making the query request.
  try {
    QueryResult result = twitter.search(query);
    ArrayList tweets = (ArrayList) result.getTweets();
 
    for (int i = 0; i < tweets.size(); i++) {
      Tweet t = (Tweet) tweets.get(i);
      user = t.getFromUser();
      String msg = t.getText();
      Date d = t.getCreatedAt();
      User thisUser = twitter.showUser(user);      
      println(user + ": " + msg);
      println(user + " has " + thisUser.getFollowersCount() + "followers.");
      int followers = thisUser.getFollowersCount();
      int speed = 0;
        if(followers > 0 && followers < 50) { speed = 100; }
        if(followers > 51 && followers < 100) { speed = 110; }
        if(followers > 101 && followers < 200) { speed = 120; }
        if(followers > 201 && followers < 300) { speed = 130; }
        if(followers > 301 && followers < 400) { speed = 80; }
        if(followers > 400) { speed = 140; }       
      println(user + "'s speed: " + speed);
      arduinoPort.write(speed);
      delay(50000);
      arduinoPort.write(0);
      //println("Tweet by " + user + " at " + d + ": " + msg);
 
      //Break the tweet into words
      String[] input = msg.split(" ");
      for (int j = 0;  j < input.length; j++) {
       //Put each word into the words ArrayList
       words.add(input[j]);
      }
    };
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  };
}


 
void draw() {
  //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  fill(0,1);
  rect(0,0,width,height);
 
  //Draw a word from the list of words that we've built
  int i = (frameCount % words.size());
  String word = words.get(i);
 
  //Put it somewhere random on the stage, with a random size and colour
  fill(255,random(50,150));
  textSize(random(10,30));
  text(word, random(width), random(height));
  tweetCheck();
}
