package br.com.midnightsyslabs.flow_control.ui.controller.card;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.dto.ProductDTO;
import br.com.midnightsyslabs.flow_control.repository.partner.CompanyPartnerRepository;
import br.com.midnightsyslabs.flow_control.repository.partner.PersonalPartnerRepository;
import br.com.midnightsyslabs.flow_control.repository.product.ProductRepository;
import br.com.midnightsyslabs.flow_control.service.ClientService;
import br.com.midnightsyslabs.flow_control.service.ProductService;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;

@Controller
@Scope("prototype")
public class ProductCardController {
    
    @Autowired
    private ApplicationContext context;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductService productService;

    @FXML
    private Label lblName;
    @FXML
    private Label lblDescription;
    @FXML
    private Label lblQuantity;
    @FXML
    private Label lblMeasurementUnitName;
    @FXML
    private Label lblMeasurementUnitSymbol;
    @FXML
    private Label lblMeasurementUnitUnit;
    @FXML
    private Label lblCurrentPrice;
    @FXML
    private ImageView imgType;
    @FXML
    private Button btnEdit;
    @FXML
    private Button btnDelete;

    private ProductDTO productDTO;


    public void setProductDTO(ProductDTO productDTO) {
        this.productDTO = productDTO;

        lblName.setText(this.productDTO.getName());
        lblDescription.setText(this.productDTO.getDescription());
        lblQuantity.setText(this.productDTO.getQuantity().toString());
        lblMeasurementUnitUnit.setText(this.productDTO.getMeasurementUnitUnit() + ": ");
        lblMeasurementUnitName.setText(this.productDTO.getMeasurementUnitName());
        lblMeasurementUnitSymbol.setText("("+this.productDTO.getMeasurementUnitSymbol()+")");
        lblCurrentPrice.setText("(R$) " + this.productDTO.getCurrentPrice().toString());

      
    }

    public void onEdit(){}

    public void onDelete(){}

}
