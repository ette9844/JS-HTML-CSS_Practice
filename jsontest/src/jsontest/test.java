package jsontest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class test {
	public static void main(String[] args) {
		JSONParser parser = new JSONParser();

		// 문자열 -> JSON객체 전환
		String s = "{\"a\":1}";
		try {
			Object obj = parser.parse(s);
			JSONObject jsonObj = (JSONObject) obj;

			long a = (Long) jsonObj.get("a"); // downcasting + autounboxing
			System.out.println("a=" + a);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// 문자열 -> JSON배열객체 전환
		String sArr = "[{\"a\":1}, {\"a\":2}]";
		try {
			Object obj1 = parser.parse(sArr);
			JSONArray jsonArr = (JSONArray) obj1;

			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject obj2 = (JSONObject) jsonArr.get(i);
				System.out.println(i + "=" + obj2.get("a"));
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		// json객체 -> 문자열 전환
		JSONObject json1 = new JSONObject();
		json1.put("b", "one");
		json1.put("c", 99);
		System.out.println(json1);	// = System.out.println(json1.toString());
		
		// json배열객체 -> 문자열 전환
		JSONArray jsonArr1 = new JSONArray();
		jsonArr1.add(json1);	// json객체를 add
		
		JSONObject json2 = new JSONObject();
		json2.put("b", "two");
		json2.put("c", 100);
		jsonArr1.add(json2);
		
		System.out.println(jsonArr1.toString());
	}
}
