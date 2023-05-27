package com.turkcell.bootcamp.project.entities.concretes;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="order_details")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetail {

    @Id
    @Column(name = "order_details_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short orderDetails;

    @Column(name = "unit_price")
    private float unitPrice;

    @Column(name = "quantity")
    private short quantity;

    @Column(name = "discount")
    private float discount;

    @ManyToOne
    @MapsId("productId")
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne()
    @MapsId("orderId")
    @JoinColumn(name = "order_id")
    private Order order;
}
