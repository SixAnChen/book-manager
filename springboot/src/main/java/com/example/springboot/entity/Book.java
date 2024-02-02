package com.example.springboot.entity;

import lombok.Data;

import javax.persistence.*;

/**
 * 功能：图书实体类
 * 作者：SixAn
 * 日期：2023-11-02 14:27
 */

@Data
@Table(name = "book")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "name")
    private String name;
    @Column(name = "author")
    private String author;
    @Column(name = "publisher")
    private String publisher;
    @Column(name = "isbn")
    private String isbn;
    @Column(name = "price")
    private String price;
    @Column(name = "publishTime")
    private String publishTime;
    private String summary;
    private String cover;
    @Column(name = "typeId")
    private Integer typeId;
    @Transient
    private String typeName;

    /**
     * 剩余本数
     */
    private Integer num;
}
