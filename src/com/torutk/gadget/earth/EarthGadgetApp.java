/*
 * © 2017 TAKAHASHI,Toru
 */
package com.torutk.gadget.earth;

import com.torutk.gadget.support.TinyGadgetSupport;
import java.util.prefs.Preferences;
import javafx.animation.Animation;
import javafx.animation.KeyFrame;
import javafx.animation.KeyValue;
import javafx.animation.Timeline;
import javafx.application.Application;
import javafx.scene.AmbientLight;
import javafx.scene.Group;
import javafx.scene.PerspectiveCamera;
import javafx.scene.PointLight;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.paint.Color;
import javafx.scene.paint.PhongMaterial;
import javafx.scene.shape.Sphere;
import javafx.scene.transform.Rotate;
import javafx.scene.transform.Translate;
import javafx.stage.Stage;
import javafx.util.Duration;

/**
 * 地球が3次元表示で回転するデスクトップガジェット。
 */
public class EarthGadgetApp extends Application {
    private static final double FRAMES_PER_SECOND = 5;
    private static final double AZIMUTH_SPEED_PER_SECOND = 2; // degree
    
    private Translate cameraTranslate = new Translate(0, 0, -300);
    private Rotate cameraRotateY = new Rotate(0, Rotate.Y_AXIS);
    
    @Override
    public void start(Stage primaryStage) {
        new TinyGadgetSupport(primaryStage, Preferences.userNodeForPackage(this.getClass()));
        Group root = new Group();
        Sphere earth = new Sphere(100);
        root.getChildren().add(earth);
        
        PhongMaterial material = new PhongMaterial();
        Image earthTexture = new Image(getClass().getResourceAsStream("earth.png"));
        material.setDiffuseMap(earthTexture);
        earth.setMaterial(material);
        
        PerspectiveCamera camera = new PerspectiveCamera(true);
        camera.setFieldOfView(45);
        camera.setFarClip(1000);
        camera.getTransforms().addAll(cameraRotateY, cameraTranslate);

        // 点光源の定義
        final PointLight pointLight = new PointLight(Color.WHITE);
        pointLight.setTranslateX(500);
        pointLight.setTranslateY(0);
        pointLight.setTranslateZ(-500);
        root.getChildren().add(pointLight);

        // 環境光の定義
        AmbientLight ambientLight = new AmbientLight(Color.rgb(192, 192, 192, 0.75));
        root.getChildren().add(ambientLight);
        
        Scene scene = new Scene(root, 300, 250);
        scene.setCamera(camera);
        
        primaryStage.setTitle("Hello Earth!");
        primaryStage.setScene(scene);
        primaryStage.show();
        
        Timeline animation = createAnimation();
        animation.play();
    }

    /**
     * カメラを地球中心に1周回転するアニメーションを作成する。
     * 
     * @return 360度回転するアニメーション
     */
    private Timeline createAnimation() {
        Timeline animation = new Timeline(FRAMES_PER_SECOND);
        animation.setCycleCount(Animation.INDEFINITE);
        animation.getKeyFrames().addAll(
                new KeyFrame(Duration.ZERO,
                        new KeyValue(cameraRotateY.angleProperty(), 0)
                ),
                new KeyFrame(Duration.seconds(360d / AZIMUTH_SPEED_PER_SECOND),
                        new KeyValue(cameraRotateY.angleProperty(), -360)
                )
        );
        return animation;
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
}
