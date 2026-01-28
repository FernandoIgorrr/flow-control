package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

@Controller
public class PurchaseCardController {

    @Autowired
    private PurchaseService purchaseService;

    private Runnable onDataChanged;

    @FXML
    private Label lblRawMaterialName;

    @FXML
    private TextField lblPurchaseId;

    @FXML
    private Label lblTotalPrice;

    @FXML
    private Label lblQuantityTitle;

    @FXML
    private Label lblQuantity;

    @FXML
    private Label lblSupplierName;

    @FXML
    private Label lblPricePerUnitTitle;

    @FXML
    private Label lblUnitPrice;

    @FXML
    private Label lblDate;

    @FXML
    private Label lblNote;

    @FXML
    private ImageView imgType;

    public void setPurchaseView(PurchaseView purchaseView) {

        imgType.setImage(new Image(
                getClass().getResourceAsStream("/images/bx--purchase-tag.png")));
        imgType.getStyleClass().add("green-icon");
        lblRawMaterialName.setText(purchaseView.getRawMaterialName());

        lblPurchaseId.setText("#" + purchaseView.getId().toString());
        lblPurchaseId.setEditable(false);
        lblPurchaseId.setFocusTraversable(false);

        lblTotalPrice.setText(UtilsService.formatPrice( purchaseView.getExpense()));
        lblQuantityTitle.setText(purchaseView.getMeasurementUnitUnit());
        lblSupplierName.setText(purchaseView.getPartnerName());
        lblPricePerUnitTitle.setText("Preço por " + purchaseView.getMeasurementUnitName() + " ("
                + purchaseView.getMeasurementUnitSymbol() + ")");
        lblQuantity.setText(UtilsService.formatQuantity(purchaseView.getQuantity())
                + " " + purchaseView.getMeasurementUnitPluralName() + " ("
                + purchaseView.getMeasurementUnitSymbol() + ")");
        lblUnitPrice.setText(UtilsService.formatPrice(purchaseView.getPricePerUnit()));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        lblDate.setText(purchaseView.getDate().format(formatter));
        lblNote.setText(purchaseView.getNote().isBlank() ? "-" : purchaseView.getNote());
    }

    public void setOnDataChanged(Runnable onDataChanged) {
        this.onDataChanged = onDataChanged;
    }
}
