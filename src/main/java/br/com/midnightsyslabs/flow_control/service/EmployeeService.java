package br.com.midnightsyslabs.flow_control.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.employee.Employee;
import br.com.midnightsyslabs.flow_control.domain.entity.employee.EmployeePayment;
import br.com.midnightsyslabs.flow_control.domain.entity.spent.SpentCategory;
import br.com.midnightsyslabs.flow_control.repository.employee.EmployeePaymentRepository;
import br.com.midnightsyslabs.flow_control.repository.employee.EmployeeRepository;
import jakarta.transaction.Transactional;
import javafx.scene.control.TextField;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private EmployeePaymentRepository employeePaymentRepository;

    @Transactional
    public void saveEmployee(
            String name) {

        var employee = new Employee();
        employee.setName(name);
        employee.setCreatedAt(OffsetDateTime.now());

        employeeRepository.save(employee);
    }

    @Transactional
    public void editEmployee(Employee employee, String payment, LocalDate date) {

    }

    @Transactional
    public void disconnectEmployee(Employee employee){
        employee.setDeletedAt(OffsetDateTime.now());
        employeeRepository.save(employee);
    }
    @Transactional
    public void connectEmployee(Employee employee){
        employee.setDeletedAt(null);
        employeeRepository.save(employee);
    }

    @Transactional
    public void savePayments(
            Map<Employee, TextField> payments,
            LocalDate paymentDate) {
        for (Map.Entry<Employee, TextField> entry : payments.entrySet()) {

            String value = entry.getValue().getText();

            try {

                if (!(value == null || value.isBlank())) {

                    EmployeePayment employeePayment = new EmployeePayment();
                    employeePayment.setSpentCategory(new SpentCategory((short) 2, ""));
                    employeePayment.setEmployee(entry.getKey());
                    employeePayment.setPayment(new BigDecimal(UtilsService.solveComma(value)));
                    employeePayment.setPaymentChangeDate(paymentDate);

                    if (entry.getKey().getEmployeePaymentHistory() == null) {
                        entry.getKey().setEmployeePaymentHistory(List.of(employeePayment));
                    } else {
                        entry.getKey().getEmployeePaymentHistory().add(employeePayment);
                    }
                }

            } catch (Exception e) {
                throw e;
            }

            employeeRepository.save(entry.getKey());
        }
    }

    public List<Employee> getEmployees() {
        return employeeRepository.findAllConnectedWithHistory();
    }

    public List<Employee> getAllEmployees() {
        return employeeRepository.findAllWithHistory();
    }
    public List<EmployeePayment> getEmployeePayments() {
        return employeePaymentRepository.findAll();
    }

}
