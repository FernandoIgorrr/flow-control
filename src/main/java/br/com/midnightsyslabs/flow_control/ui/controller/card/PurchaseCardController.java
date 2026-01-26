package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.format.DateTimeFormatter;

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

    private PurchaseView purchaseDTO;

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

    public void setPurchaseDTO(PurchaseView purchaseDTO) {
        this.purchaseDTO = purchaseDTO;
        imgType.setImage(new Image(
                getClass().getResourceAsStream("/images/bx--purchase-tag.png")));
        imgType.getStyleClass().add("green-icon");
        lblRawMaterialName.setText(this.purchaseDTO.getRawMaterialName());

        lblPurchaseId.setText("#"+this.purchaseDTO.getId().toString());
        lblPurchaseId.setEditable(false);
        lblPurchaseId.setFocusTraversable(false);

        lblTotalPrice.setText(UtilsService.formatPrice(this.purchaseDTO.getTotalPrice()));
        lblQuantityTitle.setText(this.purchaseDTO.getMeasurementUnitUnit());
        lblSupplierName.setText(this.purchaseDTO.getPartnerName());
        lblPricePerUnitTitle.setText("Preço por " + this.purchaseDTO.getMeasurementUnitName() + " ("
                + this.purchaseDTO.getMeasurementUnitSymbol() + ")");
        lblQuantity.setText(UtilsService.formatQuantity(this.purchaseDTO.getQuantity())
                + " " + this.purchaseDTO.getMeasurementUnitPluralName() + " ("
                + this.purchaseDTO.getMeasurementUnitSymbol() + ")");
        lblUnitPrice.setText(UtilsService.formatPrice(PurchaseService.calculateUnitPrice(this.purchaseDTO)));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        lblDate.setText(this.purchaseDTO.getDate().format(formatter));
        lblNote.setText(this.purchaseDTO.getNote().isBlank() ? "-" : this.purchaseDTO.getNote());
    }

    public void setOnDataChanged(Runnable onDataChanged) {
        this.onDataChanged = onDataChanged;
    }
}
