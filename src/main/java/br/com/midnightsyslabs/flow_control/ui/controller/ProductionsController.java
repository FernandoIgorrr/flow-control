package br.com.midnightsyslabs.flow_control.ui.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.ui.controller.form.ProductFormController;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Rectangle2D;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.effect.ColorAdjust;
import javafx.stage.Modality;
import javafx.stage.Screen;
import javafx.stage.Stage;

@Controller
public class ProductionsController {

    @Autowired
    private ApplicationContext context;

    @FXML
    private Button btnAddProduction;
    @FXML
    private TextField txtSearch;

    @FXML
    private void onAddProduction() {
        try {

            FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/form/production-form.fxml"));

            loader.setControllerFactory(context::getBean);

            Rectangle2D screenBounds = Screen.getPrimary().getVisualBounds();
            double width = screenBounds.getWidth() * 0.4;
            double height = screenBounds.getHeight() * 0.7;

            Stage dialog = new Stage();
            dialog.setTitle("Cadastrar Produção");
            dialog.setScene(new Scene(loader.load(), width, height));

            //ProductionFormController controller = loader.getController();
            // CALLBACK
            //controller.setOnDataChanged(this::reloadProducts);

            Stage mainStage = (Stage) btnAddProduction.getScene().getWindow();

            dialog.initOwner(mainStage);
            dialog.initModality(Modality.WINDOW_MODAL);

            dialog.setResizable(false);
            // stage.showAndWait();

            ColorAdjust darken = new ColorAdjust();
            darken.setBrightness(-0.8);
            mainStage.getScene().getRoot().setEffect(darken);

            dialog.setOnHidden(e -> mainStage.getScene().getRoot().setEffect(null));

            dialog.showAndWait();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
