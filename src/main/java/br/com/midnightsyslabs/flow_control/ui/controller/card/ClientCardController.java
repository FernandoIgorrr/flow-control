package br.com.midnightsyslabs.flow_control.ui.controller.card;

import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.dto.ClientCategory;
import br.com.midnightsyslabs.flow_control.dto.ClientDTO;
import br.com.midnightsyslabs.flow_control.ui.utils.MaskUtils;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.StackPane;

@Controller
public class ClientCardController {

    @FXML private Label lblName;
    @FXML private Label lblSubtitle;
    @FXML private Label lblPhone;
    @FXML private Label lblEmail;
    @FXML private Label lblDocument;
    @FXML private Label lblCity;
    @FXML private ImageView imgType;

  //  @FXML private Button btnEdit;
  //  @FXML private Button btnDelete;

    private ClientDTO client;

    @FXML private StackPane iconContainer;

public void setClient(ClientDTO client) {
    this.client = client;

    lblName.setText(client.getName());
    
    String document = client.getCategory() == ClientCategory.PERSONAL
            ? "CPF: " + MaskUtils.applyMask(client.getDocument(), "###.###.###-##")
            : "CNPJ: " + MaskUtils.applyMask(client.getDocument(), "##.###.###/####-##");

    lblDocument.setText(document);
    lblPhone.setText("Tel: " + MaskUtils.applyMask(client.getPhone(), "(##) #####-####"));
    lblEmail.setText("Email: " + client.getEmail());
    lblCity.setText("Cidade: " + client.getCity());


    if (client.getCategory() == ClientCategory.COMPANY) {
        lblSubtitle.setText("Companhia");
        lblSubtitle.getStyleClass().add("client-category-company");
        imgType.setImage(new Image(
                getClass().getResourceAsStream("/images/company.png")));
        iconContainer.getStyleClass().add("icon-company");

    } else {
        lblSubtitle.setText("Pessoa Física");
        
        lblSubtitle.getStyleClass().add("client-category-personal");
        imgType.setImage(new Image(
                getClass().getResourceAsStream("/images/person.png")));
        iconContainer.getStyleClass().add("icon-person");
    }
}

    @FXML
    private void onEdit() {
        System.out.println("Editar: " + client.getId());
    }

    @FXML
    private void onDelete() {
        System.out.println("Excluir: " + client.getId());
    }
}
