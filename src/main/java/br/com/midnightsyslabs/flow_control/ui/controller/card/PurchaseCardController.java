package br.com.midnightsyslabs.flow_control.ui.controller.card;

import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.dto.PurchaseDTO;
import br.com.midnightsyslabs.flow_control.service.ProductService;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

@Controller
public class PurchaseCardController {
    
    private PurchaseDTO purchaseDTO;

    private Runnable onDataChanged;

    @FXML
    private Label lblRawMaterialName;

    @FXML
    private Label lblTotalPrice;

     @FXML
    private ImageView imgType;

     public void setPurchaseDTO(PurchaseDTO purchaseDTO) {
        this.purchaseDTO = purchaseDTO;
          imgType.setImage(new Image(
                    getClass().getResourceAsStream("/images/bx--purchase-tag.png")));
        lblRawMaterialName.setText(this.purchaseDTO.getRawMaterialName());
        lblTotalPrice.setText(ProductService.formatPrice(this.purchaseDTO.getTotalPrice()));
       
    }

    public void setOnDataChanged(Runnable onDataChanged) {
        this.onDataChanged = onDataChanged;
    }
}
