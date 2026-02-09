package br.com.midnightsyslabs.flow_control.ui.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.config.TimeIntervalEnum;
import br.com.midnightsyslabs.flow_control.domain.entity.employee.Employee;
import br.com.midnightsyslabs.flow_control.domain.entity.employee.EmployeePayment;
import br.com.midnightsyslabs.flow_control.domain.entity.expense.Expense;
import br.com.midnightsyslabs.flow_control.domain.entity.spent.Spent;
import br.com.midnightsyslabs.flow_control.domain.entity.spent.SpentCategory;
import br.com.midnightsyslabs.flow_control.repository.spent.SpentCategoryRepository;
import br.com.midnightsyslabs.flow_control.service.DateService;
import br.com.midnightsyslabs.flow_control.service.EmojiService;
import br.com.midnightsyslabs.flow_control.service.EmployeeService;
import br.com.midnightsyslabs.flow_control.service.ExpenseService;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.SpentService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import br.com.midnightsyslabs.flow_control.ui.cards.EmployeePaymentCard;
import br.com.midnightsyslabs.flow_control.ui.cards.PurchaseCard;
import br.com.midnightsyslabs.flow_control.ui.cards.SpentCard;
import br.com.midnightsyslabs.flow_control.ui.controller.form.SpentFormController;
import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Rectangle2D;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.effect.ColorAdjust;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Screen;
import javafx.stage.Stage;
import javafx.util.StringConverter;

@Controller
public class ExpensesController {

    @Autowired
    private SpentService spentService;

    @Autowired
    private EmojiService emojiService;

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private ExpenseService expenseService;

    @Autowired
    private SpentCategoryRepository spentCategoryRepository;

    @Autowired
    private ApplicationContext context;

    private List<Expense> allExpenses;

    private List<Expense> filteredExpenses;

    @FXML
    private ComboBox<TimeIntervalEnum> timeIntervalEnumComboBoxFilter;

    @FXML
    private ComboBox<SpentCategory> spentCategoryComboBoxFilter;

    @FXML
    private ComboBox<Employee> employeeComboBoxFilter;

    @FXML
    private ImageView imgType;

    @FXML
    private Button btnAddSpent;

    @FXML
    private VBox cardsPane;

    @FXML
    private Label lblTotalExpenses;

    @FXML
    private Label lblTotalExpensesSpend;

    @FXML
    public void initialize() {

        loadExpenses();

        configureTimeIntervalEnumComboBoxFilter();
        configureSpentCategoryComboBoxFilter();
        configureEmployeeComboBoxFilter();

        imgType.setImage(new Image(
                getClass().getResourceAsStream("/images/game-icons--basket.png")));
        imgType.getStyleClass().add("blue-icon");
    }

    public void configureTimeIntervalEnumComboBoxFilter() {
        this.timeIntervalEnumComboBoxFilter.getItems().setAll(TimeIntervalEnum.values());

        this.timeIntervalEnumComboBoxFilter.setConverter(new StringConverter<>() {
            @Override
            public String toString(TimeIntervalEnum interval) {
                return interval == null ? "" : interval.getLabel();
            }

            @Override
            public TimeIntervalEnum fromString(String string) {
                return null;
            }
        });

        this.timeIntervalEnumComboBoxFilter.valueProperty().addListener((obs, oldValue, newValue) -> {
            if (newValue == null)
                return;
            applyFilters();
        });

        this.timeIntervalEnumComboBoxFilter.getSelectionModel().selectFirst();
    }

    private void configureSpentCategoryComboBoxFilter() {
        spentCategoryComboBoxFilter.getItems().setAll(
                spentCategoryRepository.findAll());

        spentCategoryComboBoxFilter.getItems().add(new SpentCategory());
        spentCategoryComboBoxFilter.setConverter(new StringConverter<SpentCategory>() {
            @Override
            public String toString(SpentCategory sc) {
                return (sc == null || sc.getName() == null) ? "Todos" : sc.getName();
            }

            @Override
            public SpentCategory fromString(String s) {
                return null;
            }
        });

        spentCategoryComboBoxFilter.valueProperty().addListener((obs, old, newVal) -> {

            applyFilters();
        });
        spentCategoryComboBoxFilter.getSelectionModel().selectLast();
    }

