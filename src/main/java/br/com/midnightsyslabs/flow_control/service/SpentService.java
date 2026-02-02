package br.com.midnightsyslabs.flow_control.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.spent.Spent;
import br.com.midnightsyslabs.flow_control.domain.entity.spent.SpentCategory;
import br.com.midnightsyslabs.flow_control.repository.spent.SpentRepository;
import jakarta.transaction.Transactional;

@Service
public class SpentService {

    @Autowired
    private SpentRepository spentRepository;

    @Transactional
    public void saveSpent(
            String amountPaid,
            SpentCategory spentCategory,
            String spentDescription,
            LocalDate date) {

        var spent = new Spent();
        spent.setAmountPaid(new BigDecimal(UtilsService.solveComma(amountPaid)));
        spent.setCategory(spentCategory);
        spent.setDescription(spentDescription);
        spent.setDate(date);
        spent.setCreatedAt(OffsetDateTime.now());

        spentRepository.save(spent);

    }
}
