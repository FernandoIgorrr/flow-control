package br.com.midnightsyslabs.flow_control.repository.employee;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.com.midnightsyslabs.flow_control.domain.entity.employee.Employee;
import br.com.midnightsyslabs.flow_control.domain.entity.product.Product;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, UUID> {
    @Query("""
            SELECT e
            FROM Employee e
            LEFT JOIN FETCH e.employeeWageHistory
            WHERE e.id = :id""")
    Optional<Product> findByIdWithWageHistory(@Param("id") UUID id);
}
