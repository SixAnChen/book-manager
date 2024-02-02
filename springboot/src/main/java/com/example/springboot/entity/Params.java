package com.example.springboot.entity;

import lombok.Data;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-10-25 05:38
 */
@Data
public class Params {
    private Integer pageNum = 1;
    private Integer pageSize = 10;

    // 条件参数
    private String name;
    private String address;

    private String author;
}
