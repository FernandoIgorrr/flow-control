package br.com.midnightsyslabs.flow_control.ui.controller;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.expense.Expense;
import br.com.midnightsyslabs.flow_control.domain.entity.revenue.Revenue;
import br.com.midnightsyslabs.flow_control.dto.SaleDTO;
import br.com.midnightsyslabs.flow_control.service.ExpenseService;
import br.com.midnightsyslabs.flow_control.service.PurchaseService;
import br.com.midnightsyslabs.flow_control.service.SaleService;
import br.com.midnightsyslabs.flow_control.service.SupplierService;
import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import br.com.midnightsyslabs.flow_control.view.SaleProductView;
import br.com.midnightsyslabs.flow_control.view.SupplierView;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.Node;
import javafx.scene.chart.AreaChart; // Alterado para AreaChart
import javafx.scene.chart.BarChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.PieChart;
import javafx.scene.chart.XYChart;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.Tooltip;

@Controller
public class StatementFinanceController {

    @Autowired
    private SaleService saleService;

    @Autowired
    private ExpenseService expenseService;

    @Autowired
    private PurchaseService purchaseService;

    @FXML
    private DatePicker dpInicio;
    @FXML
    private DatePicker dpFim;

    @FXML
    private PieChart categoryPieChart;

    @FXML
    private AreaChart<String, Number> financialLineChart;

    @FXML
    private BarChart<String, Number> clientBarChart;

    @FXML
    private BarChart<String, Number> purchaseBarChart;

    @FXML
    private BarChart<String, Number> productBarChart;

    @FXML
    private Label lblTotalReceita;
    @FXML
    private Label lblTotalDespesa;
    @FXML
    private Label lblSaldo;

    private static final NumberFormat CURRENCY_FORMAT = NumberFormat.getCurrencyInstance(new Locale("pt", "BR"));

    @FXML
    public void initialize() {
        // Define o mês atual por padrão
        dpInicio.setValue(LocalDate.now().withDayOfMonth(1));
        dpFim.setValue(LocalDate.now());

        dpInicio.setEditable(false);
        dpFim.setEditable(false);

        // Rotaciona os nomes dos produtos no eixo X para evitar sobreposição
        CategoryAxis xAxisProduct = (CategoryAxis) productBarChart.getXAxis();
        CategoryAxis xAxisClient = (CategoryAxis) clientBarChart.getXAxis();
        CategoryAxis xAxisPurchase = (CategoryAxis) purchaseBarChart.getXAxis();

        xAxisClient.setTickLabelRotation(45);
        xAxisProduct.setTickLabelRotation(45);
        xAxisPurchase.setTickLabelRotation(45);

        configureCategoryAxis(productBarChart);
        configureCategoryAxis(clientBarChart);
        configureCategoryAxis(purchaseBarChart);

        // Chama o filtro inicial para carregar os dados
        handleFiltrar();
    }

    private void applyCurrencyTooltip(XYChart.Data<String, Number> data, String labelPrefix) {
        data.nodeProperty().addListener((obs, oldNode, newNode) -> {
            if (newNode != null) {
                BigDecimal value = new BigDecimal(data.getYValue().toString());

                Tooltip tooltip = new Tooltip(
                        data.getXValue() + "\n" +
                                labelPrefix + ": " + CURRENCY_FORMAT.format(value));

                tooltip.setStyle("""
                            -fx-font-size: 16px;
                            -fx-font-weight: bold;
                            -fx-padding: 12;
                        """);

                Tooltip.install(newNode, tooltip);
            }
        });
    }

    private void configureCategoryAxis(BarChart<String, Number> chart) {
        CategoryAxis axis = (CategoryAxis) chart.getXAxis();
        axis.setAutoRanging(true);
        axis.setTickLabelRotation(45); // ou 60 se nomes grandes
        axis.setTickLabelGap(5);
        axis.setAnimated(false);
        axis.getStyleClass().add("axis-label");
    }

    @FXML
    void handleFiltrar() {
        LocalDate start = dpInicio.getValue();
        LocalDate end = dpFim.getValue();

        if (start != null && end != null) {
            List<SaleDTO> revs = saleService.searchBetween(start, end);
            List<Expense> exps = expenseService.searchBetween(start, end);
            List<PurchaseView> purchases = purchaseService.getPurchasesFromDate(purchaseService.getPurchasesView(),start, end);

            updatePieChart(exps);
            updateClientChart(revs);
            updatePurchaseChart(purchases);
            updateLineChart(revs, exps);
            updateProductChart(revs);
            atualizarLabelsTotais(revs, exps);
        }
    }

    public void updatePieChart(List<Expense> expenses) {
        Map<String, Double> dataMap = expenses.stream()
                .collect(Collectors.groupingBy(
                        e -> e.getSpentCategory() != null ? e.getSpentCategory().getName() : "Outros",
                        Collectors.summingDouble(e -> e.getExpense().doubleValue())));

        ObservableList<PieChart.Data> pieData = FXCollections.observableArrayList();

        dataMap.forEach((name, value) -> {
            if (value > 0) {
                String label = name + " (" + CURRENCY_FORMAT.format(value) + ")";
                pieData.add(new PieChart.Data(label, value));
            }
        });

        categoryPieChart.setData(pieData);
    }

