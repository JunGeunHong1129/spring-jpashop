package jpabook.jpashop.common.exception.advice;

import jpabook.jpashop.common.exception.ErrorResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class ApiControllerExAdvice {

    @ExceptionHandler
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResult exHandle(Exception e){
        log.error("[error] 에러 발생: {}",e.getMessage());

        return new ErrorResult("EX",e.getLocalizedMessage());
    }

}
