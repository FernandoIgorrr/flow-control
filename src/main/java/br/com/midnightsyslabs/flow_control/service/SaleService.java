package br.com.midnightsyslabs.flow_control.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.partner.Partner;
import br.com.midnightsyslabs.flow_control.domain.entity.sale.Sale;
import br.com.midnightsyslabs.flow_control.domain.entity.sale.SaleProduct;
import br.com.midnightsyslabs.flow_control.dto.SaleDTO;
import br.com.midnightsyslabs.flow_control.repository.sale.SaleRepository;
import br.com.midnightsyslabs.flow_control.repository.view.SaleProductViewRepository;
import br.com.midnightsyslabs.flow_control.repository.view.SaleViewRepository;
import br.com.midnightsyslabs.flow_control.ui.controller.form.ProductRow;
import br.com.midnightsyslabs.flow_control.view.PurchaseView;
import br.com.midnightsyslabs.flow_control.view.SaleView;

@Service
public class SaleService {
    @Autowired
    private SaleRepository saleRepository;

    @Autowired
    private SaleViewRepository saleViewRepository;

    @Autowired
    private SaleProductViewRepository saleProductViewRepository;

    public void saveSale(
            List<ProductRow> productsRow,
            Partner partner,
            LocalDate date) {

        var sale = new Sale();
        List<SaleProduct> salesProduct = new ArrayList<>();
        sale.setClient(partner);
        sale.setDate(date);
        sale.setCreatedAt(OffsetDateTime.now());

        try {
            for (var row : productsRow) {
                SaleProduct saleProduct = new SaleProduct();
                saleProduct.setSale(sale);
                saleProduct.setProduct(row.productComboBox.getValue());
                saleProduct
                        .setQuantity(new BigDecimal(UtilsService.solveComma(row.productQuantitySoldField.getText())));

                salesProduct.add(saleProduct);
            }
        } catch (Exception e) {
            throw e;
        }
        sale.setSaleProducts(salesProduct);
        saleRepository.save(sale);
    }

    public List<SaleDTO> getSalesDTO() {
       
        var salesView = saleViewRepository.findAll()
            .stream()
            .sorted(Comparator.comparing(SaleView::getDate)
            .reversed()
            .thenComparing(SaleView::getId, Comparator.reverseOrder()));
                

        var salesDTO = salesView.map(SaleDTO::new).toList();

        salesDTO.forEach(sDTO -> {

            var spvs = saleProductViewRepository.findAllBySaleId(sDTO.getId());
            sDTO.setSaleProductsView(spvs);
        });

        return salesDTO;
    }

       public BigDecimal calculateTotalRevenue(List<SaleDTO> SalesDTO) {
        return SalesDTO.stream()
        .map(SaleDTO::getRevenue)
        .reduce(BigDecimal.ZERO,BigDecimal::add);
    }
}
