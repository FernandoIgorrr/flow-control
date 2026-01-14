package br.com.midnightsyslabs.flow_control.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.midnightsyslabs.flow_control.domain.entity.Product;

public interface ProductRepository extends JpaRepository<Product,Long>{

    Optional<Product> findById(Long id);
   
    List<Product> findAll();

    
}
