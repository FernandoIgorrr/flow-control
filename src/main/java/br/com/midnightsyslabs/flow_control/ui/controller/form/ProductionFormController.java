package br.com.midnightsyslabs.flow_control.ui.controller.form;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.function.UnaryOperator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.product.MeasurementUnit;
import br.com.midnightsyslabs.flow_control.domain.entity.product.Product;
import br.com.midnightsyslabs.flow_control.repository.product.MeasurementUnitRepository;
import br.com.midnightsyslabs.flow_control.service.ProductService;
import br.com.midnightsyslabs.flow_control.service.ProductionService;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import jakarta.validation.ConstraintViolationException;
import javafx.fxml.FXML;
import javafx.geometry.Pos;
import javafx.scene.control.MenuItem;
import javafx.scene.control.TextField;
import javafx.scene.control.TextFormatter;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.Region;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.util.StringConverter;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.ContextMenu;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;

@Controller
public class ProductionFormController {

    @Autowired
    private MeasurementUnitRepository measurementUnitRepository;

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductionService productionService;

    private MeasurementUnit selectedMeasurementUnit;

    private List<PurchaseView> selectedPurchasesDTO;

    private Runnable onDataChanged;

    @FXML
    private ContextMenu purchasesSuggestions;

    @FXML
    private VBox purchaseFieldsBox;

    private List<PurchaseRow> purchaseRows;

    @FXML
    private ComboBox<Product> productComboBox;

    @FXML
    private Label lblGrossQuantityProduced;

    @FXML
    private TextField grossQuantityProducedField;

    @FXML
    private ComboBox<MeasurementUnit> gqpMeasurementUnitComboBox;

    @FXML
    private TextField quantityProducedField;

    @FXML
    private DatePicker datePicker;

    @FXML
    public void initialize() {
        purchaseRows = new ArrayList<>();
        purchasesSuggestions = new ContextMenu();
        addPurchaseField();
        configureProductComboBox();
        configureQuantityField(this.grossQuantityProducedField);
        configureMeasurementUnitComboBox();
        configureQuantityField(this.quantityProducedField);

        datePicker.setValue(LocalDate.now());
        datePicker.setEditable(false);
    }

    private void configureMeasurementUnitComboBox() {

        var measurementUnits = measurementUnitRepository.findAll();

        this.gqpMeasurementUnitComboBox.getItems().setAll(measurementUnits);

        this.gqpMeasurementUnitComboBox.setConverter(new StringConverter<>() {
            @Override
            public String toString(MeasurementUnit unit) {
                return unit == null
                        ? ""
                        : unit.getName() + " (" + unit.getSymbol() + ")";
            }

            @Override
            public MeasurementUnit fromString(String string) {
                return null;
            }
        });

        gqpMeasurementUnitComboBox.valueProperty().addListener((obs, oldValue, newValue) -> {
            if (newValue != null) {
                this.selectedMeasurementUnit = newValue;
                this.lblGrossQuantityProduced.setText("Bruto em (" + newValue.getSymbol() + ")" + " produzido *");
            }
        });

        if (!measurementUnits.isEmpty()) {
            this.gqpMeasurementUnitComboBox.getSelectionModel().selectFirst();
        }
    }

    private void addPurchaseField() {

        boolean isFirst = purchaseFieldsBox.getChildren().isEmpty();

        VBox purchaseItemBox = new VBox(5);
        purchaseItemBox.getStyleClass().add("purchase-item");

        // Header
        HBox headerBox = new HBox(10);
        headerBox.setAlignment(Pos.CENTER_LEFT);

        Label lblPurchase = new Label("Código da compra da matéria-prima *");

        TextField purchaseField = new TextField();
        purchaseField.setPromptText("Digite o ID da compra...");

        Label lblQuantityUsed = new Label("Digite a quantidade usada");

        TextField quantityField = new TextField();

        quantityField.setPromptText("0,0");

        ContextMenu suggestions = new ContextMenu();
        setupPurchaseAutocomplete(purchaseField, quantityField, suggestions);
        configureQuantityField(quantityField);

        Region spacer = new Region();
        HBox.setHgrow(spacer, Priority.ALWAYS);

        // Só cria o botão se NÃO for o primeiro bloco
        if (!isFirst) {
            Button btnRemove = new Button("✖");
            btnRemove.setFocusTraversable(false);
            btnRemove.setStyle("""
                        -fx-background-color: transparent;
                        -fx-text-fill: red;
                        -fx-font-size: 14px;
                    """);

            btnRemove.setOnAction(e -> {
                purchaseFieldsBox.getChildren().remove(purchaseItemBox);
                // Remove da nossa lista de controle procurando pelo campo de quantidade
                purchaseRows.removeIf(row -> row.quantityField == quantityField);
            });
            headerBox.getChildren().addAll(lblPurchase, spacer, btnRemove);
        } else {
            headerBox.getChildren().add(lblPurchase);
        }

        purchaseItemBox.getChildren().addAll(
                headerBox,
                purchaseField,
                lblQuantityUsed,
                quantityField);

        purchaseFieldsBox.getChildren().add(purchaseItemBox);
    }

