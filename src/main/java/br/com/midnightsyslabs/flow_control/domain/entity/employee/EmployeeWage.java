package br.com.midnightsyslabs.flow_control.domain.entity.employee;

import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;

import br.com.midnightsyslabs.flow_control.domain.entity.expense.Expense;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeWage implements Expense{
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(nullable = false)
    private Employee employee;
    
    @Positive
    @NotNull
    private BigDecimal wage;

    @NotNull
    @Column(columnDefinition="date")
    private LocalDate wageChangeDate;

    @Override
    public BigDecimal getExpense() {
        return wage;
    }

    @Override
    public LocalDate getDate() {
        return wageChangeDate;
    }


}
