package br.com.midnightsyslabs.flow_control.domain.entity.partner;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.Getter;

@Entity
@Getter
public class CompanyPartner extends Partner {

    
    @Column(nullable = true)
    private String cnpj;

    @Override
    public String getDocument() {
        return this.cnpj;
    }

    // 🔹 Obrigatório para JPA
    protected CompanyPartner() {
    }

    public CompanyPartner(
            String name,
            String cnpj,
            String phone,
            String email,
            City city,
            PartnerRole category) {
        super(null, name, email, phone, city, category);
        this.cnpj = cnpj;
    }
}
