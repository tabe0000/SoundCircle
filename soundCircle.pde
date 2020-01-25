import java.util.Random;

import processing.sound.*;
AudioIn in;
Amplitude amp;


Circle[] circles = new Circle[50];

int frameCounter = 0;

void setup() {
    //ウインドウサイズを定義
    size(500, 500);
    //フレームレートを定義
    frameRate(60);
    
    //マイクをセットアップ
    in = new AudioIn(this, 0);
    in.start();
    amp = new Amplitude(this);
    amp.input(in);

    //Circleをインスタンス化
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
        //円を描画
        ci.drawing(diameter);
        
        //特定のフレームで描画位置変更
        if(frameCounter % 75 == 0 && index % 2 == 0)
        {
            ci.changePos();
        }else if(frameCounter % 150 == 0)
        {
            ci.changePos();
        }
        index++;
    }

    frameCounter++;

    //save("./img/result.jpg");
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
        
        posY = ranPosY.nextInt(height);
        posX = ranPosX.nextInt(width);
        
        hSize = 10;
        wSize = 10;
    }

    //描画位置を更新
    public void changePos() {
        ranPosY = new Random();
        ranPosX = new Random();
        
        posY = ranPosY.nextInt(height);
        posX = ranPosX.nextInt(width);
    }

    //円を描画
    public void drawing(float size) {
        noFill();
        smooth();
        colorEffector();
        strokeWeight(5);
        if(size > 30){
            ellipse(posX, posY, size, size);
        }
    }

    //毎フレームごとに色を変更
    void colorEffector() {
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
