class Hit {
  /// hit object types that are different to their originals have been market in the commetns
  /// Hit compiles all relevant data ready to send (no more processing post this)
  /// Dart does not allow for serialisation TODO should variable names just be changed?
//    @PrimaryKey(autoGenerate = true)
  int id = 0;
  //@SerializedName("frame_content");
  var frameContent = null; //string?
  var timestamp = null;
  double latitude = 0;
  double longitude = 0;
  double altitude = 0;
  double accuracy = 0; //float
  var provider = null; // srting?
  int width = 0;
  int height = 0;
  int x = 0;
  int y = 0;
  //@SerializedName("max");
  int maxValue = 0;
  double average = 0; //float
  //@SerializedName("blacks");
  double blacksPercentage = 0; //float
  //@SerializedName("black_threshold");
  int blackThreshold = 0;
  double ax = 0; //float
  double ay = 0; //float
  double az = 0; //float
  double orientation = 0; //float
  int temperature = 0;

  // return json represntation of a hit object
  Map<String, dynamic> toJson() => {
        "frame_content": frameContent.toString() ?? "",
        "timestamp": timestamp,
        "latitude": latitude,
        "longitude": longitude,
        "altitude": altitude,
        "accuracy": accuracy,
        "provider": provider.toString() ?? "",
        "width": width,
        "height": height,
        "x": x,
        "y": y,
        "max": maxValue,
        "average": average,
        "blacks": blacksPercentage,
        "black_threshold": blackThreshold,
        "ax": ax,
        "ay": ay,
        "az": az,
        "orientation": orientation,
        "temperature": temperature,
      };
}