    public void updateClientChart(List<SaleDTO> sales) {
        XYChart.Series<String, Number> series = new XYChart.Series<>();
        series.setName("Faturamento por Cliente");

        Map<String, BigDecimal> clientMap = sales.stream()
                .collect(Collectors.groupingBy(
                        s -> s.getClientName() != null ? s.getClientName() : "Cliente não identificado",
                        Collectors.mapping(
                                SaleDTO::getRevenue,
                                Collectors.reducing(BigDecimal.ZERO, BigDecimal::add))));

        clientMap.entrySet().stream()
                .sorted(Map.Entry.<String, BigDecimal>comparingByValue().reversed())
                .limit(10)
                .forEach(entry -> {
                    XYChart.Data<String, Number> data = new XYChart.Data<>(entry.getKey(), entry.getValue());

                    applyCurrencyTooltip(data, "Total gasto");

                    series.getData().add(data);
                });

        clientBarChart.getData().setAll(series);
    }

    public void updatePurchaseChart(List<PurchaseView> purchases) {
        XYChart.Series<String, Number> series = new XYChart.Series<>();
        series.setName("Gastos por Fornecedor");

        Map<String, BigDecimal> purchaseMap = purchases.stream()
            .collect(Collectors.groupingBy(
                p -> p.getPartnerName() != null ? p.getPartnerName() : "Fornecedor não inentificao",
                Collectors.mapping(
                    PurchaseView::getExpense,
                    Collectors.reducing(BigDecimal.ZERO,BigDecimal::add))));
      

        purchaseMap.entrySet().stream()
                .sorted(Map.Entry.<String, BigDecimal>comparingByValue().reversed())
                .limit(10)
                .forEach(entry -> {
                    XYChart.Data<String, Number> data = new XYChart.Data<>(entry.getKey(), entry.getValue());

                    applyCurrencyTooltip(data, "Total gasto");

                    series.getData().add(data);
                });

        purchaseBarChart.getData().setAll(series);
    }

    public void updateLineChart(List<SaleDTO> revenues, List<Expense> expenses) {
        XYChart.Series<String, Number> revSeries = new XYChart.Series<>();
        revSeries.setName("Receitas");

        XYChart.Series<String, Number> expSeries = new XYChart.Series<>();
        expSeries.setName("Despesas");

        // TreeMap garante que as datas fiquem em ordem crescente no gráfico
        Map<LocalDate, Double> revByDate = revenues.stream()
                .collect(Collectors.groupingBy(Revenue::getDate, TreeMap::new,
                        Collectors.summingDouble(r -> r.getRevenue().doubleValue())));

        Map<LocalDate, Double> expByDate = expenses.stream()
                .collect(Collectors.groupingBy(Expense::getDate, TreeMap::new,
                        Collectors.summingDouble(e -> e.getExpense().doubleValue())));

        // Adiciona os dados às séries
        revByDate.forEach((date, val) -> revSeries.getData().add(new XYChart.Data<>(date.toString(), val)));
        expByDate.forEach((date, val) -> expSeries.getData().add(new XYChart.Data<>(date.toString(), val)));

        financialLineChart.getData().setAll(revSeries, expSeries);

    }

    private void atualizarLabelsTotais(List<SaleDTO> revs, List<Expense> exps) {
        BigDecimal totalRev = revs.stream()
                .map(Revenue::getRevenue)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal totalExp = exps.stream()
                .map(Expense::getExpense)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal saldo = totalRev.subtract(totalExp);

        lblTotalReceita.setText(CURRENCY_FORMAT.format(totalRev));
        lblTotalDespesa.setText(CURRENCY_FORMAT.format(totalExp));
        lblSaldo.setText(CURRENCY_FORMAT.format(saldo));

        // Estilização dinâmica do saldo
        if (saldo.compareTo(BigDecimal.ZERO) < 0) {
            lblSaldo.getStyleClass().add("total-price-info-red");
        } else {
            lblSaldo.getStyleClass().add("total-price-info");
        }
    }

    public void updateProductChart(List<SaleDTO> sales) {
        XYChart.Series<String, Number> series = new XYChart.Series<>();
        series.setName("Faturamento por Produto");

        Map<String, BigDecimal> productMap = sales.stream()
                .filter(s -> s.getSaleProductsView() != null)
                .flatMap(sale -> sale.getSaleProductsView().stream())
                .collect(Collectors.groupingBy(
                        SaleProductView::getProductName,
                        Collectors.mapping(
                                p -> p.getProductPriceOnSaleDate().multiply(p.getProductQuantitySold()),
                                Collectors.reducing(BigDecimal.ZERO, BigDecimal::add))));

        productMap.entrySet().stream()
                .sorted(Map.Entry.<String, BigDecimal>comparingByValue().reversed())
                .limit(10)
                .forEach(entry -> {
                    XYChart.Data<String, Number> data = new XYChart.Data<>(entry.getKey(), entry.getValue());

                    applyCurrencyTooltip(data, "Faturamento");

                    series.getData().add(data);
                });

        productBarChart.getData().setAll(series);
    }
}