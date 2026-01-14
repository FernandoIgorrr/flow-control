package br.com.midnightsyslabs.flow_control.ui.controller;

import org.springframework.stereotype.Component;

import br.com.midnightsyslabs.flow_control.service.NavigationService;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;

@Component
public class MainController {

    @FXML
    private StackPane conteudoPrincipal;

    @FXML
    private VBox sidebar;

    @FXML
    private Button dashboardButton;

    @FXML
    private Button productsButton;

    @FXML
    private Button clientsButton;

    @FXML
    private Button ordersButton;

    @FXML
    private Button expensesButton;
    
    @FXML
    private Button statementFinanceButton;

    private final NavigationService navService;

    public MainController(NavigationService navService) {
        this.navService = navService;
    }

    @FXML
    public void initialize() {
        navService.setMainContainer(conteudoPrincipal);
        // Carrega uma tela inicial opcional
        navService.navigateTo("/fxml/dashboard.fxml");
        setActive(dashboardButton);
    }

    private void setActive(Button activeButton) {
        sidebar.getChildren().forEach(node -> {
            if (node instanceof Button btn) {
                btn.getStyleClass().remove("selected");
            }
        });

        activeButton.getStyleClass().add("selected");
    }

    @FXML
    public void goToDashboard() {
        navService.navigateTo("/fxml/dashboard.fxml");
        setActive(dashboardButton);
    }

    @FXML
    public void goToProducts() {
        navService.navigateTo("/fxml/products.fxml");
        setActive(productsButton);
    }

    @FXML
    public void goToClients() {
        navService.navigateTo("/fxml/clients.fxml");
         setActive(clientsButton);
    }

    @FXML
    public void goToOrders() {
        navService.navigateTo("/fxml/orders.fxml");
         setActive(ordersButton);
    }

    @FXML
    public void goToExpenses() {
        navService.navigateTo("/fxml/expenses.fxml");
         setActive(expensesButton);
    }

    @FXML
    public void goToStatementFinance() {
        navService.navigateTo("/fxml/statement_finance.fxml");
         setActive(statementFinanceButton);
    }
}