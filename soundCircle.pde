import java.util.Random;

import processing.sound.*;
AudioIn in;
Amplitude amp;

Circle[] circles = new Circle[20];
int frameCounter = 0;

void setup() {
    size(800, 800);
    frameRate(60);
    in = new AudioIn(this, 0);
    in.start();
    amp = new Amplitude(this);
    amp.input(in);

    for(int i=0;  i < circles.length;  i++){
        Circle circle = new Circle();
        circles[i] = circle;
    }

}

void draw() {
    background(0);
    colorMode(RGB, 256);
    int scale = 3;
    float diameter = map(amp.analyze(), 0.0, 1.0, 0.0, width*scale);

    int index = 0;
    for(Circle ci : circles) {

        ci.drawing(diameter);
        if(counter % 75 == 0 && index % 2 == 0)
        {
            ci.changePos();
        }else if(counter% 150 == 0)
        {
            ci.changePos();
        }
        index++;
    }

    frameCounter++;
}



public class Circle {
    public int hSize;
    public int wSize;

    Random ranPosX;
    Random ranPosY;

    int posY;
    int posX;

    int colorCallTimes = 0;

    Circle() {
        ranPosY = new Random();
        ranPosX = new Random();
        
        posY = ranPosY.nextInt(width);
        posX = ranPosX.nextInt(height);
        hSize = 10;
        wSize = 10;
    }

    public void changePos() {
        ranPosY = new Random();
        ranPosX = new Random();
        
        posY = ranPosY.nextInt(width);
        posX = ranPosX.nextInt(height);
    }


    public void drawing(float size){
        noFill();
        smooth();
        colorEffector();
        strokeWeight(5);
        ellipse(posX, posY, size, size);
    }

    void colorEffector(){
        colorCallTimes++;

        if(colorCallTimes == 1){
            stroke(245, 245, 245);
        }else if(colorCallTimes == 2){
            stroke(64, 224, 208);
        }else if(colorCallTimes == 3){
            stroke(135, 206, 250);
        }else if(colorCallTimes == 4){
            stroke(0, 206, 209);
            colorCallTimes = 0;
        }

    }
}