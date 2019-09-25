package listener;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;


public class mySessionAttributeListener implements HttpSessionAttributeListener {

	private int loginedCnt = 0;
	
    public mySessionAttributeListener() {
    }

    public void attributeAdded(HttpSessionBindingEvent e)  { 
    	// 세션에 attribute가 추가될때 자동 호출되는 메서드
    	// HttpSession session = e.getSession();
    	String attrName = e.getName();
    	Object attrValue = e.getValue();
    	if(attrName.equals("loginInfo")) {
    		// 로그인된 경우
    		loginedCnt++;
    		System.out.println("지금 로그인한 고객: " + attrValue);
    		System.out.println("총 로그인된 고객 수: " + loginedCnt);
    	}
    	
    }

    public void attributeRemoved(HttpSessionBindingEvent e)  { 
         // 세션에서 속성이 제거되거나, 세션 자체가 소멸 될 때 호출되는 메서드
    	String attrName = e.getName();
    	Object attrValue = e.getValue();
    	if(attrName.equals("loginInfo")) {
    		// 로그아웃 된 경우
    		loginedCnt--;
    		System.out.println("지금 로그아웃한 고객: " + attrValue);
    		System.out.println("총 로그인된 고객 수: " + loginedCnt);
    	}
    }

    public void attributeReplaced(HttpSessionBindingEvent arg0)  { 
         
    }
	
}
