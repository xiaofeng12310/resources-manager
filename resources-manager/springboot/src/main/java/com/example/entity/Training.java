package com.example.entity;

import lombok.Data;

@Data
public class Training {
    private Integer id;
    private String name;
    private String content;
    private String time;
    private String location;
    private String teacher;
}
