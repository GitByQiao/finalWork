<%--
  Created by IntelliJ IDEA.
  User: 17684
  Date: 2022/12/23
  Time: 17:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>brandInfo前端页面</title>
    <style>
        .el-table .warning-row {
            background: oldlace;
        }

        .el-table .success-row {
            background: #f0f9eb;
        }
    </style>
</head>
<body>
<h1 style="text-align: center">brandInfo前端页面</h1>
<div id="App">
    <%--表单查询--%>
    <el-form :inline="true" :model="brand" class="demo-form-inline">
        <el-form-item label="当前状态">
            <el-select v-model="brand.status" placeholder="当前状态">
                <el-option label="启用" value="1"></el-option>
                <el-option label="禁用" value="0"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="企业名称">
            <el-input v-model="brand.companyName" placeholder="企业名称"></el-input>
        </el-form-item>
        <el-form-item label="品牌名称">
            <el-input v-model="brand.brandName" placeholder="品牌名称"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="onSubmit">查询</el-button>
        </el-form-item>

    </el-form>
    <el-row>
        <%--批量删除和新增按钮--%>
        <el-button type="danger" plain @click="deleteAll()">批量删除</el-button>
        <el-button type="primary" @click="dialogVisible = true" plain>新增</el-button>
    </el-row>
    <%--点击进行修改的对话框--%>
    <el-dialog
            title="修改"
            :visible.sync="dialogVisibleUpdate"
            width="30%">
        <%--点击修改按钮后对话框的表单--%>
        <el-form :model="brand" :rules="rules" ref="brand" label-width="100px" class="demo-ruleForm">
            <el-form-item label="品牌名称" prop="brandName">
                <el-input v-model="brand.brandName"></el-input>
            </el-form-item>
            <el-form-item label="企业名称" prop="companyName">
                <el-input v-model="brand.companyName"></el-input>
            </el-form-item>
            <el-form-item label="排序" prop="ordered">
                <el-input v-model="brand.ordered"></el-input>
            </el-form-item>
            <el-form-item label="备注" prop="description">
                <el-input v-model="brand.description"></el-input>
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-switch v-model="brand.status"
                           active-color="#13ce66"
                           inactive-color="#ff4949"
                           active-value="1"
                           inactive-value="0"></el-switch>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="updateBrand()">确定</el-button>
                <el-button @click="dialogVisibleUpdate=false">返回</el-button>
            </el-form-item>
        </el-form>
    </el-dialog>
    <%--点击新增后出现的对话框--%>
    <el-dialog
            title="添加"
            :visible.sync="dialogVisible"
            width="30%">
        <%--点击新增按钮后对话框的表单--%>
        <el-form :model="brand" :rules="rules" ref="brand" label-width="100px" class="demo-ruleForm">
            <el-form-item label="品牌名称" prop="brandName">
                <el-input v-model="brand.brandName"></el-input>
            </el-form-item>
            <el-form-item label="企业名称" prop="companyName">
                <el-input v-model="brand.companyName"></el-input>
            </el-form-item>
            <el-form-item label="排序" prop="ordered">
                <el-input v-model="brand.ordered"></el-input>
            </el-form-item>
            <el-form-item label="备注" prop="description">
                <el-input v-model="brand.description"></el-input>
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-switch v-model="brand.status"
                           active-color="#13ce66"
                           inactive-color="#ff4949"
                           active-value="1"
                           inactive-value="0"></el-switch>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="addBrand()">添加</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
    </el-dialog>
    <%--表格--%>
    <template>
        <el-table
                :data="tableData"
                style="width: 100%"
                highlight-current-row
        <%--复选框选中事件--%>
                @selection-change="handleSelectionChange"
                :row-class-name="tableRowClassName">
            <el-table-column
                    type="selection"
                    width="55">
            </el-table-column>
            <el-table-column
                    label="序号"
                    type="index"
            <%--绑定下标--%>
                    :index=((this.currentPage-1)*this.pageSize+1)
            <%--prop="id"--%>
                    align="center"
                    width="55">
            </el-table-column>
            <el-table-column
                    prop="brandName"
                    align="center"
                    label="品牌名称">
            </el-table-column>
            <el-table-column
                    prop="companyName"
                    align="center"
                    label="企业名称">
            </el-table-column>
            <el-table-column
                    prop="ordered"
                    align="center"
                    label="排序">
            </el-table-column>
            <el-table-column
                    <%--将1和0修改为启用,禁用--%>
                    prop="statusStr"
                    align="center"
                    label="当前状态">
            </el-table-column>
            <el-table-column
                    align="center"
                    label="操作">
                <%--圆角按钮--%>
                <%--<el-button type="primary" round @click="dialogVisibleUpdate = true">修改</el-button>
                <el-button type="danger" round @click="deleteById">删除</el-button>--%>
                    <template slot-scope="scope">
                        <el-button
                                size="mini"
                                @click="handleEdit(scope.$index, scope.row)">修改</el-button>
                        <el-button
                                size="mini"
                                type="danger"
                                @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
            </el-table-column>
        </el-table>
    </template>
    <%--分页工具条--%>
    <div class="block">
        <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="currentPage"
                :page-sizes="[5,10,20,40,50,80,100,200,400]"
                :page-size="5"
                layout="total, sizes, prev, pager, next, jumper"
                :total="selectCountBrand">
        </el-pagination>
    </div>
