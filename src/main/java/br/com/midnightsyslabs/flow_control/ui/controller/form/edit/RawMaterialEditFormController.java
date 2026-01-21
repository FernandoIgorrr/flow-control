package br.com.midnightsyslabs.flow_control.ui.controller.form.edit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.raw_material.RawMaterial;
import br.com.midnightsyslabs.flow_control.exception.ProductNotFoundException;
import br.com.midnightsyslabs.flow_control.service.RawMaterialService;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

@Controller
public class RawMaterialEditFormController {

    private final RawMaterialService rawMaterialService;

    private RawMaterial rawMaterial;

    @FXML
    private TextField nameField;

    @FXML
    private TextField descriptionField;

    public RawMaterialEditFormController(RawMaterialService rawMaterialService) {
        this.rawMaterialService = rawMaterialService;
    }

    @FXML
    public void initialize() {
        loadRawMaterialData();
    }

    @FXML
    private void onCancel() {
        close();
    }

    public void loadRawMaterialData() {
        if (this.rawMaterial == null) {
            showLabelAlert(Alert.AlertType.ERROR, "Erro", "Dados incogruentes da matéria-prima.");
            return;
        }

        fillFields(
                this.rawMaterial.getName(),
                this.rawMaterial.getDescription());

    }

    private void fillFields(String name, String description) {
        nameField.setText(name);
        descriptionField.setText(description);
    }

    @FXML
    public void onSave() {
        try {

            if (nameField.getText().isEmpty() || descriptionField.getText().isEmpty()) {
                showLabelAlert(Alert.AlertType.WARNING, "Campos Obrigatórios",
                        "Por favor, preencha o nome e a descrição.");
                return;
            }
            rawMaterialService.editRawMaterial(rawMaterial, nameField.getText(), descriptionField.getText());

        } catch (IllegalArgumentException e) {
            showLabelAlert(Alert.AlertType.WARNING, "Dados Inválidos", e.getMessage());
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

    private void close() {
        Stage stage = (Stage) nameField.getScene().getWindow();
        stage.close();
    }

    public void editRawMaterialForm(RawMaterial rawMaterial) {
        this.rawMaterial = rawMaterial;
    }

    private void showLabelAlert(Alert.AlertType type, String title, String message) {
        Alert alert = new Alert(type);
        alert.setTitle(title);
        alert.setHeaderText(null); // Remove o cabeçalho extra para ficar mais limpo
        alert.setContentText(message);
        alert.showAndWait();
    }
}
