package com.smpro.component.admin.annotation;

import com.smpro.service.SystemService;
import com.smpro.util.Const;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/*
 * CheckGrade Custom Annotation에서 받아온 값으로 관리자 권한 검증을 처리하는 클래스이다.
 * 
 * @Aspect: Spring은 자동적으로 @Aspect 어노테이션을 포함한 클래스를 검색하여 Spring AOP 설정에 반영한다.
 * 
 * @Component: 자동인식이 되는 일반 컴퍼넌트이다.
 * 
 * @Around: CheckGrade Custom Annotation을 언제 적용할 것인지 판단한다.(Around는 메소드 호출 전후,예외등
 * 다양한 관점을 포함한다)
 */
@Aspect
@Component
public class CheckGradeValidator {
	
	@Autowired
	private SystemService systemService;

	@Around("@annotation(CheckGrade)")
	public Object target(ProceedingJoinPoint pjp) throws Throwable {		
		/** 메소드의 특성과 메소드 이름, 파라미터, 반환값의 테이터 타입을 가진다. */
		MethodSignature signature = (MethodSignature) pjp.getSignature();
		Method method = signature.getMethod();
		CheckGrade cg = method.getAnnotation(CheckGrade.class);

		if (systemService.checkGrade(cg.controllerName(), cg.controllerMethod())) {
			/** 결과가 true 라면 CheckGrade Annotation을 선언한 ControllerMethod를 작동시킨다. */
			return pjp.proceed();
		}

		/** 결과가 false 라면 ControllerMethod를 작동시키지 않고 페이지를 뒤로 이동시킨다. */
		return Const.BACK_PAGE;
	}
}