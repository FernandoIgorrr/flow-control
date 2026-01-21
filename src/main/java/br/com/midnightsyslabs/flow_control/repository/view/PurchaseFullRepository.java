package br.com.midnightsyslabs.flow_control.repository.view;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.midnightsyslabs.flow_control.dto.PurchaseDTO;

public interface PurchaseFullRepository extends JpaRepository<PurchaseDTO,Integer>{
    
}
