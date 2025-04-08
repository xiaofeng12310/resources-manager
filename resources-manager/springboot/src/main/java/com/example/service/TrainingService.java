package com.example.service;

import com.example.common.enums.LevelEnum;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Training;
import com.example.exception.CustomException;
import com.example.mapper.TrainingMapper;
import com.example.utils.TokenUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service
public class TrainingService {
    @Resource
    private TrainingMapper trainingMapper;

    // 校验权限
    private void checkAuth() {
        String role = TokenUtils.getCurrentUser().getRole();
        String level = TokenUtils.getCurrentUser().getLevel();
        if (!RoleEnum.ADMIN.name().equals(role) && !LevelEnum.HEADER.level.equals(level)) {
            throw new CustomException(ResultCodeEnum.NO_AUTH);
        }
    }

    public void add(Training training) {
        checkAuth();
        trainingMapper.insert(training);
    }

    public void delete(Integer id) {
        checkAuth();
        trainingMapper.delete(id);
    }

    public void update(Training training) {
        checkAuth();
        trainingMapper.update(training);
    }

    public List<Training> findAll() {
        return trainingMapper.selectAll();
    }

    public Training findById(Integer id) {
        return trainingMapper.selectById(id);
    }

    // TrainingService.java 新增方法
    public void batchDelete(List<Integer> ids) {
        checkAuth(); // 权限校验
        trainingMapper.batchDelete(ids);
    }
}
