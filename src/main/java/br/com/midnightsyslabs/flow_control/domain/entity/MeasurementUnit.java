package br.com.midnightsyslabs.flow_control.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;

@Entity
@AllArgsConstructor
public class MeasurementUnit {

    @Id
    private Short id;

    @NotNull
    private String symbol;

    @NotNull
    private String name;

}
