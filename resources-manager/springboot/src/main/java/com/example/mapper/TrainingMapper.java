package com.example.mapper;

import com.example.entity.Training;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface TrainingMapper {
    List<Training> selectAll();
    void insert(Training training);
    void update(Training training);
    void delete(Integer id);
    Training selectById(Integer id);
    void batchDelete(List<Integer> ids);
}