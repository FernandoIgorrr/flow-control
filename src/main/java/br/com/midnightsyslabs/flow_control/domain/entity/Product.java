package br.com.midnightsyslabs.flow_control.domain.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity
@Table(name = "product")
public class Product {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="product_id")
    private Short id;

    @Column(name="product_name", nullable = false, unique = true)
    private String name;
    
    @Column(name="product_description", nullable = false, unique = true)
    private String description;

}
