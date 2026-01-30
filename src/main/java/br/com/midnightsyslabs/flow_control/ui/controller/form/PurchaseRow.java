package br.com.midnightsyslabs.flow_control.ui.controller.form;

import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import javafx.scene.control.TextField;

// Dentro da ProductionFormController
public class PurchaseRow {
    public PurchaseView purchaseView;
    public TextField quantityField;

    PurchaseRow(PurchaseView purchaseView, TextField quantityField) {
        this.purchaseView = purchaseView;
        this.quantityField = quantityField;
    }
}