--글번호용 시퀀스 객체 생성
CREATE SEQUENCE board_seq
START WITH 11;

--원글 쓰기용 insert문
INSERT INTO board VALUES (board_seq.NEXTVAL, null, '시퀀스', 'JSTL', '시퀀스를 nextval을 사용하여 글번호를 자동 붙이기', SYSDATE, 'w8w');