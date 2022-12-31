package service.impl;

import bean.PageBean;
import bean.brand;
import mapper.brandMapper;
import org.apache.ibatis.session.SqlSession;
import service.BrandService;
import units.sqlSession;

import java.util.List;
import java.util.Objects;

public class BrandServiceImp implements BrandService {
    /*查询brand所有数据*/
    @Override
    public List<brand> selectAllBrands() {
        /*获得一个sqlSession会话对象*/
        SqlSession SQLSESSION = sqlSession.SQLSession();
        /*获得brandMapper的映射对象*/
        brandMapper brandMapper = SQLSESSION.getMapper(brandMapper.class);
        /*查询所有*/
        List<brand> selectAllBrands = brandMapper.selectAllBrands();
        /*关闭会话*/
        SQLSESSION.close();
        //System.out.println(selectAllBrands);
        return selectAllBrands;
    }

    /*添加数据*/
    @Override
    public void addBrand(brand brandLine) {
        SqlSession session = units.sqlSession.SQLSession();
        brandMapper mapper = session.getMapper(brandMapper.class);
        mapper.addBrand(brandLine);
        session.commit();
        session.close();
    }

    /*通过brand的id修改数据*/
    @Override
    public void updateBrandById(brand brandLine) {
        SqlSession session = units.sqlSession.SQLSession();
        brandMapper mapper = session.getMapper(brandMapper.class);
        mapper.updateBrandById(brandLine);
        session.commit();
        session.close();
    }

    /*通过id数组批量删除数据*/
    @Override
    public void deleteAllByIds(Integer[] ids) {
        SqlSession session = units.sqlSession.SQLSession();
        brandMapper mapper = session.getMapper(brandMapper.class);
        mapper.deleteAllByIds(ids);
        session.commit();
        session.close();
    }

    /*查询全部数据条数*/
    @Override
    public Integer selectCountBrand() {
        SqlSession session = units.sqlSession.SQLSession();
        brandMapper mapper = session.getMapper(brandMapper.class);
        Integer count = mapper.selectCountBrand();
        session.close();
        return count;
    }

    /*查询指定数量数据*/
    @Override
    public PageBean<brand> selectBrandPage(int currentPage, int pageSize) {
        SqlSession session = units.sqlSession.SQLSession();
        brandMapper mapper = session.getMapper(brandMapper.class);
        /*获得开始索引*/
        int start = (currentPage - 1) * pageSize;
        /*计算查询条数*/
        int size = pageSize;
        /*按照查询条数查询数据*/
        List<brand> rows = mapper.selectBrandPage(start, size);
        /*查询所有数据条数*/
        Integer totalCount = mapper.selectCountBrand();
        /*封装pagebean对象*/
        PageBean<brand> brandPageBean = new PageBean<>();
        brandPageBean.setRows(rows);
        brandPageBean.setTotalCount(totalCount);
        /*释放资源*/
        session.close();
        return brandPageBean;
    }

    /*模糊匹配查询brand*/
    @Override
    public PageBean<brand> selectLikeBrand(brand brandList, int start, int pageSize) {
        SqlSession session = units.sqlSession.SQLSession();
        brandMapper mapper = session.getMapper(brandMapper.class);
        /*非空判断防止出现%null%查不到数据*/
        if (brandList.getBrandName() != null && !Objects.equals(brandList.getBrandName(), "")) {
            brandList.setBrandName("%" + brandList.getBrandName() + "%");
        }
        if (brandList.getCompanyName() != null && !Objects.equals(brandList.getCompanyName(), " ")) {
            brandList.setCompanyName("%" + brandList.getCompanyName() + "%");
        }
        List<brand> brands = mapper.selectLikeBrand(brandList, start, pageSize);
        Integer count = mapper.selectCountBrandByCondtion(brandList);
        PageBean<brand> p = new PageBean<>();
        p.setTotalCount(count);
        p.setRows(brands);
        return p;
    }
    /*通过id删除*/
    @Override
    public void deleteBrandById(Integer id) {
        SqlSession session = units.sqlSession.SQLSession();
        brandMapper mapper = session.getMapper(brandMapper.class);
        mapper.deleteById(id);
        session.commit();
        session.close();
    }
}
