package br.com.midnightsyslabs.flow_control.service;

import java.util.List;
import java.util.Comparator;
import java.math.BigDecimal;
import java.time.OffsetDateTime;

import jakarta.transaction.Transactional;

import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.product.Product;
import br.com.midnightsyslabs.flow_control.domain.entity.product.ProductPrice;
import br.com.midnightsyslabs.flow_control.repository.product.ProductRepository;
import br.com.midnightsyslabs.flow_control.domain.entity.product.MeasurementUnit;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(
            ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Transactional
    public Product saveProduct(
            String name,
            String description,
            String price,
            String quantity,
            MeasurementUnit measurementUnit) {
        
        price = solveComma(price);
        quantity = solveComma(quantity);

        var product = new Product();
        var productPrice = new ProductPrice();

        product.setName(name);
        product.setDescription(description);
       
        product.setMeasurementUnit(measurementUnit);
        product.setCreatedAt(OffsetDateTime.now());
        try {
            product.setQuantity(new BigDecimal(quantity));
            productPrice.setPrice(new BigDecimal(price));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Tem algo errado com formato do preço!");
        }
        productPrice.setPriceChangeDate(OffsetDateTime.now());
        productPrice.setProduct(product);

        product.setProductPriceHistory(List.of(productPrice));

        return productRepository.save(product);

    }

    @Transactional
    public void editProduct(
            Product product,
            String name,
            String description,
            String price) {

        product.setName(name);
        product.setDescription(description);

        var newPrice = new BigDecimal(price);
        var currentPrice = product.getProductPriceHistory()
                .stream()
                .max(Comparator.comparing(ProductPrice::getPriceChangeDate))
                .map(ProductPrice::getPrice)
                .orElse(null);

        if (currentPrice == null || currentPrice.compareTo(newPrice) != 0) {
            ProductPrice newPriceEntry = new ProductPrice();
            newPriceEntry.setProduct(product);
            newPriceEntry.setPrice(newPrice);
            newPriceEntry.setPriceChangeDate(OffsetDateTime.now());

            product.getProductPriceHistory().add(newPriceEntry);
        }

        productRepository.save(product);

    }

    @Transactional
    public void deleteProduct(Product product) {
        product.setDeletedAt(OffsetDateTime.now());
        productRepository.save(product);
    }

    // Como nós brasileiros usamos a virgula (,) para separar a parte decimal dos número
    // e aqui no Java o BigDecimal o ponto (.) esse method resolve isso!
    String solveComma(String bigDecimanStr){
        return bigDecimanStr.replace(",", ".");
    }
}
