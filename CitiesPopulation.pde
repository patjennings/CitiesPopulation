import java.util.Calendar;
import java.io.File;

PImage europeMapImage;
MercatorMap mercatorMap;

float scaleFactor = .0003;

//PVector nantes;
//PVector caen;

Table table;


void setup()
{
  size(1475, 1392);

  europeMapImage = loadImage("france.png");
  MercatorMap mercatorMap = new MercatorMap(1475, 1392, 51.38, 41.26, -5.36, 10.24);
  image(europeMapImage, 0, 0, width, height);

  table = loadTable("villes_france_mini.csv", "header");

  println(table.getRowCount() + " total rows in table"); 

  for (TableRow row : table.rows()) {

    int id;
    String name;
    int population;
    PVector city;
    float city_lat, city_long;
    float dotSize;

    id = row.getInt("ville_id");
    name = row.getString("ville_slug");
    population = row.getInt("ville_population_2012");
    city_lat = row.getFloat("ville_latitude_deg");
    city_long = row.getFloat("ville_longitude_deg");

    dotSize = (row.getInt("ville_population_2012"))*scaleFactor; 

    if (population < 1000000) // si inférieur à Paris
    {
      city = mercatorMap.getScreenLocation(new PVector(city_lat, city_long));

      noStroke();
      fill(255, 0, 0, 75);
      ellipse(city.x, city.y, dotSize, dotSize);
    }
    else // Paris
    {
      city = mercatorMap.getScreenLocation(new PVector(city_lat, city_long));

      noFill();
      strokeWeight(4);
      stroke(255, 0, 0, 50);
      ellipse(city.x, city.y, dotSize, dotSize);
    }
  }
}

void draw() {
  //noStroke();
  //fill(255, 0, 0);
  // ellipse(nantes.x, nantes.y, 6, 6);
}

void keyReleased()
{
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  print("saved !");
}

// timestamp
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

