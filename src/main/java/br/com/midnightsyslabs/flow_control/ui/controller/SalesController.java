package br.com.midnightsyslabs.flow_control.ui.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.sale.Sale;
import br.com.midnightsyslabs.flow_control.service.SaleService;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Rectangle2D;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.effect.ColorAdjust;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Screen;
import javafx.stage.Stage;

@Controller
public class SalesController {

    @Autowired
    private SaleService saleService;

    @Autowired
    private ApplicationContext context;

    private List<Sale> sales;

    @FXML
    private Button btnAddSale;

    @FXML
    private TextField txtSearch;

    @FXML
    private VBox cardsPane;

    @FXML
    public void initialize(){
        reloadSales();
    }

    @FXML
    private void onAddSale() {
        try {

            FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/form/sale-form.fxml"));

            loader.setControllerFactory(context::getBean);

            Rectangle2D screenBounds = Screen.getPrimary().getVisualBounds();
            double width = screenBounds.getWidth() * 0.3;
            double height = screenBounds.getHeight() * 0.7;

            Stage dialog = new Stage();
            dialog.setTitle("Cadastrar Venda");
            dialog.setScene(new Scene(loader.load(), width, height));

            Stage mainStage = (Stage) btnAddSale.getScene().getWindow();

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

    private void renderCards(List<Sale> sales) {

         cardsPane.getChildren().clear();

        /*for (ProductionDTO pDTO : productionsDTO) {
            try {
                FXMLLoader loader = new FXMLLoader(
                        getClass().getResource("/fxml/card/sale-card.fxml"));

                loader.setControllerFactory(context::getBean);

                Parent card = loader.load();

                ProductionCardController controller = loader.getController();
                controller.setProductionDTO(pDTO);
                controller.setOnDataChanged(this::reloadProductions);

                cardsPane.getChildren().add(card);

            } catch (IOException e) {
                e.printStackTrace();
            }
        } */
    }

    public void reloadSales() {
        this.sales = saleService.getSales();
        renderCards(this.sales);
       
    }
}
