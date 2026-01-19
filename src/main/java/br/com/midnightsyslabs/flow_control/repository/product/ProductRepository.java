package br.com.midnightsyslabs.flow_control.repository.product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.midnightsyslabs.flow_control.domain.entity.product.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product,Short>{

}