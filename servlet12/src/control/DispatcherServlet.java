package control;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// servlet 통합하기
// url-pattern : /* 
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardController boardC;
	
	public DispatcherServlet() {
		boardC = new BoardController();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("DispatcherServlet 의 service()가 호출됨!");
		String uri = request.getRequestURI();
		System.out.println("uri="+uri);
		
		// servlet name 얻어오기
		String contextPath = request.getContextPath();
		int index = contextPath.length();
		String servletPath = uri.substring(index);
		System.out.println(servletPath);
		
		String path = "/error/err404.jsp";
//		if("/boardlist".equals(servletPath)) {
//			path = boardC.boardList(request, response);
//		} else if("/boarddetail".equals(servletPath)) {
//			path = boardC.boardDetail(request, response);
//		}
		// if else 구문이 너무 늘어남 => reflection 사용
		
		// reflection: 엔진이 하는일, spring framework 내부 구조
		// 1) dispatcher.properties 파일의 프로퍼티 이름과 값 가져오기
		ServletContext sc = getServletContext();
		String realPath = sc.getRealPath("dispatcher.properties");
		
		Properties env = new Properties();	// Map 계열 API
		env.load(new FileInputStream(realPath));	// properties 파일 로드
													// 파일에 있는 property들이 env에 저장됨
		// 2) servletPath 변수값과 같은 프로퍼티를 찾기
		String classNMethodName = env.getProperty(servletPath);
		
		// 3) 프로퍼티 값 얻기, 분석
		int classNMethodIndex = classNMethodName.lastIndexOf(".");
		String className = classNMethodName.substring(0, classNMethodIndex);
		String methodName = classNMethodName.substring(classNMethodIndex+1);
		
		// 4) 클래스 이름과 메서드 이름 찾기 (reflection)
		try { // runtime dynamic load:이름에 해당하는 클래스를 찾아서 JVM 메모리 위로 올려주기
			Class clazz = Class.forName(className);
			Object obj = clazz.newInstance();	// 클래스 타입 객체 생성
			Method method = clazz.getMethod(methodName
					, HttpServletRequest.class
					, HttpServletResponse.class);
			method.invoke(obj, request, response);	// 호출
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		}
		
		// 5) 클래스 이름에 해당 객체 찾기 (singleton 패턴 사용)
		// 6) 객체가 갖고 있는 메서드 이름으로 메서드 찾기
		// 7) 메서드 호출하기
		
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}
}
