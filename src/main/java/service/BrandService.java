package service;

import bean.PageBean;
import bean.brand;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BrandService {

    List<brand> selectAllBrands();
    void addBrand(brand brandLine);
    void updateBrandById(brand brandLine);
    void deleteAllByIds(Integer[] ids);
    Integer selectCountBrand();
    PageBean<brand> selectBrandPage(int currentPage, int pageSize);
    /*模糊匹配查询brand*/
    PageBean<brand> selectLikeBrand(brand brandList, int start, int pageSize);
    /*通过id删除*/
    void deleteBrandById(Integer id);
}
