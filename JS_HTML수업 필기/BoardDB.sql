--답변형 게시판 [BOARD]

--글번호(자동 부여)    board_no       NUMBER        - PRIMARY KEY
--부모글번호          parent_no      NUMBER        - FOREIGN KEY(자기 참조 관계), NULLABLE
--게시물 제목         board_subject  VARCHAR2(30)  - NOT NULL 
--작성자 이름(닉네임)  board_writer   VARCHAR2(30)  - NOT NULL
--내용               board_content  VARCHAR2(300) - NOT NULL 
--작성 시간(자동 부여) board_time     DATE          - NOT NULL
--비밀번호            board_pwd      VARCHAR2(10)  - NOT NULL 

--NUMBER : 값을 안 정하면 number가 표현할수 있는 최대 숫자 까지
--VARCHAR2 : 반드시 사이즈를 지정해줘야함
--VARCHAR2(30) : 한글 10자 정도

--부모글번호 >o------ 글번호
--글번호는 부모글번호를 참조해도 되고 안해도 된다(선택 참조 o)
--부모글번호는 글번호 하나와 매칭, 글번호는 여러 같은 부모글번호를 가진 다양한 릴레이션과 매칭된다

CREATE TABLE board (
    board_no NUMBER CONSTRAINT board_board_no_pk PRIMARY KEY, 
    parent_no NUMBER CONSTRAINT board_parent_no_fk REFERENCES board(board_no), 
    board_subject VARCHAR2(30) NOT NULL, 
    board_writer VARCHAR2(30) NOT NULL, 
    board_content VARCHAR2(300) NOT NULL, 
    board_time DATE NOT NULL, 
    board_pwd VARCHAR2(10) NOT NULL);

INSERT INTO board VALUES(1, NULL, '제목1', 'w1', 'c1', sysdate, '1');
INSERT INTO board VALUES(2, NULL, '제목2', 'w2', 'c2', sysdate, '2');
INSERT INTO board VALUES(3, 2, '제목2-답1', 'w3', 'c3', sysdate, '3');
INSERT INTO board VALUES(4, 1, '제목1-답1', 'w4', 'c4', sysdate, '4');
INSERT INTO board VALUES(5, 4, '제목1-답1-답1', 'w5', 'c5', sysdate, '5');
INSERT INTO board VALUES(6, 4, '제목1-답1-답2', 'w6', 'c6', sysdate, '6');
INSERT INTO board VALUES(7, 1, '제목1-답2', 'w7', 'c7', sysdate, '7');
SELECT * FROM board;

COMMIT;

--EX)
--글번호--부모글번호--게시물 제목--이름--내용--작성 시간--비밀번호
--1      NULL       제목1
--2      NULL       제목2
--3      2          제목2-답1
--4      1          제목1-답1
--5      4          제목1-답1-답1
--6      4          제목1-답1-답2
--7      1          제목1-답2

--원글>답글 순으로 최근순
--2      NULL       제목2
--   ㄴ 3      2          제목2-답1
--1      NULL       제목1
--   ㄴ 7      1          제목1-답2
--   ㄴ 4      1          제목1-답1
--     ㄴ 6      4          제목1-답1-답2
--     ㄴ 5      4          제목1-답1-답1

--계층형 쿼리로 답글 찾기
--1) 원글 찾기
SELECT *
FROM board
START WITH parent_no IS NULL    --START WITH: 계층의 시작 노드 설정
CONNECT BY PRIOR board_no = parent_no;
--CONNECT BY: 어떤 방법으로 다음 연결을 찾는가
--PRIOR board_no: 지금 행의 board_no  
--parent_no: 다른 행의 parent_no

--시간 순 정렬
SELECT rownum, level, board.*            --level: 오라클에서 제공하는 pseudo column
FROM board
START WITH parent_no IS NULL     --START WITH: 계층의 시작 노드 설정
CONNECT BY PRIOR board_no = parent_no
ORDER SIBLINGS BY board_no DESC; --같은 레벨(형제) 사이에서의 정렬 설정

--특정 위치의 행만 검색하기
SELECT rownum, board.*
FROM board
WHERE rownum >=2 AND rownum  <=5;

--한개의 행도 검색되지 않음
SELECT rownum, level, board.*
FROM board
WHERE rownum BETWEEN 1 AND 5
START WITH parent_no IS NULL
CONNECT BY PRIOR board_no = parent_no
ORDER SIBLINGS BY board_no DESC;
--BETWEEN의 매개벼수로1이 들어갈때는 정상 작동하지만 2부터 시작하면 작동 x
--이를 해결하기 위해 인라인뷰를 통해 서브쿼리 작성

--SELECT구문 처리 순서
----------------SELECTION-------------|----Presentation----|
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--                                    이 때, rownum 1 증가

--인라인뷰
SELECT a.*
FROM
    (SELECT rownum rn, level, board.*
    FROM board
    START WITH parent_no IS NULL
    CONNECT BY PRIOR board_no = parent_no
    ORDER SIBLINGS BY board_no DESC) a
WHERE a.rn BETWEEN 2 AND 5;

DESC board;