package br.com.midnightsyslabs.flow_control.ui.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.dto.PurchaseDTO;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.ui.controller.card.PurchaseCardController;
import br.com.midnightsyslabs.flow_control.ui.controller.form.PurchaseFormController;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Rectangle2D;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.effect.ColorAdjust;
import javafx.scene.layout.TilePane;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Screen;
import javafx.stage.Stage;

@Controller
public class PurchasesController {
    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private ApplicationContext context;

    private List<PurchaseDTO> purchaseDTOs;

    @FXML
    private Button btnAddPurchase;

    @FXML
    private TextField txtSearch;

    @FXML
    private VBox cardsPane;

    @FXML
    public void initialize() {
        this.purchaseDTOs = purchaseService.getPurchaseDTOs();

        renderCards(this.purchaseDTOs);

        txtSearch.textProperty().addListener((obs, oldValue, newValue) -> {
            filterCards(newValue);
        });

    }

    @FXML
    private void onAddPurchase() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/form/purchase-form.fxml"));

            loader.setControllerFactory(context::getBean);

            Rectangle2D screenBounds = Screen.getPrimary().getVisualBounds();
            double width = screenBounds.getWidth() * 0.3;
            double height = screenBounds.getHeight() * 0.6;

            Stage dialog = new Stage();
            dialog.setTitle("Cadastrar Compra");
            dialog.setScene(new Scene(loader.load(), width, height));

            PurchaseFormController controller = loader.getController();
            // CALLBACK
            controller.setOnDataChanged(this::reloadPurchases);

            Stage mainStage = (Stage) btnAddPurchase.getScene().getWindow();

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

    private void filterCards(String search) {

        if (search == null || search.isBlank()) {
            renderCards(this.purchaseDTOs);
            return;
        }

        String query = search.toLowerCase();

        List<PurchaseDTO> filtered = this.purchaseDTOs.stream()
                .filter(p -> safe(p.getRawMaterialName()).contains(query) ||
                        safe(p.getRawMaterialDescription()).contains(query))
                .toList();

        renderCards(filtered);
    }

    private void renderCards(List<PurchaseDTO> purchaseDTOs) {

        cardsPane.getChildren().clear();

        for (PurchaseDTO purchaseDTO : purchaseDTOs) {
            try {
                FXMLLoader loader = new FXMLLoader(
                        getClass().getResource("/fxml/card/purchase-card.fxml"));

                loader.setControllerFactory(context::getBean);

                Parent card = loader.load();

                PurchaseCardController controller = loader.getController();
                controller.setPurchaseDTO(purchaseDTO);
                controller.setOnDataChanged(this::reloadPurchases);

                cardsPane.getChildren().add(card);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private String safe(String value) {
        return value == null ? "" : value.toLowerCase();
    }

    private void reloadPurchases() {
        this.purchaseDTOs = purchaseService.getPurchaseDTOs();
        // filterCards(txtSearch.getText());
    }
}
