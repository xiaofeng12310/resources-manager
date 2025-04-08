package com.example.mapper;

import com.example.entity.TrainingApply;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface TrainingApplyMapper {
    void insert(TrainingApply apply);
    void deleteById(Integer id);
    TrainingApply selectByUserTraining(TrainingApply apply);
    List<TrainingApply> selectByEmployee(Integer employeeId);
    List<TrainingApply> selectByDepartmentId(Integer departmentId);
    List<TrainingApply> selectAll();
    TrainingApply selectById(Integer id);
    void updateStatus(TrainingApply apply);
}