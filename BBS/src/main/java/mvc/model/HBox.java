package mvc.model;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class HBox extends HashMap<String, Object>{
	
	/**
	 * <pre>
	 * HBox 생성자
	 * </pre>
	 */
	public HBox() {}
	/**
	 * <pre>
	 * Map을 파라미터로 받아서 세팅해주는 생성자
	 * </pre>
	 * 
	 * @author In-seong Hwang 
	 * @param map
	 *            입력받은 map
	 * @since 2018.11.011
	 */	
	public <E> HBox(Map<String, Object> map){
		if(map != null) {
			Iterator<String> it = map.keySet().iterator();
			while(it.hasNext()) {
				String key = it.next();
				this.set(key,map.get(key));
			}
		}
	}
	/**
	 * <pre>
	 * 입력받은 key, Value 값을 ABox에 셋팅하는 메소드
	 * </pre>
	 * 
	 * @author In-seong Hwang
	 * @param <E>
	 * @param key
	 *            입력받은 key
	 * @param obj
	 *            입력받은 Object
	 * @since 2018.11.06
	 */
	public <E> HBox set(String key, E obj) {
		super.put(key, obj);
		return this;
	}

	/**
	 * <pre>
	 * 입력받은 key, Value 값을 ABox에 셋팅하는 메소드	 * 
	 * </pre>
	 * 
	 * @param strArray
	 *            : 입력형태 : key:value,key:value...
	 */
	public <E> HBox set(String strArray) {
		String[] splData = strArray.trim().split("\\,");
		for (String data : splData) {
			String[] keyValue = data.trim().split("\\:");
			super.put(keyValue[0].trim(), keyValue[1].trim());
		}
		return this;
	}
	/**
	 * <pre>
	 * JSON 형식의 Data를 hBox 형태로 출력함.
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @param jsonData
	 *            : json Object 형태의 String Data
	 * @since 2018.11.06
	 */
	@SuppressWarnings("unchecked")
	public <E> void setJson(String jsonData) {

		try {
			JSONParser parser = new JSONParser();
			this.putAll(((JSONObject) parser.parse(jsonData)));

		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	/**
	 * <pre>
	 * 입력받은 key 통해 Object 반환한다
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @param <E>
	 * @param key
	 *            입력받은 Key 값
	 * @return 반환할 Object
	 * @since 2018.11.06
	 */
	@SuppressWarnings("unchecked")
	public <E> E get(String key) {
		return (E) super.get(key);
	}

	/**
	 * <pre>
	 * key 에 해당하는 값이 NULL 또는 공백인 경우에는 replaceObj로 대체한다
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @param <E>
	 * @param key
	 *            대체할 SBox의 Key값
	 * @param replaceobj
	 *            대체할 Object
	 * @since 2018.11.06
	 */
	public <E> void setIfEmpty(String key, E replaceobj) {

		if (this.get(key) == null || this.get(key).equals("")) {
			this.set(key, replaceobj);
		}
	}

	/**
	 * <pre>
	 * 해당 Key 값의 Null 또는 공백시 true를 반환한다.
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param key
	 *           key :value 에서 value가 Null인지 체크할 키값
	 * @return true(NULL 또는 공백) / false(데이터존재함)
	 */
	public boolean isEmpty(String key) {
		boolean bTF = false;
		if (this.get(key) == null || this.getString(key).equals("")) {
			bTF = true;
		}
		return bTF;
	}

	/**
	 * <pre>
	 * 입력 받은 Key 통해 String 형 변환 메소드
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param key
	 *            입력값
	 * @return 메소드 내에 정의된 여러 자료형을 String으로 변환한 값
	 */
	public String getString(String key) {
		Object obj = this.get(key);
		String result = "";
		if (obj != null) {
			if (obj instanceof String) {
				result = (String) obj;
			} else if (obj instanceof Integer) {
				result = obj.toString();
			} else if (obj instanceof Long) {
				result = obj.toString();
			} else if (obj instanceof Float) {
				result = obj.toString();
			} else if (obj instanceof Double) {
				result = obj.toString();
			} else if (obj instanceof Boolean) {
				result = obj.toString();
			} else if (obj instanceof Short) {
				result = obj.toString();
			} else if (obj instanceof Date) {
				result = obj.toString();
			} else if (obj instanceof BigInteger) {
				result = ((BigInteger) obj).toString();
			} else if (obj instanceof BigDecimal) {
				result = ((BigDecimal) obj).toString();
			}
		}
		return result;
	}

	/**
	 * <pre>
	 * 입력받은 Key 통해 integer 형 변환 메소드
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param key
	 *            입력값
	 * @return integer 변환값
	 */
	public int getInt(String key) {
		Object obj = this.get(key);
		int result = 0;
		if (obj != null && obj!= "") {
			if (obj instanceof String) {
				result = Integer.parseInt((String) obj);
			} else if (obj instanceof Integer) {
				result = (Integer) obj;
			} else if (obj instanceof Long) {
				result = ((Long) obj).intValue();
			} else if (obj instanceof Double) {
				result = ((Double) obj).intValue();
			} else if (obj instanceof Float) {
				result = ((Float) obj).intValue();
			} else if (obj instanceof Short) {
				result = ((Short) obj).intValue();
			} else if (obj instanceof BigInteger) {
				result = ((BigInteger) obj).intValue();
			} else if (obj instanceof BigDecimal) {
				result = ((BigDecimal) obj).intValue();
			}
		}
		return result;
	}

	/**
	 * <pre>
	 * 입력받은 Key 통해 Long 형 변환 메소드
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param key
	 *            입력값
	 * @return long 변환값
	 */
	public long getLong(String key) {
		Object obj = this.get(key);
		long result = 0L;
		if (obj != null) {
			if (obj instanceof String) {
				result = Long.parseLong((String) obj);
			} else if (obj instanceof Long) {
				result = (Long) obj;
			} else if (obj instanceof Integer) {
				result = ((Integer) obj).longValue();
			} else if (obj instanceof BigInteger) {
				result = ((BigInteger) obj).longValue();
			} else if (obj instanceof BigDecimal) {
				result = ((BigDecimal) obj).longValue();
			}
		}
		return result;
	}

	/**
	 * <pre>
	 * 입력받은 Key 통해 Float 형 변환 메소드
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param key
	 *            입력값
	 * @return Float 변환값
	 */
	public float getFloat(String key) {
		Object obj = this.get(key);
		float result = 0f;
		if (obj != null) {
			if (obj instanceof String) {
				result = Float.parseFloat((String) obj);
			} else if (obj instanceof Float) {
				result = (Float) obj;
			} else if (obj instanceof BigDecimal) {
				result = ((BigDecimal) obj).floatValue();
			} else {
				result = (Float) obj;
			}
		}
		return result;
	}

	/**
	 * <pre>
	 * 입력받은 Key 통해 Double 형 변환 메소드
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param key
	 *            입력값
	 * @return Double 변환값
	 */
	public double getDouble(String key) {
		Object obj = this.get(key);
		double result = 0D;
		if (obj != null) {
			if (obj instanceof String) {
				result = Double.parseDouble((String) obj);
			} else if (obj instanceof Double) {
				result = (Double) obj;
			} else if (obj instanceof BigDecimal) {
				result = ((BigDecimal) obj).doubleValue();
			} else {
				result = (Double) obj;
			}
		}
		return result;
	}
	
}
