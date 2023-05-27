package com.turkcell.bootcamp.project.entities.concretes;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="customer_customer_demo")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CustomerCustomerDemo  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="customer_id")
    private char customerId;

    @Column(name="customer_type_id")
    private char customerTypeId;

}
