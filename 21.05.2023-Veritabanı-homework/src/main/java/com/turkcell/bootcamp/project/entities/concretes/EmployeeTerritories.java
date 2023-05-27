package com.turkcell.bootcamp.project.entities.concretes;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="employee_territories")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeTerritories {

    @ManyToOne()
    @MapsId("employeeId")
    @JoinColumn(name="employee_id")
    private Employees employee;

    @ManyToOne()
    @MapsId("territoryId")
    @JoinColumn(name = "territory_id")
    private Territories territory;

}
