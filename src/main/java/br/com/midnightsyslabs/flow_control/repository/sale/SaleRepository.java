package br.com.midnightsyslabs.flow_control.repository.sale;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.com.midnightsyslabs.flow_control.domain.entity.sale.Sale;

@Repository
public interface SaleRepository extends JpaRepository<Sale,Integer>{
       @Query("""
            SELECT s
            FROM Sale s
            LEFT JOIN FETCH s.saleProducts
            WHERE s.id = :id""")
    Optional<Sale> findByIdWithRawMaterialsPurchase(@Param("id") Integer id);
}
