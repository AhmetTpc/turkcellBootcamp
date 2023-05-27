package com.turkcell.bootcamp.project.entities.concretes;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="products")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Product {

    @Id
    @Column(name = "product_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short productId;

    @Column(name = "unit_price")
    private float unitPrice;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "supplier_id")
    private int supplierId;

    @Column(name = "category_id")
    private int categoryId;

    @Column(name = "quantity_per_unity")
    private String quantityPerUnity;

    @Column(name = "units_in_stock")
    private short units_in_stock;

    @Column(name = "units_on_order")
    private short unitsOnOrder;

    @Column(name = "reorder_level")
    private short reorderLevel;

    @Column(name = "discontinued")
    private int discontinued;

    @ManyToOne()
    @JoinColumn(name="category_id")
    private Category category;

    @ManyToOne()
    @JoinColumn(name = "supplier_id")
    private Supplier supplier;

}
