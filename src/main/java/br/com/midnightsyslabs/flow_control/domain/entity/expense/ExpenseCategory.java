package br.com.midnightsyslabs.flow_control.domain.entity.expense;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ExpenseCategory {
    @Id
    private Short id;

    private String name;
}
