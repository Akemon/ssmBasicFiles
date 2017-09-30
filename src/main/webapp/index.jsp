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

</head>
<body>
<script type="text/javascript">
    function  getAllDepts() {
       $.ajax({
           url:"http://localhost:8080/getAllDepts",
           type:"POST",
           success:function (result) {
              $.each(result.extend.depts,function (index,item) {
              //    alert(item);
                var selectOption= $("<option></option>").append(item.deptName).attr("value",item.deptId);
                selectOption.appendTo("#dept_add_select");
              })
           }
       })
    }

</script>


<div class="container">
    <!-- 标题-->
    <div class="row">
        <div class="col-md-12"><h1>用户管理</h1></div>
    </div>
    <!-- 按钮-->
    <div class="row" style="display:inline">
        <div class="col-md-6" >
            <div class="input-group" >
                <input type="text" class="form-control">
                <span class="input-group-btn">
						<button class="btn btn-primary" type="button">
							查询
						</button>
					</span>
            </div><!-- /input-group -->
        </div>
        <div class="col-md-6  col-md-offset-10" >
            <button class="btn btn-lg btn-primary" data-toggle="modal" data-target="#addUser" onclick="getAllDepts()">新增</button>
            <button class="btn btn-lg btn-danger">删除</button>
        </div>

    </div>
    <!-- 显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>id</th>
                    <th>姓名</th>
                    <th>用户名</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${message.extend.pageInfo.list}" var="user">
                    <tr>
                        <th>${user.userId}</th>
                        <th>${user.name}</th>
                        <th>${user.loginName}</th>
                        <th>${user.age}</th>
                        <th>${user.sex}</th>
                        <th>${user.email}</th>
                        <th>${user.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑</button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除</button>

                        </th>
                    </tr>

                </c:forEach>

            </table>
        </div>

    </div>
    <!-- 显示分布信息-->
    <div class="row">
        <div class="col-md-6">
            当前第${message.extend.pageInfo.pageNum}页,总共${message.extend.pageInfo.pages}页,总共${message.extend.pageInfo.total}条纪录
        </div>
        <div class="col-md-6">

            <ul class="pagination">
                <li><a href="/getAllUsers?pageNum=1">首页</a></li>
                <c:if test="${!message.extend.pageInfo.isFirstPage}">
                    <li><a href="/getAllUsers?pageNum=${message.extend.pageInfo.pageNum-1}">&laquo;</a></li>
                </c:if>

                <c:forEach items="${message.extend.pageInfo.navigatepageNums}" var="page_Num">
                    <c:if test="${page_Num==message.extend.pageInfo.pageNum}">
                        <li class="active"><a href="#">${page_Num}</a></li>
                    </c:if>
                    <c:if test="${page_Num!=message.extend.pageInfo.pageNum}">
                        <li ><a href="/getAllUsers?pageNum=${page_Num}">${page_Num}</a></li>
                    </c:if>

                </c:forEach>
                <c:if test="${!message.extend.pageInfo.isLastPage}">
                    <li><a href="/getAllUsers?pageNum=${message.extend.pageInfo.pageNum+1}">&raquo;</a></li>
                </c:if>

                <li><a href="/getAllUsers?pageNum=${message.extend.pageInfo.pages}">末页</a></li>
            </ul>


        </div>
    </div>
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
                        <label for="firstname" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="firstname" placeholder="请输入姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="lastname" placeholder="请输入用户名">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="inputPassword" placeholder="请输入密码">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="lastname" placeholder="请输入用户名">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">性别</label>
                        <label class="radio-inline  col-sm-2 col-sm-offset-1">
                            <input type="radio" name="sex"value="option1"> 男
                        </label>
                        <label class="radio-inline col-sm-2">
                            <input type="radio"  name="sex" value="option2"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="lastname" placeholder="请输入邮箱">
                        </div>
                    </div>

                    <div class="form-group" >
                        <label for="lastname" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-5">
                            <select class="form-control " name="dID" id ="dept_add_select">
                            </select>
                        </div>
                    </div>

                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary">
                    保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
