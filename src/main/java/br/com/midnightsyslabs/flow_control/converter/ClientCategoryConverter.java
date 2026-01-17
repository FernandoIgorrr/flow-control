package br.com.midnightsyslabs.flow_control.converter;

import org.springframework.boot.micrometer.metrics.autoconfigure.MetricsProperties.Web.Client;

import br.com.midnightsyslabs.flow_control.dto.ClientCategory;
import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class ClientCategoryConverter implements AttributeConverter<ClientCategory, String> {

    @Override
    public String convertToDatabaseColumn(ClientCategory attribute) {
        return attribute == null ? "u" : String.valueOf(attribute.getCode());
    }

    @Override
    public ClientCategory convertToEntityAttribute(String dbData) {
        return dbData == null ? ClientCategory.UNDEFINED : ClientCategory.fromCode(dbData.charAt(0));
    }
}