    private void configureEmployeeComboBoxFilter() {
        employeeComboBoxFilter.getItems().setAll(
                employeeService.getEmployees());

        employeeComboBoxFilter.getItems().add(new Employee());
        employeeComboBoxFilter.setConverter(new StringConverter<Employee>() {
            @Override
            public String toString(Employee e) {
                return (e == null || e.getName() == null) ? "Todos" : e.getName();
            }

            @Override
            public Employee fromString(String s) {
                return null;
            }
        });

        employeeComboBoxFilter.getSelectionModel().selectLast();

        employeeComboBoxFilter.valueProperty().addListener((obs, old, newVal) -> {

            applyFilters();
        });
    }

    @FXML
    public void onAddSpent() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/form/spent-form.fxml"));

            loader.setControllerFactory(context::getBean);

            Rectangle2D screenBounds = Screen.getPrimary().getVisualBounds();
            double width = screenBounds.getWidth() * 0.3;
            double height = screenBounds.getHeight() * 0.5;

            Stage dialog = new Stage();
            dialog.setTitle("Cadastrar Despesa");
            dialog.setScene(new Scene(loader.load(), width, height));

            SpentFormController controller = loader.getController();
            controller.setOnDataChanged(this::loadExpenses);

            Stage mainStage = (Stage) btnAddSpent.getScene().getWindow();

            dialog.initOwner(mainStage);
            dialog.initModality(Modality.WINDOW_MODAL);

            dialog.setResizable(false);
            // stage.showAndWait();

            ColorAdjust darken = new ColorAdjust();
            darken.setBrightness(-0.8);
            mainStage.getScene().getRoot().setEffect(darken);

            dialog.setOnHidden(e -> mainStage.getScene().getRoot().setEffect(null));

            dialog.showAndWait();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void renderCards(List<Expense> expenses) {

        cardsPane.getChildren().clear();

        for (var expense : expenses) {
            try {
                if (expense.getSpentCategory().getId() == 1) {

                    cardsPane.getChildren()
                            .add(new PurchaseCard((PurchaseView) expense, this::loadExpenses, purchaseService,context));

                } else if (expense.getSpentCategory().getId() == 2) {

                    cardsPane.getChildren().add(new EmployeePaymentCard((EmployeePayment) expense, this::loadExpenses,
                            employeeService, emojiService));
                } else {

                    cardsPane.getChildren().add(new SpentCard((Spent) expense, this::loadExpenses, spentService,emojiService));
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void applyFilters() {

        filteredExpenses = allExpenses.stream()

                // 🔹 filtro por categoria de gasto
                .filter(expense -> spentCategoryComboBoxFilter.getValue() == null
                        || spentCategoryComboBoxFilter.getValue().getName() == null ||
                        expense.getSpentCategory().getId().equals(spentCategoryComboBoxFilter.getValue().getId()))

                // 🔹 filtro por funcionário
                .filter(expense -> employeeComboBoxFilter.getValue() == null
                        || employeeComboBoxFilter.getValue().getName() == null
                        || (expense instanceof EmployeePayment ep
                                && ep.getEmployee().getId()
                                        .equals(employeeComboBoxFilter.getValue().getId())))

                // 🔹 filtro por intervalo de datas
                .filter(expense -> {
                    if (timeIntervalEnumComboBoxFilter.getValue() == TimeIntervalEnum.ALL_TIME) {
                        return true;
                    }

                    LocalDate from = DateService.timeIntervalEnumToDateFrom(timeIntervalEnumComboBoxFilter.getValue());
                    LocalDate to = DateService.timeIntervalEnumToDateTo(timeIntervalEnumComboBoxFilter.getValue());

                    return !expense.getDate().isBefore(from) && !expense.getDate().isAfter(to);
                })

                .toList();

        renderCards(filteredExpenses);

        renderRecentExpenseAmountCard();
    }

    private void renderRecentExpenseAmountCard() {
        lblTotalExpensesSpend.setText(UtilsService.formatPrice(
                filteredExpenses.stream().map(Expense::getExpense).reduce(BigDecimal.ZERO, BigDecimal::add)));
        lblTotalExpenses.setText("" + filteredExpenses.size());
    }

    private String safe(String value) {
        return value == null ? "" : value.toLowerCase();
    }

    private void loadExpenses() {
        allExpenses = expenseService.getAllExpenses();

        filteredExpenses = allExpenses;

        renderCards(filteredExpenses);
        renderRecentExpenseAmountCard();
    }

}