package com.its.shop.repository;

import com.its.shop.dto.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public void save(MemberDTO memberDTO) {
        sql.insert("Member.save", memberDTO);
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login", memberDTO);
    }
}
