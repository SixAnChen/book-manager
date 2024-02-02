package com.example.springboot.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Table(name = "type")
public class Type {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "name")
    private String name;
    @Column(name = "description")
    private String description;
    private String icon;
    private String url;

}

