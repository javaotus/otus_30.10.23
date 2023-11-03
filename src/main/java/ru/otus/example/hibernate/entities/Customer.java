package ru.otus.example.hibernate.entities;

import jakarta.persistence.CascadeType;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.MapKeyColumn;
import jakarta.persistence.MapKeyJoinColumn;
import jakarta.persistence.OneToOne;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Entity
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Customer {

    @Id
    @GeneratedValue(generator = "UUID")
    @Column(name = "id")
    private UUID id;

    @Column(name = "name", unique = true, nullable = false)
    private String name;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "email", unique = true, nullable = false)
    private Email email;

    @Column(name = "birth_date", nullable = false)
    private LocalDate birthDate;

    @Fetch(FetchMode.JOIN)
    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name="account_bank_customer", joinColumns=@JoinColumn(name="customer"), inverseJoinColumns=@JoinColumn(name="account"))
    private Set<Account> accounts;

    @Fetch(FetchMode.JOIN)
    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name="account_bank_customer", joinColumns=@JoinColumn(name="customer"), inverseJoinColumns=@JoinColumn(name="bank"))
    private Set<Bank> banks;

    @ElementCollection
    @Column(name = "amount", nullable = false)
    @MapKeyColumn(name = "currency")
    @MapKeyJoinColumn(name = "currency", referencedColumnName = "id", foreignKey = @ForeignKey(name = "FK_statement_currency"))
    @CollectionTable(
        name = "statement",
        joinColumns = { @JoinColumn(name = "customer", foreignKey = @ForeignKey(name = "FK_statement_customer")) }
    )
    private Map<Integer, BigDecimal> statement = new HashMap<>();

}