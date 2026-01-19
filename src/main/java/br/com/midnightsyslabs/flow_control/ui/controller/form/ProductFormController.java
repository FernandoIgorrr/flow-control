package br.com.midnightsyslabs.flow_control.ui.controller.form;

import org.springframework.stereotype.Controller;

import java.util.function.UnaryOperator;

import org.springframework.dao.DataIntegrityViolationException;

import br.com.midnightsyslabs.flow_control.service.ProductService;
import br.com.midnightsyslabs.flow_control.exception.ClientNotFoundException;
import br.com.midnightsyslabs.flow_control.domain.entity.product.MeasurementUnit;
import br.com.midnightsyslabs.flow_control.exception.IllegalEmailArgumentException;
import br.com.midnightsyslabs.flow_control.repository.product.MeasurementUnitRepository;

import javafx.fxml.FXML;

import javafx.stage.Stage;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.util.StringConverter;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.scene.control.TextFormatter;

@Controller
public class ProductFormController {

    private final ProductService productService;
    private final MeasurementUnitRepository measurementUnitRepository;

    // private final ContextMenu citySuggestions;
    private MeasurementUnit selectedMeasurementUnit;

    @FXML
    private TextField nameField;

    @FXML
    private TextField descriptionField;

    @FXML
    private TextField priceField;

    @FXML
    private Label lblQuantity;

    @FXML
    private TextField quantityField;

    @FXML
    private ComboBox<MeasurementUnit> measurementUnitComboBox;


    public ProductFormController(
            ProductService productService,
            MeasurementUnitRepository measurementUnitRepository) {
        this.productService = productService;
        this.measurementUnitRepository = measurementUnitRepository;

    }

    @FXML
    public void initialize() {

        configureMeasurementUnitComboBox();
          configurePriceField();
        configureQuantityField();
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
                selectedMeasurementUnit = newValue;
                lblQuantity.setText(newValue.getUnit());
            }
        });

        if (!measurementUnits.isEmpty()) {
            measurementUnitComboBox.getSelectionModel().selectFirst();
        }
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

    @FXML
    public void onSave() {
        try {

            if (nameField.getText().isEmpty() || descriptionField.getText().isEmpty() || priceField.getText().isEmpty()
                    || selectedMeasurementUnit == null || measurementUnitComboBox.getValue() == null) {
                showLabelAlert(Alert.AlertType.WARNING, "Campos Obrigatórios",
                        "Por favor, preencha o nome, descrição, preço, selecione um tipo de unidade.");
                return;
            }

            productService.saveProduct(
                    nameField.getText(),
                    descriptionField.getText(),
                    priceField.getText(),
                    quantityField.getText(),
                    measurementUnitComboBox.getValue());

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
                    "O CPF, CNPJ, Telefone ou E-mail já existe no banco de dados!");
            return;
        }

        catch (ClientNotFoundException e) {
            showLabelAlert(Alert.AlertType.ERROR, "Cliente não encontrado",
                    e.getMessage());
            return;
        }

        catch (Exception e) {
            showLabelAlert(Alert.AlertType.ERROR, "Erro ao cadastrar produto",
                    "Ocorreu um erro ao tentar cadastrar o produto: " + e.getMessage());
            System.err.println(e.getMessage());
            return;
        }

        close();
    }

    @FXML
    private void onCancel() {
        close();
    }

    private void close() {
        Stage stage = (Stage) nameField.getScene().getWindow();
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
