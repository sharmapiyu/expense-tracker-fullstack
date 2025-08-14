package com.example.expensetracker.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "expenses")
public class Expense {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false,
            foreignKey = @ForeignKey(name = "fk_expense_user"))
    private User user;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false, precision = 14, scale = 2)
    private BigDecimal amount;

    @Column(nullable = false)
    private LocalDate date;

    public Expense() {}
    public Expense(User user, String description, BigDecimal amount, LocalDate date) {
        this.user = user; this.description = description; this.amount = amount; this.date = date;
    }

    public Long getId() { return id; }
    public User getUser() { return user; }
    public String getDescription() { return description; }
    public BigDecimal getAmount() { return amount; }
    public LocalDate getDate() { return date; }

    public void setId(Long id) { this.id = id; }
    public void setUser(User user) { this.user = user; }
    public void setDescription(String description) { this.description = description; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public void setDate(LocalDate date) { this.date = date; }
}