    private void setupPurchaseAutocomplete(

            TextField purchaseField,
            TextField quantityUsedField,
            ContextMenu purchasesSuggestions) {
        var purchasesView = purchaseService.getPurchasesView();

        purchaseField.textProperty().addListener((obs, oldText, newText) -> {

            if (newText == null || newText.length() < 1) {
                purchasesSuggestions.hide();
                return;
            }

            List<MenuItem> suggestions = purchasesView.stream()
                    .filter(p -> p.getId().toString().contains(newText))
                    .limit(10)
                    .map(purchaseView -> {

                        MenuItem item = new MenuItem(
                                "#" + purchaseView.getId() +
                                        " | " + UtilsService.formatQuantity(purchaseView.getQuantity()) +
                                        " " + purchaseView.getMeasurementUnitPluralName() +
                                        " de " + purchaseView.getRawMaterialName() +
                                        " ( " + UtilsService.formatPrice( purchaseView.getExpense()) + ")" +
                                        " ~ " + purchaseView.getPartnerName());

                        item.setOnAction(e -> {
                            purchaseField.setText(item.getText());
                            purchasesSuggestions.hide();
                            purchaseRows.add(new PurchaseRow(purchaseView, quantityUsedField));

                            // aqui eu crio o novo campo automaticamente
                            addPurchaseField();
                        });

                        return item;
                    })
                    .toList();

            if (suggestions.isEmpty()) {
                purchasesSuggestions.hide();
            } else {
                purchasesSuggestions.getItems().setAll(suggestions);
                purchasesSuggestions.show(purchaseField, javafx.geometry.Side.BOTTOM, 0, 0);
            }
        });
    }

    private void configureQuantityField(TextField quantityField) {
        UnaryOperator<TextFormatter.Change> quantityFilter = change -> {
            String text = change.getControlNewText();
            if (text.matches("\\d*(,\\d{0,3})?")) {
                return change;
            }
            return null;
        };

        quantityField.setTextFormatter(new TextFormatter<>(quantityFilter));
        quantityField.setPromptText("0,0");

    }

    private void configureProductComboBox() {
        var products = productService.getProducts();

        productComboBox.getItems().setAll(products);

        productComboBox.setConverter(new StringConverter<Product>() {

            @Override
            public String toString(Product product) {

                return product == null ? ""
                        : product.getName() + " [ " + product.getQuantity().toString().replace(".", ",") + " ("
                                + product.getMeasurementUnit().getSymbol() + ") ]";
            }

            @Override
            public Product fromString(String string) {
                return null;
            }

        });

        if (!products.isEmpty()) {
            productComboBox.getSelectionModel().selectFirst();
        }

    }

    @FXML
    private void onSave() {
        if (this.purchaseRows.isEmpty()) {
            showLabelAlert(Alert.AlertType.WARNING, "Atenção", "Adicione pelo menos uma matéria prima.");
            return;
        }

        try {
            for (PurchaseRow row : this.purchaseRows) {
                String quantityFieldText = row.quantityField.getText().replace(",", "."); // Converte para formato
                                                                                          // decimal
                                                                                          // Java
                if (quantityFieldText.isEmpty()) {
                    showLabelAlert(Alert.AlertType.WARNING, "Atenção",
                            "Está faltando a quantidade usada em algum campo!.");
                    return;
                }

            }

            if (this.grossQuantityProducedField.getText().isBlank() || this.quantityProducedField.getText().isBlank()
                    || this.productComboBox.getValue() == null
                    || this.datePicker == null) {
                showLabelAlert(Alert.AlertType.WARNING, "Campos Obrigatórios",
                        "Por favor  preencha o campo de quantidade produzida do produto bruto e do refinado!");
                return;
            }

            productionService.saveProdction(
                    this.purchaseRows,
                    this.grossQuantityProducedField.getText(),
                    this.gqpMeasurementUnitComboBox.getValue(),
                    this.productComboBox.getValue(),
                    this.quantityProducedField.getText(),
                    this.datePicker.getValue()

            );

            if (onDataChanged != null) {
                onDataChanged.run();
            }
        } catch (ConstraintViolationException e){
             showLabelAlert(Alert.AlertType.WARNING, "Atenção", "Algum campo viola as regras de valores!");
            return;
        } 
        
        catch (Exception e) {
            showLabelAlert(Alert.AlertType.WARNING, "Atenção", "Algo deu errado!" + e.getCause());
            return;
        }

        close();

        showLabelAlert(Alert.AlertType.INFORMATION, "SUCESSO",
                "Produção cadastrada com sucesso!");
    }

    @FXML
    private void onCancel() {
        close();
    }

    public void setOnDataChanged(Runnable onDataChanged) {
        this.onDataChanged = onDataChanged;
    }

    private void close() {
        Stage stage = (Stage) purchaseFieldsBox.getScene().getWindow();
        stage.close();
    }

    private void showLabelAlert(Alert.AlertType type, String title, String message) {
        Alert alert = new Alert(type);
        alert.setTitle(title);
        alert.setHeaderText(null); // Remove o cabeçalho extra para ficar mais limpo
        alert.setContentText(message);
        alert.showAndWait();
    }

}