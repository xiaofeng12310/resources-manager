package com.example.controller;

import com.example.common.Result;
import com.example.entity.TrainingApply;
import com.example.service.TrainingApplyService;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/training/apply")
public class TrainingApplyController {
    @Resource
    private TrainingApplyService trainingApplyService;

    @PostMapping
    public Result apply(@RequestBody TrainingApply apply) {
        trainingApplyService.apply(apply);
        return Result.success();
    }

    @GetMapping("/my")
    public Result<List<TrainingApply>> getMyApply() {
        return Result.success(trainingApplyService.getMyApply());
    }

    @GetMapping
    public Result<List<TrainingApply>> getAll() {
        return Result.success(trainingApplyService.getAll());
    }

    @PutMapping
    public Result audit(@RequestBody TrainingApply apply) {
        trainingApplyService.audit(apply);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> cancelApply(@PathVariable Integer id) {
        trainingApplyService.cancelApply(id);
        return Result.success();
    }
}