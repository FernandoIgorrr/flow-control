package br.com.midnightsyslabs.flow_control.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.expense.Expense;
import br.com.midnightsyslabs.flow_control.dto.SaleDTO;
import br.com.midnightsyslabs.flow_control.repository.spent.SpentRepository;

@Service
public class ExpenseService {

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private SpentRepository spentRepository;

    @Autowired
    private EmployeeService employeeService;
    
    public List<Expense> getAllExpenses(){

        List<Expense> result = new ArrayList<Expense>();

        result.addAll(purchaseService.getPurchasesView());
        result.addAll(spentRepository.findAll());
        result.addAll(employeeService.getEmployeePayments());

        return result;
    }

      public  List<Expense> searchBetween(LocalDate start,LocalDate end){
        return getAllExpenses().stream().filter(expense-> !expense.getDate().isBefore(start) && !expense.getDate().isAfter(end)).toList();
    }
}
