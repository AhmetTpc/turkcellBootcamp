package com.turkcell.bootcamp.project.entities.concretes;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;

@Entity
@Table(name="territories")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Territories {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="territory_id")
    private String territoryId;

    @Column(name="territory_description")
    private char territoryDescription;

    @OneToMany(mappedBy = "territory")
    private List<EmployeeTerritories> EmployeeTerritories;

    @ManyToOne()
    @JoinColumn(name="region_id")
    private Region region;


}
