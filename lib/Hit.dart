class Hit {
  /// hit object types that are different to their originals have been market in the commetns
  /// Hit compiles all relevant data ready to send (no more processing post this)
  /// Dart does not allow for serialisation TODO should variable names just be changed?
//    @PrimaryKey(autoGenerate = true)
  int id = 0;
  //@SerializedName("frame_content");
  var frameContent = null; //string?
  var timestamp = null;
  double latitude = null;
  double longitude = null;
  double altitude = null;
  double accuracy = null; //float
  var provider = null; // srting?
  int width = null;
  int height = null;
  int x = null;
  int y = null;
  //@SerializedName("max");
  int maxValue = null;
  double average = null; //float
  //@SerializedName("blacks");
  double blacksPercentage = null; //float
  //@SerializedName("black_threshold");
  int blackThreshold = null;
  double ax = null; //float
  double ay = null; //float
  double az = null; //float
  double orientation = null; //float
  int temperature = null;

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
