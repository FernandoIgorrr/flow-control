package br.com.midnightsyslabs.flow_control.repository.employee;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.midnightsyslabs.flow_control.domain.entity.employee.EmployeePayment;

public interface EmployeePaymentRepository extends JpaRepository<EmployeePayment,Integer>{
    
}
