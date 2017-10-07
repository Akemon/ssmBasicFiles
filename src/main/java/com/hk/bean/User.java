package com.hk.bean;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.*;
import java.util.List;

public class User {
    private Integer userId;

    private String name;

    @NotBlank(message = "用户名不能为空")
    @NotNull(message = "用户名不能为空")
    private String loginName;

    @NotBlank(message = "密码不能为空")
    @NotNull(message = "密码不能为空")
    private String loginPass;

    @NotNull(message = "年龄不能为空")
    @Digits(integer =150, fraction =1 )
    @Max(value = 150,message = "非法年龄")
    @Min(value=1 ,message = "非法年龄")
    private Integer age;

    private String sex;

    @NotBlank(message = "邮箱不能为空")
    @NotNull(message="邮箱不能为空")
    @Pattern(regexp = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$",message = "邮箱格式不正确")
    private String email;

    public Department getDepartment() {
        return department;
    }

    public User() {
    }

    public User(Integer userId, String name, String loginName, String loginPass, Integer age, String sex, String email, Integer deptId) {
        this.userId = userId;
        this.name = name;
        this.loginName = loginName;
        this.loginPass = loginPass;
        this.age = age;
        this.sex = sex;
        this.email = email;
        this.deptId = deptId;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    private Integer deptId;

    private Department department;

    //显示用于展示用户身份的集合
    private List<Role> roleList;

    //用于保存增加用户时的身份
    private Integer userRoleID;

    public Integer getUserRoleID() {
        return userRoleID;
    }

    public void setUserRoleID(Integer userRoleID) {
        this.userRoleID = userRoleID;
    }

    public List<Role> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Role> roleList) {
        this.roleList = roleList;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName == null ? null : loginName.trim();
    }

    public String getLoginPass() {
        return loginPass;
    }

    public void setLoginPass(String loginPass) {
        this.loginPass = loginPass == null ? null : loginPass.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", name='" + name + '\'' +
                ", loginName='" + loginName + '\'' +
                ", loginPass='" + loginPass + '\'' +
                ", age=" + age +
                ", sex='" + sex + '\'' +
                ", email='" + email + '\'' +
                ", deptId=" + deptId +
                ", department=" + department +
                '}';
    }
}