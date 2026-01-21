package br.com.midnightsyslabs.flow_control.repository.view;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.midnightsyslabs.flow_control.dto.SupplierDTO;

@Repository
public interface SupplierRepository extends JpaRepository<SupplierDTO,UUID>{

    
}
