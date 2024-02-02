package com.example.springboot.entity;

import lombok.Data;

import javax.persistence.*;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-10-24 17:00
 */
@Table(name = "user")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "username")
    private String username;
    @Column(name = "password")
    private String password;
    @Column(name = "name")
    private String name;
    @Column(name = "phone")
    private String phone;
    @Column(name = "email")
    private String email;
    @Column(name = "address")
    private String address;
    @Column(name = "avatar")
    private String avatar;

    @Column
    private String birthday;
    @Column
    private Boolean status;
    @Column
    private String role;
    @Column
    private Integer score;
    @Transient
    private String oldPassword;
    @Transient
    private String newPassword;
}
