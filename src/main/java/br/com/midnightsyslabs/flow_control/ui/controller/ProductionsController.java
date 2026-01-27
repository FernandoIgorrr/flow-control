package br.com.midnightsyslabs.flow_control.ui.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.dto.ProductionDTO;
import br.com.midnightsyslabs.flow_control.service.ProductionService;
import br.com.midnightsyslabs.flow_control.ui.controller.card.ProductionCardController;
import br.com.midnightsyslabs.flow_control.ui.controller.card.PurchaseCardController;
import br.com.midnightsyslabs.flow_control.ui.controller.form.ProductFormController;
import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Rectangle2D;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.effect.ColorAdjust;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Screen;
import javafx.stage.Stage;

@Controller
public class ProductionsController {

    @Autowired
    private ProductionService productionService;

    @Autowired
    private ApplicationContext context;

    private List<ProductionDTO> productionsDTO;

    @FXML
    private Button btnAddProduction;

    @FXML
    private TextField txtSearch;

    @FXML
    private VBox cardsPane;

    @FXML
    public void initialize(){
        reloadProductions();
    }

    @FXML
    private void onAddProduction() {
        try {

            FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/form/production-form.fxml"));

            loader.setControllerFactory(context::getBean);

            Rectangle2D screenBounds = Screen.getPrimary().getVisualBounds();
            double width = screenBounds.getWidth() * 0.3;
            double height = screenBounds.getHeight() * 0.7;

            Stage dialog = new Stage();
            dialog.setTitle("Cadastrar Produção");
            dialog.setScene(new Scene(loader.load(), width, height));

            // ProductionFormController controller = loader.getController();
            // CALLBACK
            // controller.setOnDataChanged(this::reloadProducts);

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

    private void renderCards(List<ProductionDTO> productionsDTO) {

        cardsPane.getChildren().clear();

        for (ProductionDTO pDTO : productionsDTO) {
            try {
                FXMLLoader loader = new FXMLLoader(
                        getClass().getResource("/fxml/card/production-card.fxml"));

                loader.setControllerFactory(context::getBean);

                Parent card = loader.load();

                ProductionCardController controller = loader.getController();
                controller.setProductionDTO(pDTO);
                controller.setOnDataChanged(this::reloadProductions);

                cardsPane.getChildren().add(card);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void reloadProductions() {
        this.productionsDTO = productionService.getProductionsDTO();
        renderCards(this.productionsDTO);
       
    }
}
