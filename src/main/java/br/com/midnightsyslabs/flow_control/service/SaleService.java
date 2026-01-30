package br.com.midnightsyslabs.flow_control.service;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.production.Production;
import br.com.midnightsyslabs.flow_control.domain.entity.sale.Sale;
import br.com.midnightsyslabs.flow_control.repository.sale.SaleRepository;

@Service
public class SaleService {
    @Autowired
    private SaleRepository saleRepository;

    public void saveSale(
        List<Production> productions,
        LocalDate date,
        String quantitySold
        ){

        var quantitySold_ = UtilsService.solveComma(quantitySold);

        var sale = new Sale();

        sale.setCreatedAt(OffsetDateTime.now());
        sale.setDate(date);


    }

    public List<Sale> getSales(){
        return saleRepository.findAll();
    }
}
