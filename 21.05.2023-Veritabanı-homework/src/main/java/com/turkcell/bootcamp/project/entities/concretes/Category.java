package com.turkcell.bootcamp.project.entities.concretes;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;

@Entity
@Table(name="categories")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Category {

    @Column(name="category_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short categoryId;

    @Column(name = "category_name")
    private String categoryName;

    @Column(name = "description")
    private String description;

    @Column(name="picture")
    private byte[] picture;

    @OneToMany(mappedBy = "category")
    private List<Product> products;

}
