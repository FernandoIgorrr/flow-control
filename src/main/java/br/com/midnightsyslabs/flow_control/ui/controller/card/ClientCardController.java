package br.com.midnightsyslabs.flow_control.ui.controller.card;

import org.springframework.stereotype.Controller;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import br.com.midnightsyslabs.flow_control.exception.ClientNotFoundException;
import br.com.midnightsyslabs.flow_control.ui.utils.MaskUtils;
import br.com.midnightsyslabs.flow_control.view.ClientView;
import br.com.midnightsyslabs.flow_control.view.PartnerCategory;
import br.com.midnightsyslabs.flow_control.service.ClientService;
import br.com.midnightsyslabs.flow_control.repository.CityRepository;
import br.com.midnightsyslabs.flow_control.ui.controller.form.edit.ClientEditFormController;
import br.com.midnightsyslabs.flow_control.repository.partner.CompanyPartnerRepository;
import br.com.midnightsyslabs.flow_control.repository.partner.PersonalPartnerRepository;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.stage.Screen;
import javafx.stage.Modality;

import javafx.scene.image.Image;
import javafx.scene.control.Label;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonBar;
import javafx.scene.control.ButtonType;
import javafx.scene.control.DialogPane;
import javafx.scene.image.ImageView;
import javafx.scene.layout.StackPane;
import javafx.scene.text.Text;
import javafx.scene.text.TextFlow;
import javafx.scene.effect.ColorAdjust;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;

import javafx.geometry.Rectangle2D;

@Controller
@Scope("prototype")
public class ClientCardController {

    @Autowired
    private ApplicationContext context;

    @Autowired
    private PersonalPartnerRepository personalPartnerRepository;

    @Autowired
    private CompanyPartnerRepository companyPartnerRepository;

    @Autowired
    private ClientService clientService;

    private ClientView clientView;

    private Runnable onDataChanged; // callback

    @FXML
    private Label lblName;
    @FXML
    private Label lblSubtitle;
    @FXML
    private Label lblPhone;
    @FXML
    private Label lblEmail;
    @FXML
    private Label lblDocument;
    @FXML
    private Label lblCity;
    @FXML
    private ImageView imgType;

    @FXML
    private Button btnEdit;
    @FXML
    private Button btnDelete;
    @FXML
    private StackPane iconContainer;

    public void setClientView(ClientView client) {
        this.clientView = client;

        lblName.setText(client.getName());

        String document = client.getCategory() == PartnerCategory.PERSONAL
                ? "CPF: " + MaskUtils.applyMask(client.getDocument(), "###.###.###-##")
                : "CNPJ: " + MaskUtils.applyMask(client.getDocument(), "##.###.###/####-##");

        lblDocument.setText(document);
        lblPhone.setText("Tel: " + MaskUtils.applyMask(client.getPhone(), "(##) #####-####"));
        lblEmail.setText("Email: " + client.getEmail());
        lblCity.setText("Cidade: " + client.getCity());

        if (client.getCategory() == PartnerCategory.COMPANY) {
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

    public void setOnDataChanged(Runnable onDataChanged) {
        this.onDataChanged = onDataChanged;
    }

    @FXML
    private void onEdit() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/form/client-edit-form.fxml"));

            var controller = new ClientEditFormController(
                    context.getBean(CompanyPartnerRepository.class),
                    context.getBean(PersonalPartnerRepository.class),
                    context.getBean(ClientService.class),
                    context.getBean(CityRepository.class));

            controller.editClientForm(clientView);
            loader.setControllerFactory(ctr -> controller);

            Rectangle2D screenBounds = Screen.getPrimary().getVisualBounds();
            double width = screenBounds.getWidth() * 0.5;
            double height = screenBounds.getHeight() * 0.5;

            Stage dialog = new Stage();

            dialog.setTitle("Editar Cliente");

            dialog.setScene(new Scene(loader.load(), width, height));

            Stage mainStage = (Stage) btnEdit.getScene().getWindow();

            dialog.initOwner(mainStage);
            dialog.initModality(Modality.WINDOW_MODAL);

            dialog.setResizable(false);
            // stage.showAndWait();

            ColorAdjust darken = new ColorAdjust();
            darken.setBrightness(-0.8);
            mainStage.getScene().getRoot().setEffect(darken);

            dialog.setOnHidden(e -> mainStage.getScene().getRoot().setEffect(null));

            dialog.showAndWait();

            // avisa o controller pai
            if (onDataChanged != null) {
                onDataChanged.run();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void onDelete() {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("⚠️ CONFIRMAÇÃO DE EXCLUSÃO");
        alert.setHeaderText("VOCÊ TEM CERTEZA?");
        /*
         * alert.setContentText(
         * "Esta ação é IRREVERSÍVEL.\n\n" +
         * "O cliente " + clientDTO.getName() +
         * " será removido permanentemente do sistema.");
         */

        Label content = new Label(
                "Esta ação é IRREVERSÍVEL.\n\n" +
                        "O cliente " + clientView.getName() + " será removido permanentemente do sistema.");
        content.setWrapText(true);

        Text warningText = new Text("Esta ação é IRREVERSÍVEL. ");
        warningText.getStyleClass().add("danger-text");

        Text startText = new Text("\n\nO cliente: ");
        startText.getStyleClass().add("common-text");

        Text clientName = new Text(clientView.getName());
        clientName.getStyleClass().add("danger-name");

        Text endText = new Text(" será removido permanentemente do sistema.");
        endText.getStyleClass().add("common-text");

        TextFlow textFlow = new TextFlow(warningText, startText, clientName, endText);
        textFlow.setMaxWidth(420);

        alert.getDialogPane().setContent(textFlow);

        // Botões personalizados
        ButtonType cancelButton = new ButtonType("CANCELAR", ButtonBar.ButtonData.CANCEL_CLOSE);
        ButtonType deleteButton = new ButtonType("DELETAR", ButtonBar.ButtonData.OK_DONE);

        alert.getButtonTypes().setAll(cancelButton, deleteButton);

        // Estilização após o dialog ser criado
        DialogPane dialogPane = alert.getDialogPane();
        dialogPane.getStylesheets().add(
                getClass().getResource("/css/alert-danger.css").toExternalForm());
        dialogPane.getStyleClass().add("danger-alert");

        Optional<ButtonType> result = alert.showAndWait();

        if (result.isPresent() && result.get() == deleteButton) {
            // 👉 CHAME A LÓGICA DE DELETE AQUI
            if (clientView.getCategory() == PartnerCategory.PERSONAL) {
                personalPartnerRepository.findById(clientView.getId()).ifPresentOrElse(client -> {
                    clientService.deletePersonalClient(client);
                }, ClientNotFoundException::new);
            } else {
                companyPartnerRepository.findById(clientView.getId()).ifPresentOrElse(client -> {
                    clientService.deleteCompanyClient(client);
                }, ClientNotFoundException::new);
            }
        }

        // avisa o controller pai
        if (onDataChanged != null) {
            onDataChanged.run();
        }
    }
}