</div>
<script src="../js/vue.js"></script>
<script src="../js/axios-0.18.0.js"></script>
<script src="../element-ui/lib/index.js"></script>
<link rel="stylesheet" href="../element-ui/lib/theme-chalk/index.css">
<script>

    new Vue({
        el: "#App",
        mounted() {
            /*挂载,页面加载完成后执行*/
            this.selectAll();
        },
        methods: {

            /*通过id删除当前行*/
            deleteById(){
                let that=this;
                axios({
                    method:"post",
                    url:"http://localhost:8080/finalWork/brand/deleteBrandById",
                    data:that.UpDeById
                }).then(resp=>{
                    if (resp.data==="success"){
                        this.addSuccess();
                        this.selectAll()
                    }else {
                        this.addFail();
                        this.selectAll()
                    }
                })
            },
            /*批量删除*/
            deleteAll() {
                let that = this;
                let selection = this.multipleSelection;
                for (let i = 0; i < selection.length; i++) {
                    this.deleteAllByIds[i] = selection[i].id;
                }
                console.log(this.deleteAllByIds);
                axios({
                    url: "http://localhost:8080/finalWork/brand/deleteAllByIds",
                    method: "post",
                    data: this.deleteAllByIds
                }).then(/*function (resp) {
                    if (resp.data === "success") {
                        /!*删除成功*!/
                        console.log("成功");
                        that.selectAll();
                        that.deleteAllByIds = []
                    }
                }*/
                resp=>{
                    if (resp.data === "success") {
                        /*/!*删除成功*!/*/
                        this.addSuccess();
                        this.selectAll();
                        this.deleteAllByIds = []
                    }
                })
            },
            /*修改brand数据*/
            updateBrand() {
                let that = this;
                this.brand.id=that.UpDeById;
                axios({
                    method: "post",
                    url: "http://localhost:8080/finalWork/brand/updateBrandById",
                    data: that.brand
                }).then(function (resp) {
                    if (resp.data === "success") {
                        that.dialogVisibleUpdate = false
                        that.selectAll();
                    } else {
                        that.addFail();
                        that.selectAll();
                    }
                })
            },
            /*查询页面*/
            selectAll() {
                let that = this;
                /*查询brand所有*/
                /*axios({
                    method: "post",
                    url: "http://localhost:8080/finalWork/brand/SelectAllServlet",
                }).then(function (resp) {
                    that.tableData = resp.data;
                });*/
                /*查询当前页码指定条数*/
                axios({
                    method: "post",
                    url: "http://localhost:8080/finalWork/brand/selectLikeBrand?" +
                        "currentPage=" + that.currentPage + "&pageSize=" + that.pageSize,
                    data: that.brand
                }).then(function (resp) {
                    /*查询指定条数的数据*/
                    that.tableData = resp.data.rows;
                    /*总数据条数*/
                    that.selectCountBrand = resp.data.totalCount;
                })
            },
            tableRowClassName({row, rowIndex}) {
                if (rowIndex === 1) {
                    return 'warning-row';
                } else if (rowIndex === 3) {
                    return 'success-row';
                }
                return '';
            },
            /*增删改查页面复选框选中事件方法*/
            handleSelectionChange(val) {
                this.multipleSelection = val;
                //console.log(this.multipleSelection)
            },
            /*表单查询进行查询按钮*/
            onSubmit() {
                /*console.log(this.brand);*/
                this.selectAll();
            },
            //添加成功提示
            addSuccess() {
                //消息提示添加成功
                this.$message({
                    message: '恭喜你，成功',
                    type: 'success'
                });
            },
            addFail() {
                this.$message.error('错了哦，失败');
            },
            /*新增表单的提交方法*/
            addBrand() {
                let that = this;
                console.log(that.brand);
                axios({
                    url: "http://localhost:8080/finalWork/brand/AddBrandServlet",
                    method: "post",
                    data: that.brand
                }).then(function (resp) {
                    console.log(resp);
                    if (resp.data === "success") {
                        //添加成功
                        //alert("添加成功");
                        //console.log("___"+resp+"___")
                        that.selectAll();
                        //添加成功提醒
                        that.addSuccess();
                        //关闭窗口
                        that.dialogVisible = false;
                    } else {
                        //提示添加失败
                        that.addFail();
                    }
                })
            },
            /*新增表单的重置方法*/
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
            /*分页工具条每页多少条数据*/
            handleSizeChange(val) {
                /*console.log(`每页
                <%--${val}--%> 条`);*/
                /*设置查询条数*/
                this.pageSize = val;
                this.selectAll();
            },
            /*分页工具条当前是多少页*/
            handleCurrentChange(val) {
                /*console.log(`当前页:
                <%--${val}--%>`);*/
                /*设置当前页码*/
                this.currentPage = val
                this.selectAll();
            },
            /*更新按钮*/
            handleEdit(index, row) {
                this.dialogVisibleUpdate = true
                /*获得当前行数据在数据库的id*/
                this.UpDeById=row.id;
                /*获得当前行的下标（从0开始）和数据库中当前数据的id*/
                console.log(this.UpDeById);
            },
            /*删除按钮*/
            handleDelete(index, row) {
                /*获得当前行数据在数据库的id*/
                this.UpDeById=row.id;
                /*获得当前行的下标（从0开始）和数据库中当前数据的id*/
                /*通过id删除*/
                this.deleteById();
                console.log(index, row);
            }
        },
        data() {
            return {
                /*新增表单填写数据的规则限制*/
                rules: {
                    brandName: [
                        {required: true, message: '请输入品牌名称', trigger: 'blur'},
                        {min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'blur'}
                    ],
                    companyName: [
                        {required: true, message: '请输入公司名称', trigger: 'blur'},
                        {min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'blur'}
                    ]
                },
                /*新增按钮对话框是否显示*/
                dialogVisible: false,
                /*修改对话框按钮是否显示*/
                dialogVisibleUpdate: false,
                /*搜索表单模型数据*/
                brand: {
                    id: '',
                    brandName: '',
                    companyName: '',
                    ordered: '',
                    description: '',
                    status: '',
                },
                /*brand总数据条数*/
                selectCountBrand: 400,
                currentRow: null,
                /*复选框选中获得行的数据的id*/
                deleteAllByIds: [],
                /*复选框选中获得行的数据*/
                multipleSelection: [],
                /*表格数据*/
                tableData: [],
                /*当前数据编号*/
                indexId: ((this.currentPage - 1) * this.pageSize + 1),
                /*分页工具条的当前页码*/
                currentPage: 1,
                /*要查询的数据条数*/
                pageSize: 5,
                /*删除和修改本行所需要的id*/
                UpDeById:""
            }
        }
    })
</script>
</body>
</html>
