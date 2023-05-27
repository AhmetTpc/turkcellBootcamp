package com.turkcell.bootcamp.project.entities.concretes;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="us_states")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UsStates {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="state_id")
    private  short state_id;

    @Column(name="state_name")
    private String stateName;

    @Column(name="state_abbr")
    private String stateAbbr;

    @Column(name="state_region")
    private String stateRegion;
}
