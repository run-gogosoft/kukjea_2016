package com.smpro.component.admin.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/*
 * 관리자 권한 체크를 하기위한 ControllerName과 ControllerMethod을 받는 Custom Annotation이다.
 * 
 * @Target: Custom Annotation이 어디에 사용될 것인지 지정해주는 Annotation으로 현재는 메소드에 사용하겠다고
 * 지정해 두었다.
 * 
 * @Retiontion: Custom Annotation이 어떠한 지속성을 지닐 것인지 지정해주는 Annotation으로 현재는
 * RUNTIME을 사용하겠다고 지정해 두었다. (JVM에 지속시킴으로써 CheckGradeValidator클래스에서 Custom
 * Annotation의 데이터를 가져 올수 있다.)
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface CheckGrade {
	String controllerName() default "";

	String controllerMethod() default "";
}