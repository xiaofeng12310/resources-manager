package com.example.controller;

import com.example.common.Result;
import com.example.common.enums.ResultCodeEnum;
import com.example.entity.Training;
import com.example.service.TrainingService;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/training")
public class TrainingController {
    @Resource
    private TrainingService trainingService;

    @PostMapping
    public Result<Training> add(@RequestBody Training training) {
        trainingService.add(training);
        return Result.success(training); // 返回新增的完整数据
    }



    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        trainingService.delete(id);
        return Result.success();
    }

    @PutMapping
    public Result update(@RequestBody Training training) {
        trainingService.update(training);
        return Result.success();
    }

    @GetMapping
    public Result<List<Training>> findAll() {
        return Result.success(trainingService.findAll());
    }

    @GetMapping("/{id}")
    public Result<Training> findById(@PathVariable Integer id) {
        return Result.success(trainingService.findById(id));
    }

    // TrainingController.java 新增批量删除方法
    @PostMapping("/delete/batch")
    public Result batchDelete(@RequestBody List<Integer> ids) {
        trainingService.batchDelete(ids);
        return Result.success();
    }
}
