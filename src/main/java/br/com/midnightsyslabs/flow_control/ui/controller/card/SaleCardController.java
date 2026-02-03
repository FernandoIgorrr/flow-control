package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.sale.Sale;
import br.com.midnightsyslabs.flow_control.dto.SaleDTO;
import br.com.midnightsyslabs.flow_control.exception.ClientNotFoundException;
import br.com.midnightsyslabs.flow_control.exception.SaleNotFoundException;
import br.com.midnightsyslabs.flow_control.repository.sale.SaleRepository;
import br.com.midnightsyslabs.flow_control.service.SaleService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import br.com.midnightsyslabs.flow_control.view.PartnerCategory;
import br.com.midnightsyslabs.flow_control.view.SaleProductView;
import io.micrometer.observation.Observation.Context;
import javafx.fxml.FXML;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonBar;
import javafx.scene.control.ButtonType;
import javafx.scene.control.DialogPane;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.Region;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.scene.text.TextFlow;

@Controller
@Scope("prototype")
public class SaleCardController {

        @Autowired
        private SaleRepository saleRepository;
        @Autowired
        private SaleService saleService;

        private SaleDTO sDTO;

        private Runnable onDataChanged;

        @FXML
        private Label lblClientName;

        @FXML
        private Label lblTotalRevenue;

        @FXML
        private ImageView imgType;

        @FXML
        private Label lblDate;

        @FXML
        private FlowPane productsContainer;

        @FXML
        private Button btnDelete;

        @FXML
        private Button btnClose;

        @FXML
        private VBox buttons;

        // @FXML
        // private ImageView imgType2;

        public void setSaleDTO(SaleDTO sDTO) {
                this.sDTO = sDTO;

                if (sDTO.isClosed()) {
                        buttons.setVisible(false);
                        buttons.setManaged(false);

                }
                lblClientName.setText(sDTO.getClientName());
                lblTotalRevenue.setText(UtilsService.formatPrice(sDTO.getRevenue()));
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
                                "dd 'de' MMMM 'de' yyyy",
                                Locale.forLanguageTag("pt-BR"));

                lblDate.setText(sDTO.getDate().format(formatter));

                imgType.setImage(new Image(
                                getClass().getResourceAsStream("/images/lucide--calendar.png")));
                imgType.getStyleClass().add("grey-icon");

                /* DETALHES DOS PRODUTOS VENDIDOS */

                productsContainer.getChildren().clear();

                productsContainer.setHgap(12);
                productsContainer.setVgap(12);

                // ESSENCIAL: wrap acompanha a largura do container
                productsContainer.prefWrapLengthProperty().bind(
                                productsContainer.widthProperty());

                for (var product : sDTO.getSaleProductsView()) {
                        HBox productBox = createProductBox(product);
                        productsContainer.getChildren().add(productBox);
                }

                // imgType2.setImage(new Image(
                // getClass().getResourceAsStream("/images/mdi--eye-outline.png")));
                // imgType2.getStyleClass().add("green-icon");
        }

        private HBox createProductBox(SaleProductView saleProductView) {
                HBox box = new HBox(8);
                VBox vbox = new VBox(8);
                VBox vboxTotalPricePerProduct = new VBox();
                box.getStyleClass().add("green-box");

                // cada item ocupa 50% do FlowPane
                box.prefWidthProperty().bind(
                                productsContainer.widthProperty()
                                                .subtract(productsContainer.getHgap() + 10) // espaço entre colunas
                                                .divide(2));
                box.setPadding(new Insets(8, 8, 8, 8));
                Label lblNamePlusDescription = new Label(
                                saleProductView.getProductName() + " | " + saleProductView.getProductDescription());
                Label lblQtyXPrice = new Label(
                                UtilsService.formatQuantity(saleProductView.getProductQuantitySold()) + " X " +
                                                UtilsService.formatPrice(saleProductView.getProductPriceOnSaleDate()));
                Label lblTotalPricePerProduct = new Label(
                                UtilsService.formatPrice(
                                                saleProductView.getProductPriceOnSaleDate()
                                                                .multiply(saleProductView.getProductQuantitySold())));
                lblTotalPricePerProduct.getStyleClass().add("green-net-income");
                vbox.getChildren().addAll(lblNamePlusDescription, lblQtyXPrice);

                vboxTotalPricePerProduct.setAlignment(Pos.CENTER_RIGHT);
                vboxTotalPricePerProduct.getChildren().add(lblTotalPricePerProduct);
                Region spacer = new Region();
                HBox.setHgrow(spacer, Priority.ALWAYS);

                box.getChildren().addAll(vbox, spacer, vboxTotalPricePerProduct);

                return box;
        }

        public void setOnDataChanged(Runnable onDataChanged) {
                this.onDataChanged = onDataChanged;
        }

        @FXML
        public void onClose() {
                Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
                alert.setTitle("⚠️ CONFIRMAÇÃO");
                alert.setHeaderText("VOCÊ TEM CERTEZA QUE VAI CONFIRMAR A VENDA?");

                ButtonType cancelButton = new ButtonType("CANCELAR", ButtonBar.ButtonData.CANCEL_CLOSE);
                ButtonType confirmButton = new ButtonType("CONFIRMAR", ButtonBar.ButtonData.OK_DONE);

                alert.getButtonTypes().setAll(cancelButton, confirmButton);

                Optional<ButtonType> result = alert.showAndWait();

                if (result.isPresent() && result.get() == confirmButton) {
                        try {
                                saleRepository.findById(sDTO.getId()).ifPresentOrElse(
                                                sale -> saleService.confirmSale(sale), SaleNotFoundException::new);

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
                                                "A venda será removida permanentemente do sistema.");
                content.setWrapText(true);

                Text warningText = new Text("Esta ação é IRREVERSÍVEL. ");
                warningText.getStyleClass().add("danger-text");

                Text startText = new Text("\n\nA venda ");
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
                        saleService.findById(this.sDTO.getId()).ifPresentOrElse(sale -> {
                                saleService.deleteSale(sale);
                        }, SaleNotFoundException::new);

                        if (onDataChanged != null) {
                                onDataChanged.run();
                        }

                }
        }
}
