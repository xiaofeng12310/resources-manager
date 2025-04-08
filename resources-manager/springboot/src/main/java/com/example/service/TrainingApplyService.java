package com.example.service;

import com.example.common.enums.LevelEnum;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Employee;
import com.example.entity.TrainingApply;
import com.example.exception.CustomException;
import com.example.mapper.TrainingApplyMapper;
import com.example.utils.TokenUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class TrainingApplyService {
    @Resource
    private TrainingApplyMapper trainingApplyMapper;

    public void cancelApply(Integer applyId) {
        TrainingApply apply = trainingApplyMapper.selectById(applyId);
        if (apply == null) {
            throw new CustomException(ResultCodeEnum.PARAM_ERROR, "报名记录不存在");
        }

        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) { // 修复了这里缺少的括号
            if (!currentUser.getId().equals(apply.getEmployeeId())) {
                throw new CustomException(ResultCodeEnum.NO_AUTH);
            }
        }

        trainingApplyMapper.deleteById(applyId);
    }

    // 员工报名
    public void apply(TrainingApply apply) {
        // 权限校验
        if (!LevelEnum.EMPLOYEE.level.equals(TokenUtils.getCurrentUser().getLevel())) {
            throw new CustomException(ResultCodeEnum.NO_AUTH);
        }

        apply.setEmployeeId(TokenUtils.getCurrentUser().getId());
        apply.setApplyTime(new Date());  // 现在类型匹配
        apply.setStatus("已报名");

        // 检查是否重复报名
        TrainingApply exist = trainingApplyMapper.selectByUserTraining(apply);
        if (exist != null) {
            throw new CustomException(ResultCodeEnum.PARAM_ERROR, "您已报名该培训");
        }

        trainingApplyMapper.insert(apply);
    }

    // 查询我的报名
    public List<TrainingApply> getMyApply() {
        return trainingApplyMapper.selectByEmployee(TokenUtils.getCurrentUser().getId());
    }

    public List<TrainingApply> getAll() {
        Account currentUser = TokenUtils.getCurrentUser();

        // 管理员：查看所有申请
        if (RoleEnum.ADMIN.name().equals(currentUser.getRole())) {
            return trainingApplyMapper.selectAll();
        }

        // 主管：仅查看本部门员工的申请
        if (LevelEnum.HEADER.level.equals(currentUser.getLevel())) {
            Employee employee = (Employee) currentUser; // 确保当前用户是员工
            return trainingApplyMapper.selectByDepartmentId(employee.getDepartmentId());
        }

        // 普通员工无权访问
        throw new CustomException(ResultCodeEnum.NO_AUTH);
    }

    // 审核报名
    public void audit(TrainingApply apply) {
        trainingApplyMapper.updateStatus(apply);
    }
}
