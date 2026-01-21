package br.com.midnightsyslabs.flow_control.ui.controller.form;

import java.time.LocalDate;
import java.util.function.UnaryOperator;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.partner.Partner;
import br.com.midnightsyslabs.flow_control.domain.entity.product.MeasurementUnit;
import br.com.midnightsyslabs.flow_control.domain.entity.raw_material.RawMaterial;
import br.com.midnightsyslabs.flow_control.dto.SupplierDTO;
import br.com.midnightsyslabs.flow_control.exception.IllegalEmailArgumentException;
import br.com.midnightsyslabs.flow_control.exception.SupplierNotFoundException;
import br.com.midnightsyslabs.flow_control.repository.partner.PartnerRepository;
import br.com.midnightsyslabs.flow_control.repository.product.MeasurementUnitRepository;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.RawMaterialService;
import br.com.midnightsyslabs.flow_control.service.SupplierService;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.control.TextFormatter;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.scene.text.TextFlow;
import javafx.stage.Stage;
import javafx.util.StringConverter;

@Controller
public class PurchaseFormController {

    private final PurchaseService purchaseService;

    private final SupplierService supplierService;

    private final RawMaterialService rawMaterialService;

    private final MeasurementUnitRepository measurementUnitRepository;

    private final PartnerRepository partnerRepository;

    private Runnable onDataChanged;

    @FXML
    private ComboBox<SupplierDTO> supplierComboBox;

    @FXML
    private ComboBox<RawMaterial> rawMaterialComboBox;

    @FXML
    private Label lblQuantity;

    @FXML
    private TextField quantityField;

    @FXML
    private ComboBox<MeasurementUnit> measurementUnitComboBox;

    @FXML
    private TextFlow textFlowPrice;

    @FXML
    private TextField priceField;

    @FXML
    private DatePicker datePicker;

    @FXML
    private TextField noteField;

    PurchaseFormController(
            PurchaseService purchaseService,
            SupplierService supplierService,
            RawMaterialService rawMaterialService,
            MeasurementUnitRepository measurementUnitRepository,
            PartnerRepository partnerRepository) {
        this.purchaseService = purchaseService;
        this.supplierService = supplierService;
        this.rawMaterialService = rawMaterialService;
        this.measurementUnitRepository = measurementUnitRepository;
        this.partnerRepository = partnerRepository;
    }

    @FXML
    public void initialize() {

        configureSupplierComboBox();
        configureRawMaterialComboBox();
        configureMeasurementUnitComboBox();
        Text startText = new Text("Preço ");
        Text totalText = new Text("TOTAL");
        totalText.setFont(
                Font.font(
                        totalText.getFont().getFamily(),
                        FontWeight.BOLD,
                        totalText.getFont().getSize()));
        Text endText = new Text(" da Compra (R$) *");
        textFlowPrice = new TextFlow(startText, totalText, endText);
        configurePriceField();
        configureQuantityField();
        datePicker.setValue(LocalDate.now());
        datePicker.setEditable(false);
    }

    public void configureSupplierComboBox() {
        var suppliers = supplierService.getSuppliers();

        supplierComboBox.getItems().setAll(suppliers);

        supplierComboBox.setConverter(new StringConverter<SupplierDTO>() {

            @Override
            public String toString(SupplierDTO supplierDTO) {
                return supplierDTO == null
                        ? ""
                        : supplierDTO.getName();
            }

            @Override
            public SupplierDTO fromString(String string) {
                return null;
            }
        });

        if (!suppliers.isEmpty()) {
            supplierComboBox.getSelectionModel().selectFirst();
        }
    }

    public void configureRawMaterialComboBox() {
        var rawMaterials = rawMaterialService.getRawMaterials();

        rawMaterialComboBox.getItems().setAll(rawMaterials);

        rawMaterialComboBox.setConverter(new StringConverter<RawMaterial>() {

            @Override
            public String toString(RawMaterial rawMaterial) {
                return rawMaterial == null
                        ? ""
                        : rawMaterial.getName();
            }

            @Override
            public RawMaterial fromString(String string) {
                return null;
            }
        });

        if (!rawMaterials.isEmpty()) {
            rawMaterialComboBox.getSelectionModel().selectFirst();
        }
    }

