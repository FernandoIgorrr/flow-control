package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.config.TimeIntervalEnum;
import br.com.midnightsyslabs.flow_control.service.DateService;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.util.StringConverter;

@Controller
public class RecentPurchasesPriceCardController {

    @Autowired
    private PurchaseService purchaseService;

    @FXML
    private ComboBox<TimeIntervalEnum> timeIntervalComboBox;

    @FXML
    private Label lblTotalPrice;

    @FXML
    public void initialize() {
        configureTimeIntervalEnumComboBox();
        reloadTotalPrice(TimeIntervalEnum.LAST_7_DAYS);
    }

    public void configureTimeIntervalEnumComboBox() {
        this.timeIntervalComboBox.getItems().setAll(TimeIntervalEnum.values());

        this.timeIntervalComboBox.setConverter(new StringConverter<>() {
            @Override
            public String toString(TimeIntervalEnum interval) {
                return interval == null ? "" : interval.getLabel();
            }

            @Override
            public TimeIntervalEnum fromString(String string) {
                return null;
            }
        });
        this.timeIntervalComboBox.getSelectionModel().selectFirst();

        
    this.timeIntervalComboBox.valueProperty().addListener((obs, oldValue, newValue) -> {
        if (newValue == null)
                return;
       reloadTotalPrice(newValue);
    });
    }

    private void reloadTotalPrice(TimeIntervalEnum interval){
        LocalDate dateFrom =  DateService.timeIntervalEnumToDateFrom(interval);
        LocalDate dateTo =  DateService.timeIntervalEnumToDateTo(interval);

        lblTotalPrice.setText(UtilsService.formatPrice(purchaseService.calculateTotalSpentInTime(dateFrom, dateTo)));
    }


}
