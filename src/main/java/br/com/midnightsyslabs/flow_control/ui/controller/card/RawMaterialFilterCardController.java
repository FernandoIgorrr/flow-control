package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.util.function.Consumer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.raw_material.RawMaterial;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.RawMaterialService;
import javafx.util.StringConverter;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;

@Controller
public class RawMaterialFilterCardController {

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private RawMaterialService rawMaterialService;

    @FXML
    private ComboBox<RawMaterial> rawMaterialComboBox;

    private Consumer<RawMaterial> onRawMaterialChanged;

    @FXML
    public void initialize() {

      
    }

    public void setOnRawMaterialChanged(Consumer<RawMaterial> callback) {
        this.onRawMaterialChanged = callback;
    }
}
