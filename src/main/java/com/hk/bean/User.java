package com.hk.bean;

public class User {
    private Integer userId;

    private String name;

    private String loginName;

    private String loginPass;

    private Integer age;

    private String sex;

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