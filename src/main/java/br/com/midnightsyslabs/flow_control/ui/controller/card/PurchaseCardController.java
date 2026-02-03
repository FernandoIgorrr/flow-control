package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.exception.SaleNotFoundException;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonBar;
import javafx.scene.control.ButtonType;
import javafx.scene.control.DialogPane;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.scene.text.TextFlow;

@Controller
@Scope("prototype")
public class PurchaseCardController {

    @Autowired
    private PurchaseService purchaseService;

    private Runnable onDataChanged;

    private PurchaseView pView;

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

    @FXML
    private Button btnDelete;

    @FXML
    private Button btnClose;

    @FXML
    private VBox buttons;

    public void setPurchaseView(PurchaseView purchaseView) {

        this.pView = purchaseView;

        if (purchaseView.isClosed()) {
            buttons.setVisible(false);
            buttons.setManaged(false);
        }

        imgType.setImage(new Image(
                getClass().getResourceAsStream("/images/bx--purchase-tag.png")));
        imgType.getStyleClass().add("green-icon");
        lblRawMaterialName.setText(purchaseView.getRawMaterialName());

        lblPurchaseId.setText("#" + purchaseView.getId().toString());
        lblPurchaseId.setEditable(false);
        lblPurchaseId.setFocusTraversable(false);

        lblTotalPrice.setText(UtilsService.formatPrice(purchaseView.getExpense()));
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


      @FXML
        public void onClose() {
                Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
                alert.setTitle("⚠️ CONFIRMAÇÃO");
                alert.setHeaderText("VOCÊ TEM CERTEZA QUE VAI CONFIRMAR A COMPRA?");

                ButtonType cancelButton = new ButtonType("CANCELAR", ButtonBar.ButtonData.CANCEL_CLOSE);
                ButtonType confirmButton = new ButtonType("CONFIRMAR", ButtonBar.ButtonData.OK_DONE);

                alert.getButtonTypes().setAll(cancelButton, confirmButton);

                Optional<ButtonType> result = alert.showAndWait();

                if (result.isPresent() && result.get() == confirmButton) {
                        try {
                                purchaseService.findById(pView.getId()).ifPresentOrElse(
                                                purchase -> purchaseService.confirmPurchase(purchase), SaleNotFoundException::new);

                                if (onDataChanged != null) {
                                        onDataChanged.run();
                                }
                        } catch (Exception e) {
                                Alert alertt = new Alert(Alert.AlertType.ERROR);
                                alertt.setTitle("⚠️ ALGO DEU ERRADO");
                                alertt.setHeaderText(e.getMessage());
                                alertt.show();
                        }

                }
        }
        @FXML
        public void onDelete() {
                Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
                alert.setTitle("⚠️ CONFIRMAÇÃO DE EXCLUSÃO");
                alert.setHeaderText("VOCÊ TEM CERTEZA?");
      

                Label content = new Label(
                                "Esta ação é IRREVERSÍVEL.\n\n" +
                                                "A compra será removida permanentemente do sistema.");
                content.setWrapText(true);

                Text warningText = new Text("Esta ação é IRREVERSÍVEL. ");
                warningText.getStyleClass().add("danger-text");

                Text startText = new Text("\n\nA compra ");
                startText.getStyleClass().add("common-text");

                Text endText = new Text(" será removida permanentemente do sistema.");
                endText.getStyleClass().add("common-text");

                TextFlow textFlow = new TextFlow(warningText, startText, endText);
                textFlow.setMaxWidth(420);

                alert.getDialogPane().setContent(textFlow);

                // Botões personalizados
                ButtonType cancelButton = new ButtonType("CANCELAR", ButtonBar.ButtonData.CANCEL_CLOSE);
                ButtonType deleteButton = new ButtonType("DELETAR", ButtonBar.ButtonData.OK_DONE);

                alert.getButtonTypes().setAll(cancelButton, deleteButton);

                // Estilização após o dialog ser criado
                DialogPane dialogPane = alert.getDialogPane();
                dialogPane.getStylesheets().add(
                                getClass().getResource("/css/alert-danger.css").toExternalForm());
                dialogPane.getStyleClass().add("danger-alert");

                Optional<ButtonType> result = alert.showAndWait();

                if (result.isPresent() && result.get() == deleteButton) {
                        purchaseService.findById(this.pView.getId()).ifPresentOrElse(purchase -> {
                                purchaseService.deletePurchase(purchase);
                        }, SaleNotFoundException::new);

                        if (onDataChanged != null) {
                                onDataChanged.run();
                        }

                }
        }
}
