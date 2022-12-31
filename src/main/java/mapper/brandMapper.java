package mapper;

import bean.PageBean;
import bean.brand;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface brandMapper {
    /*通过id查询所有*/
    List<brand> selectAllByIdBrands(@Param("id")Integer id);
    /*查询所有*/
    List<brand> selectAllBrands();
    /*添加数据*/
    void addBrand(brand brandLine);
    /*通过id修改数据*/
    void updateBrandById(brand brandLine);
    /*通过id数组删除数组中包含id的数据*/
    void deleteAllByIds(@Param("ids") Integer[] ids);
    /*从start+1开始查询size条数据*/
    List<brand> selectBrandPage(@Param("start") int start, @Param("pageSize") int pageSize);
    /*查询brand一共有多少数据*/
    Integer selectCountBrand();
    /*通过条件查询一共有多少数据*/
    Integer selectCountBrandByCondtion(brand brandLine);
    /*通过搜索框模糊匹配查询数据*/
    List<brand> selectLikeBrand(@Param("brand")brand brandList,
                                @Param("start")int start,
                                @Param("pageSize") int pageSize);
    void deleteById(@Param("id") Integer id);
}
