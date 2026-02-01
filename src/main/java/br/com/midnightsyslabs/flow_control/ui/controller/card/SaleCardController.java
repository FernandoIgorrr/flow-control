package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.sale.Sale;
import br.com.midnightsyslabs.flow_control.dto.SaleDTO;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import br.com.midnightsyslabs.flow_control.view.SaleProductView;
import javafx.fxml.FXML;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.Region;
import javafx.scene.layout.VBox;

@Controller
public class SaleCardController {

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

    // @FXML
    // private ImageView imgType2;

    public void setSaleDTO(SaleDTO sDTO) {
        this.sDTO = sDTO;

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
        Label lblQtyXPrice = new Label(UtilsService.formatQuantity(saleProductView.getProductQuantitySold()) + " X " +
                UtilsService.formatPrice(saleProductView.getProductPriceOnSaleDate()));
        Label lblTotalPricePerProduct = new Label(
                UtilsService.formatPrice(
                        saleProductView.getProductPriceOnSaleDate().multiply(saleProductView.getProductQuantitySold())));
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
}