    private void configureMeasurementUnitComboBox() {

        var measurementUnits = measurementUnitRepository.findAll();

        measurementUnitComboBox.getItems().setAll(measurementUnits);

        measurementUnitComboBox.setConverter(new StringConverter<>() {
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

        measurementUnitComboBox.valueProperty().addListener((obs, oldValue, newValue) -> {
            if (newValue != null) {
                lblQuantity.setText(newValue.getUnit() + " *");
            }
        });

        if (!measurementUnits.isEmpty()) {
            measurementUnitComboBox.getSelectionModel().selectFirst();
        }
    }

    private void configureQuantityField() {
        UnaryOperator<TextFormatter.Change> quantityFilter = change -> {
            String text = change.getControlNewText();
            if (text.matches("\\d*(,\\d{0,3})?")) {
                return change;
            }
            return null;
        };

        quantityField.setTextFormatter(new TextFormatter<>(quantityFilter));
    }

    private void configurePriceField() {
        UnaryOperator<TextFormatter.Change> priceFilter = change -> {
            String text = change.getControlNewText();
            if (text.matches("\\d*(,\\d{0,2})?")) {
                return change;
            }
            return null;
        };

        priceField.setTextFormatter(new TextFormatter<>(priceFilter));
    }

    @FXML
    public void onSave() {

        try {

            if (supplierComboBox.getValue() == null || rawMaterialComboBox.getValue() == null
                    || priceField.getText().isEmpty()
                    || quantityField.getText().isEmpty() || measurementUnitComboBox.getValue() == null
                    || datePicker.getValue() == null) {
                showLabelAlert(Alert.AlertType.WARNING, "Campos Obrigatórios",
                        "Por favor, preencha todas os campos!.");
                return;
            }

            partnerRepository.findById(supplierComboBox.getValue().getId()).ifPresentOrElse(partner -> {
                purchaseService.savePurchase(partner,
                        rawMaterialComboBox.getValue(),
                        quantityField.getText(),
                        measurementUnitComboBox.getValue(),
                        priceField.getText(),
                        datePicker.getValue(),
                        noteField.getText());
            }, SupplierNotFoundException::new);

            if (onDataChanged != null) {
                onDataChanged.run();
            }

        } catch (IllegalEmailArgumentException e) {
            showLabelAlert(Alert.AlertType.WARNING, "Erro de email", e.getMessage());
            return;
        }

        catch (IllegalArgumentException e) {
            showLabelAlert(Alert.AlertType.WARNING, "Dados Inválidos", e.getMessage());
            return;
        }

        catch (DataIntegrityViolationException e) {
            showLabelAlert(Alert.AlertType.ERROR, "Erro de Integridade de Dados",
                    "");
            return;
        } catch (Exception e) {
            showLabelAlert(Alert.AlertType.ERROR, "Erro ao cadastrar produto",
                    "Ocorreu um erro ao tentar cadastrar o produto: " + e.getMessage());
            System.err.println(e.getMessage());
            return;
        }

        close();
    }

    @FXML
    public void onCancel() {
        close();
    }

    private void close() {
        Stage stage = (Stage) supplierComboBox.getScene().getWindow();
        stage.close();
    }

    public void setOnDataChanged(Runnable onDataChanged) {
        this.onDataChanged = onDataChanged;
    }

    private void showLabelAlert(Alert.AlertType type, String title, String message) {
        Alert alert = new Alert(type);
        alert.setTitle(title);
        alert.setHeaderText(null); // Remove o cabeçalho extra para ficar mais limpo
        alert.setContentText(message);
        alert.showAndWait();
    }
}
