package com.hk.service;

import com.hk.bean.Department;
import com.hk.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;


    /**
     * 获取所有部门
     * @return 保存部门的List
     */
    public List<Department> getAllDepts() {
        List<Department> departmentList =departmentMapper.selectByExample(null);
        return departmentList;
    }
}
