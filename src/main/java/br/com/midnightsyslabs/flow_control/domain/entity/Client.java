package br.com.midnightsyslabs.flow_control.domain.entity;

import java.util.List;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "client")
public class Client {

    @Id
    @GeneratedValue
    @Column(name="client_id")
    private UUID id;

    @NotNull
    @Column(name = "client_name",nullable = false, unique = true)
    private String name;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name="client_type")
    private ClientType clientType;

}
