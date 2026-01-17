package br.com.midnightsyslabs.flow_control.domain.entity.partner;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.Getter;

@Entity
@Getter
public class PersonalPartner extends Partner {

    @Column(nullable = true)
    private String cpf;

    @Override
    public String getDocument() {
        return this.cpf;
    }

    protected PersonalPartner() {
    }

    public PersonalPartner(
            String name,
            String cpf,
            String phone,
            String email,
            City city,
            PartnerRole role) {
        super(null, name, email, phone, city, role);
        this.cpf = cpf;
    }
}
