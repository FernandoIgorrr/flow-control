package br.com.midnightsyslabs.flow_control.repository.production;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.midnightsyslabs.flow_control.view.ProductionView;

@Repository
public interface ProductionViewRepository extends JpaRepository<ProductionView,Integer>{
    
}
