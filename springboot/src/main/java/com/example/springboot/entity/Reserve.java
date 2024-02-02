package com.example.springboot.entity;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-11-06 14:38
 */

import lombok.Data;

import javax.persistence.*;

@Data
@Table(name = "reserve")
public class Reserve {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "bookId")
    private Integer bookId;
    @Column(name = "userId")
    private Integer userId;
    @Column(name = "days")
    private String days;
    @Column(name = "time")
    private String time;
    @Column(name = "status")
    private String status;
    @Column(name = "reason")
    private String reason;
    @Transient
    private String bookName;
    @Transient
    private String userName;

}
