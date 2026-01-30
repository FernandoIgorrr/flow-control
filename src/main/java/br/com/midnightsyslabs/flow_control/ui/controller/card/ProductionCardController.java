package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.dto.ProductionDTO;
import br.com.midnightsyslabs.flow_control.service.ProductionService;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import javafx.fxml.FXML;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.VBox;

@Controller
public class ProductionCardController {
        @Autowired
        private ProductionService productionService;

        private ProductionDTO productionDTO;

        private Runnable onDataChanged;

        @FXML
        private ImageView imgType;

        @FXML
        private ImageView imgType2;

        @FXML
        private ImageView imgType3;

        @FXML
        private Label lblProductionDate;

        @FXML
        private Label lblProductionTotalPrice;

        @FXML
        private HBox content;

        @FXML
        private VBox rawMaterialsPurchase;

        @FXML
        private VBox productProduced;

        @FXML
        private Label lblProductNameDesc;

        @FXML
        private Label lblProductPrice;

        @FXML
        private Label lblGrossProductQuantity;

        @FXML
        private Label lblProductQuantity;

        @FXML
        private Label lblTotalExpense;

        @FXML
        private Label lblExpensePerUnit;

        @FXML
        private Label lblNetIncomePerUnit;

        @FXML
        private Label lblGrossIncome;

        @FXML
        private Label lblNetIncome;
       
        @FXML
        private Label lblNetIncome2;

        @FXML
        public void initialize() {

        }

        public void setProductionDTO(ProductionDTO productionDTO) {
                this.productionDTO = productionDTO;

                imgType.setImage(new Image(
                                getClass().getResourceAsStream("/images/hugeicons--factory.png")));
                imgType.getStyleClass().add("green-icon");

                imgType2.setImage(new Image(
                                getClass().getResourceAsStream("/images/material-symbols--grocery.png")));
                imgType2.getStyleClass().add("grey-icon");

                imgType3.setImage(new Image(
                                getClass().getResourceAsStream("/images/streamline--graph-arrow-increase.png")));
                imgType3.getStyleClass().add("grey-icon");

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                lblProductionDate.setText("Produção - " + this.productionDTO.getDate().format(formatter));

                productionDTO.getRawMaterialsPurchaseView().forEach(rmpv -> {
                        HBox hContent = new HBox();
                        hContent.getStyleClass().add("blue-box");
                        HBox hContentInfo = new HBox();
                        HBox hContentPrice = new HBox();
                        hContentPrice.setAlignment(Pos.TOP_RIGHT);

                        VBox vContentInforItems = new VBox(6);

                        Label lblRawMaterialNameDesc = new Label(
                                        rmpv.getRawMaterialName() + " | " + rmpv.getRawMaterialDescription());
                        lblRawMaterialNameDesc.getStyleClass().add("purchase-info");

                        Label lblQuantityUsedPlusUnitPrice = new Label(
                                        UtilsService.formatQuantity(rmpv.getQuantityUsed()) + " ("
                                                        + rmpv.getMeasurementSymbol()
                                                        + ") X "
                                                        + UtilsService.formatPrice(rmpv.getRawMaterialPricePerUnit()));
                        lblQuantityUsedPlusUnitPrice.getStyleClass().add("purchase-info");

                        Label lblTotalPrice = new Label(UtilsService.formatPrice(rmpv.getExpense()));
                        lblTotalPrice.getStyleClass().add("blue-expense");

                        vContentInforItems.getChildren().add(lblRawMaterialNameDesc);
                        vContentInforItems.getChildren().add(lblQuantityUsedPlusUnitPrice);

                        hContentInfo.getChildren().add(vContentInforItems);
                        hContentInfo.setMaxWidth(Double.MAX_VALUE);
                        hContentPrice.getChildren().add(lblTotalPrice);

                        hContent.setPadding(new Insets(8, 8, 8, 8));

                        HBox.setHgrow(hContentInfo, Priority.ALWAYS);
                        HBox.setHgrow(hContentPrice, Priority.NEVER);

                        hContent.getChildren().addAll(hContentInfo, hContentPrice);

                        rawMaterialsPurchase.getChildren().add(hContent);
                });

                lblProductNameDesc.setText(
                                productionDTO.getProductName() + " - " + productionDTO.getProductDescription() + " "
                                                + " - " + UtilsService.formatQuantity(productionDTO.getProductQuantity())     
                                                + productionDTO.getProductQuantityMeasurementUnit());

                lblProductPrice.setText( UtilsService
                                .formatPrice(productionDTO.getProductCurrentPrice()));

                lblProductPrice.getStyleClass().add("green-net-income-15");


                lblGrossProductQuantity.setText(UtilsService.formatQuantity(productionDTO.getGrossQuantityProduced())
                                + " " + productionDTO.getGrossQuantityProduceddMeasurementUnit() + " (Bruto) => ");

                lblProductQuantity.setText(
                                UtilsService.formatQuantity(productionDTO.getQuantityProduced()) + " Unidades");

                lblProductNameDesc.getStyleClass().add("production-info-result");
                lblGrossProductQuantity.getStyleClass().add("production-info");
                lblProductQuantity.getStyleClass().add("production-info");

                lblNetIncomePerUnit.setText(UtilsService
                                .formatPrice(productionService.productionNetIncomePertUnit(productionDTO)));

                lblGrossIncome.setText(UtilsService.formatPrice(productionService.productionGrossIncome(productionDTO)));

                lblExpensePerUnit.setText(UtilsService
                                .formatPrice(productionService.productionExpensePerProductUnit(productionDTO)));

                lblNetIncome.setText(UtilsService.formatPrice(productionService.productionNetIncome(productionDTO)));
                lblNetIncome2.setText(UtilsService.formatPrice(productionService.productionNetIncome(productionDTO)));

                lblNetIncomePerUnit.getStyleClass().add("green-light-datas-info");
                lblExpensePerUnit.getStyleClass().add("red-light-datas-info");
                lblGrossIncome.getStyleClass().add("green-net-income");
                lblNetIncome.getStyleClass().add("green-light-datas-info");
                lblNetIncome2.getStyleClass().add("green-net-income");
                lblTotalExpense
                                .setText(UtilsService.formatPrice(
                                                productionService.productionTotalExpense(productionDTO)));
        }

        public void setOnDataChanged(Runnable onDataChanged) {
                this.onDataChanged = onDataChanged;
        }
}
