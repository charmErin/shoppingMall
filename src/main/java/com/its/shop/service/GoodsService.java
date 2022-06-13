package com.its.shop.service;

import com.its.shop.dto.GoodsDTO;
import com.its.shop.repository.GoodsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class GoodsService {
    @Autowired
    private GoodsRepository goodsRepository;

    public void save(GoodsDTO goodsDTO) throws IOException {
        MultipartFile goodsFile1 = goodsDTO.getGoodsFile1();
        String goodsFileName1 = goodsFile1.getOriginalFilename();
        goodsFileName1 = System.currentTimeMillis() + "-" + goodsFileName1;
        String savePath1 = "D:\\shop_img\\" + goodsFileName1;

        if (!goodsFile1.isEmpty()){
            goodsFile1.transferTo(new File(savePath1));
            goodsDTO.setGoodsFileName1(goodsFileName1);
        }

        MultipartFile goodsFile2 = goodsDTO.getGoodsFile2();
        String goodsFileName2 = goodsFile2.getOriginalFilename();
        goodsFileName2 = System.currentTimeMillis() + "-" + goodsFileName2;
        String savePath2 = "D:\\shop_img\\" + goodsFileName2;

        if (!goodsFile2.isEmpty()){
            goodsFile2.transferTo(new File(savePath2));
            goodsDTO.setGoodsFileName2(goodsFileName2);
        }
        goodsRepository.save(goodsDTO);
    }

    public List<GoodsDTO> findAll() {
        return goodsRepository.findAll();
    }

    public List<GoodsDTO> list(int goodsCategory) {
        return goodsRepository.list(goodsCategory);
    }

    public GoodsDTO findById(Long id) {
        return goodsRepository.findById(id);
    }

    public void update(GoodsDTO goodsDTO) throws IOException {
        MultipartFile goodsFile1 = goodsDTO.getGoodsFile1();
        String goodsFileName1 = goodsFile1.getOriginalFilename();
        goodsFileName1 = System.currentTimeMillis() + "-" + goodsFileName1;
        String savePath1 = "D:\\shop_img\\" + goodsFileName1;

        if (!goodsFile1.isEmpty()){
            goodsFile1.transferTo(new File(savePath1));
            goodsDTO.setGoodsFileName1(goodsFileName1);
        }

        MultipartFile goodsFile2 = goodsDTO.getGoodsFile2();
        String goodsFileName2 = goodsFile2.getOriginalFilename();
        goodsFileName2 = System.currentTimeMillis() + "-" + goodsFileName2;
        String savePath2 = "D:\\shop_img\\" + goodsFileName2;

        if (!goodsFile2.isEmpty()){
            goodsFile2.transferTo(new File(savePath2));
            goodsDTO.setGoodsFileName2(goodsFileName2);
        }
        goodsRepository.update(goodsDTO);
    }

    public List<GoodsDTO> search(String search) {
        return goodsRepository.search(search);
    }

    public void delete(Long id) {
        goodsRepository.delete(id);
    }
}
