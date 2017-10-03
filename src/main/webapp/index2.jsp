<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <meta charset="UTF-8" />
    <script type="text/javascript" src="static/js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css" />
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="static/js/myJavascript.js"></script>
</head>
<body>


<div class="container">
    <!-- 标题-->
    <div class="row">
        <div class="col-md-12"><h1>用户管理</h1></div>
    </div>
    <!-- 按钮-->
    <div class="row" style="display:inline">
        <div class="col-md-6" >
            <div class="input-group" >
                <input type="text" class="form-control" id="searchString">
                <span class="input-group-btn">
						<button class="btn btn-primary" type="button" onclick="searchUser()">
							查询
						</button>
					</span>
            </div><!-- /input-group -->
        </div>
        <div class="col-md-6  col-md-offset-10" >
            <button class="btn btn-lg btn-primary" data-toggle="modal" data-target="#addUser" onclick="getAllDepts('#addUser',0)">新增</button>
            <button class="btn btn-lg btn-danger" id="delete_all_btn">删除</button>
        </div>

    </div>
    <!-- 显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="user_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>id</th>
                    <th>姓名</th>
                    <th>用户名</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>

                </thead>
                <tbody>


                </tbody>



            </table>
        </div>

    </div>
    <!-- 显示分布信息-->
    <div class="row">
        <div class="col-md-6" id="show_page_basicInfo">

        </div>
        <div class="col-md-6">

            <ul class="pagination" id="show_ul_Info">

            </ul>


        </div>
    </div>
</div>
<!-- 用户修改模态框 -->
<div class="modal fade" id="updateUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" >
                    修改用户
                </h4>
            </div>
            <div class="modal-body">
                <!--内容部分 -->

                <form class="form-horizontal" role="form">
                    <input type="hidden" name="userId" id="update_userID">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_name" name="name" placeholder="请输入姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="loginName" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10 ">
                            <input  readonly  class="form-control" id="update_loginName" name="loginName" />
                            <span class="help-block"></span>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="loginPass" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_loginPass" name="loginPass" placeholder="请输入密码" onchange="checkPass('#update_loginPass')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_age" name="age" placeholder="请输入年龄" onchange="checkAge('#update_age')">
                            <span class="help-block"></span>
                        </div>

                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别</label>
                        <label class="radio-inline  col-sm-2 col-sm-offset-1">
                            <input type="radio" name="sex"value="男" checked="true"> 男
                        </label>
                        <label class="radio-inline col-sm-2">
                            <input type="radio"  name="sex" value="女"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_email" name="email" placeholder="请输入邮箱" onchange="checkEmail('#update_email')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label for="dept_add_select" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-5">
                            <select class="form-control " name="deptId" id ="dept_update_select">
                            </select>
                        </div>
                    </div>

                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="updateUser()">
                    更新
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 用户添加模态框 -->
<div class="modal fade" id="addUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    添加用户
                </h4>
            </div>
            <div class="modal-body">
                <!--内容部分 -->

                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="loginName" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10 ">
                            <input type="text" class="form-control" id="loginName" name="loginName" placeholder="请输入用户名" onchange="checkLoginName('#loginName')">
                            <span class="help-block"></span>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="loginPass" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="loginPass" name="loginPass" placeholder="请输入密码" onchange="checkPass('#loginPass')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="age" name="age" placeholder="请输入年龄" onchange="checkAge('#age')">
                            <span class="help-block"></span>
                         </div>

                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别</label>
                        <label class="radio-inline  col-sm-2 col-sm-offset-1">
                            <input type="radio" name="sex"value="男" checked="true"> 男
                        </label>
                        <label class="radio-inline col-sm-2">
                            <input type="radio"  name="sex" value="女"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱" onchange="checkEmail('#email')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label for="dept_add_select" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-5">
                            <select class="form-control " name="deptId" id ="dept_add_select">
                            </select>
                        </div>
                    </div>

                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="addUser()">
                    保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
