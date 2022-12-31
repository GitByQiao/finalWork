package web.servlet;

import bean.PageBean;
import bean.brand;
import com.alibaba.fastjson.JSON;
import service.BrandService;
import service.impl.BrandServiceImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = "/brand/*")
public class BrandServlet extends BaseServlet {
    private BrandService brandService = new BrandServiceImp();

    public void AddBrandServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*获得表单的json类型的数据*/
        String line = request.getReader().readLine();
        /*将json数据转变为brand的对象*/
        brand brandLine = JSON.parseObject(line, brand.class);
        /*添加数据*/
        brandService.addBrand(brandLine);
        response.setCharacterEncoding("utf-8");
        response.getWriter().write("success");
    }

    public void SelectAllServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //查询所有数据
        List<brand> selectAllBrands = brandService.selectAllBrands();
        //将对象封装的数据变成json数据
        String selectAll = JSON.toJSONString(selectAllBrands);
        response.setContentType("text/json;charset=utf-8");
        response.getWriter().write(selectAll);
    }
    public void updateBrandById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //post请求体获得页面修改后的json数据
        String line = request.getReader().readLine();
        System.out.println(line);
        //将json数据变成brand对象
        brand brandLine = JSON.parseObject(line, brand.class);
        System.out.println(brandLine);
        //修改brand数据
        brandService.updateBrandById(brandLine);
        response.getWriter().write("success");
    }
    public void deleteAllByIds(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获得页面修改后的json数据
        String line = request.getReader().readLine();
        //将json数据变成brand对象
        Integer[] integers = JSON.parseObject(line, Integer[].class);
        if (integers.length>0){
            //删除数据
            brandService.deleteAllByIds(integers);
            response.getWriter().write("success");
        }else {
            response.getWriter().write("fail");
        }
    }
    public void selectCountBrand(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer count = brandService.selectCountBrand();
        String s=new String(String.valueOf(count));
        System.out.println(s);
        response.getWriter().write(s);
    }
    public void selectBrandPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*获得当前页码,每次查询条数*/
        String _currentPage = request.getParameter("currentPage");
        String _pageSize = request.getParameter("pageSize");
        /*类型转换*/
        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);
        /*进行查询*/
        PageBean<brand> brandPageBean = brandService.selectBrandPage(currentPage, pageSize);
        /*将数据转换为json类型*/
        String s = JSON.toJSONString(brandPageBean);
        /*设置为json类型输出*/
        response.setContentType("text/json;charset=utf-8");
        response.getWriter().write(s);
    }
    public void selectLikeBrand(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*获得当前页码,每次查询条数*/
        String _currentPage = request.getParameter("currentPage");
        String _pageSize = request.getParameter("pageSize");
        String line = request.getReader().readLine();
        System.out.println(line);
        /*类型转换*/
        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);
        /*获得开始索引*/
        int start = (currentPage - 1) * pageSize;
        /*计算查询条数*/
        int size = pageSize;
        /*进行类型转换*/
        brand brandLine = JSON.parseObject(line, brand.class);
        System.out.println(brandLine);
        /*进行条件查询*/
        PageBean<bean.brand> brandPageBean = brandService.selectLikeBrand(brandLine, start, size);
        /*进行类型转换*/
        String s = JSON.toJSONString(brandPageBean);
        /*设置为json类型输出*/
        response.setContentType("text/json;charset=utf-8");
        response.getWriter().write(s);
    }
    /*通过id删除*/
    public void deleteBrandById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*获得id数据*/
        String line = request.getReader().readLine();
        //转换类型
        Integer id = Integer.parseInt(line);
        //通过id删除
        brandService.deleteBrandById(id);
        /*返回数据*/
        response.getWriter().write("success");
    }
}
