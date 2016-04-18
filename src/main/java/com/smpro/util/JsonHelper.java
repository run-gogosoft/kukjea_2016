package com.smpro.util;

import lombok.extern.slf4j.Slf4j;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.io.IOException;

/**
 * jackson 라이브러리의 일부를 사용하기 편하도록 구현한 라이브러리
 *
 * ObjectMapper는 static final로 쓰는 것이 좋다고 함 (참고)
 * http://stackoverflow.com/questions/3907929/should-i-make-jacksons-objectmapper-as-static-final
 *
 */
@Slf4j
public class JsonHelper {
	private static final ObjectMapper mapper;
	static {
		mapper = new ObjectMapper();

		// value가 null일 경우 추가되지 않도록 설정
		// 착각하지 말아야할 것은 empty string은 추가될 것이란 점이다
		mapper.setSerializationInclusion( JsonSerialize.Inclusion.NON_NULL );
	}

	public static String render(Object vo) {
		try {
			return mapper.writeValueAsString(vo);
		} catch (JsonGenerationException e) {
			log.error("Json을 만들 수 없었습니다 (JsonGenerationException)");
			log.error(e.getMessage());
			return "{\"error\":\""+ e.getMessage().replaceAll("\"", "\\\"") +"\"}";
		} catch (JsonMappingException e) {
			log.error("Json을 매핑하던 도중 오류가 발생했습니다 (JsonMappingException)");
			log.error(e.getMessage());
			return "{\"error\":\""+ e.getMessage().replaceAll("\"", "\\\"") +"\"}";
		} catch (IOException e) {
			log.error("입출력 도중 오류가 발생했습니다 (IOException)");
			log.error(e.getMessage());
			return "{\"error\":\""+ e.getMessage().replaceAll("\"", "\\\"") +"\"}";
		}
	}
}
