package br.com.midnightsyslabs.flow_control.ui.controller.form;

import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import javafx.scene.control.TextField;

// Dentro da ProductionFormController
public class PurchaseRow {
    public PurchaseView dto;
    public TextField quantityField;

    PurchaseRow(PurchaseView dto, TextField quantityField) {
        this.dto = dto;
        this.quantityField = quantityField;
    }
}