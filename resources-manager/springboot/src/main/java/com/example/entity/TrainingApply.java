package com.example.entity;

import lombok.Data;
import java.util.Date;

@Data
public class TrainingApply {
    private Integer id;
    private Integer trainingId;
    private Integer employeeId;
    private Date applyTime;// 使用 Date 类型
    private String trainingName;
    private String employeeName;
    private String status;
}
