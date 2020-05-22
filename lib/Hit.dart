class Hit {
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

  send() {
    print('space for sending function'); // TO DO: needs send function
  }
}
