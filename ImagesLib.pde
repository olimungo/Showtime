public class ImagesLib {
  ArrayList<String> imagesPath;
  ArrayList<PImage> images = new ArrayList<PImage>();
  
  int scaleFactor;
  int dpi = 70;
  int currentImage = -1;
  
  ImagesLib(ArrayList<String> imagesPath) {
    this.imagesPath = imagesPath;
    this.loadImages();
  }
  
  void loadImages() {
    for (String imagePath : imagesPath) {
      images.add(loadImage(imagePath));
    }
  }
  
  ArrayList<BubbleMatrix> getNextImage() {
    this.currentImage++;

    if (this.currentImage == this.images.size()) {
        this.currentImage = 0;
    }

    PImage shrinked = this.shrinkImage(this.images.get(this.currentImage));
    
    return this.convertToBubblesMatrix(shrinked);
  };
  
  private PImage shrinkImage(PImage image) {
    this.scaleFactor = floor(image.width / this.dpi);

    int width = image.width / this.scaleFactor;
    int height = image.height / this.scaleFactor;
    PImage shrinked = createImage(width, height, RGB);

    shrinked.copy(image, 0, 0, image.width, image.height, 0, 0, width, height);
    shrinked.loadPixels();
    
    return shrinked;
  }
  
  private ArrayList<BubbleMatrix> convertToBubblesMatrix(PImage image) {
    ArrayList<BubbleMatrix> matrix = new ArrayList<BubbleMatrix>();
    
    this.adjustScaleFactor(image);
    
    float centerX = (width - image.width * this.scaleFactor) / 2 + 1;
    float centerY = (height - image.height * this.scaleFactor) / 2 + 1;
    
    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        color c = image.get(x, y);
        float radius = map(brightness(c), 0, 255, 0, this.scaleFactor * .8);
        float xCorrected = x * this.scaleFactor + centerX;
        float yCorrected = y * this.scaleFactor + centerY;
        
        matrix.add(new BubbleMatrix(xCorrected, yCorrected, c, radius));
      }
    }
    
    return matrix;
  }
  
  private void adjustScaleFactor(PImage image) {
    int imageWidth = image.width * this.scaleFactor;
    int imageHeight = image.height * this.scaleFactor;
    
    if (imageWidth > width || imageHeight > height) {
      this.scaleFactor = floor(width / image.width);
      int heightScaleFactor = floor(height / image.height);
      
      if (heightScaleFactor < this.scaleFactor) {
        this.scaleFactor = heightScaleFactor;
      }
    }
  }
}