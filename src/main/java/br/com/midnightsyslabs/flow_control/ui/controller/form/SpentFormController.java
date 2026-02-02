package br.com.midnightsyslabs.flow_control.ui.controller.form;

import java.time.LocalDate;
import java.util.function.UnaryOperator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.spent.SpentCategory;
import br.com.midnightsyslabs.flow_control.repository.spent.SpentCategoryRepository;
import br.com.midnightsyslabs.flow_control.service.EmojiService;
import br.com.midnightsyslabs.flow_control.service.SpentService;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TextField;
import javafx.scene.control.TextFormatter;
import javafx.stage.Stage;
import javafx.util.StringConverter;

@Controller
public class SpentFormController {

    @Autowired
    private SpentCategoryRepository spentCategoryRepository;

    @Autowired
    private EmojiService emojiService;

    @Autowired
    private SpentService spentService;

    private Runnable onDataChanged;

    @FXML
    private ComboBox<SpentCategory> spentCategoryComboBox;

    @FXML
    private TextField amountPaid;

    @FXML
    private TextField spentDescriptionField;

    @FXML
    private DatePicker datePicker;

    @FXML
    public void initialize() {
        configureSpentCategoryComboBox();
        configurePriceField();
        datePicker.setValue(LocalDate.now());
        datePicker.setEditable(false);
    }

    public void configureSpentCategoryComboBox() {
        var spentCategories = spentCategoryRepository.findAll();

        spentCategories = spentCategories.stream()
                .filter(sc -> sc.getId() > 2).toList();

        spentCategoryComboBox.getItems().setAll(spentCategories);
        spentCategoryComboBox.setConverter(new StringConverter<SpentCategory>() {

            @Override
            public String toString(SpentCategory spentCategory) {
                return spentCategory == null ? ""
                        : emojiService.getEmoji(spentCategory.getId()) + " " + spentCategory.getName();
            }

            @Override
            public SpentCategory fromString(String string) {
                return null;
            }

        });

        if (!spentCategories.isEmpty()) {
            spentCategoryComboBox.getSelectionModel().selectFirst();
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

        amountPaid.setTextFormatter(new TextFormatter<>(priceFilter));
    }

    @FXML
    public void onSave() {

        if (amountPaid.getText().isBlank()) {
            showLabelAlert(Alert.AlertType.WARNING, "Atenção", "A quantia paga está vazia");
            return;
        }

        try {
            spentService.saveSpent(amountPaid.getText(), spentCategoryComboBox.getValue(),
                    spentDescriptionField.getText(), datePicker.getValue());
        } catch (Exception e) {
            showLabelAlert(Alert.AlertType.WARNING, "Atenção", "Algo deu errado!" + e.getMessage());
            return;
        }

        close();

        showLabelAlert(Alert.AlertType.INFORMATION, "SUCESSO",
                "Despesa cadastrada com sucesso!");
    }

    @FXML
    public void onCancel() {
        close();
    }

    private void close() {
        Stage stage = (Stage) spentCategoryComboBox.getScene().getWindow();
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
