select *
from post
where ( doro || ' ' || building1 ) = '도움5로 19';

select zipcode || CHR(10)
|| sido || ' ' || doro || ' ' || building1 || ' ' || decode(dong, NULL, '', '(' || dong || decode(building, NULL, '', ', ' || building) || ')') || CHR(10) 
|| sido || ' ' || dong || ' ' || decode(building, NULL, '', '(' || building || ') ') || decode(zibun2, 0, '', zibun2)
from post
where ( doro || ' ' || building1 ) = '도움5로 19';

select zipcode || CHR(10)
|| sido || ' ' 
|| decode(eupmyun, NULL, '', eupmyun || ' ') 
|| doro || ' ' 
|| building1 
|| decode(building2, 0, '', '-' || building2) || ' '
|| decode(dong, NULL, '', '(' || dong 
|| decode(building, NULL, '', ', ' || building) || ')') 
|| decode(ri, NULL, '', '(' || ri || ')') || CHR(10) 
|| sido || ' ' 
|| decode(eupmyun, NULL, '', eupmyun) 
|| decode(dong, NULL, '', dong) || ' ' 
|| decode(ri, NULL, '', ri || ' ')
|| decode(building, NULL, '', '(' || building || ') ') 
|| decode(eupmyun, NULL, '', zibun1 
|| decode(zibun2, 0, '', '-' || zibun2) )
from post
where ( doro || ' ' || building1 || '-' || building2 ) = '금천2길 27-17'
or ( doro || ' ' || building1 ) = '도움5로 19';

--컬럼 분석
--우편번호: NOT NULL
--시도: NOT NULL
--도로명: NOT NULL
--시군구: NULLABLE
--읍명: NULLABLE
--동: NULLABLE
--리: NULLABLE
--지번1, 지번2: NULLABLE
--건물명: NULLABLE

select * 
from post 
where building1 = '0' or building1 is null; --building1은 NOT NULL

select *
from post
where dong is null and ri is null; --동, 리 둘다 null인 값은 없다

--이런식으로 칼럼의 값을 검사해 분석할 수 있다

--주소 정보 분석
--도로명 주소: 시도, 시군구, 읍면, 도로명, 건물명, 건물번호1-건물번호2, (동 또는 리, 건물명)
--지번 주소: 시도, 시군구, 읍면, 동 또는 리, 지번1-지번2, (건물명)

SELECT zipcode,
sido || ' '
|| sigungu || NVL2(sigungu, ' ', '') --시군구: NULL이면 공백 + 컬럼이 NULL일 경우 빈 문자열 출력 / NULL이 아니면 공백 한칸 출력
|| eupmyun || NVL2(eupmyun, ' ', '')
|| doro || ' '
|| building1
|| DECODE(building2, '0', '', '-'||building2) || ' '
|| '(' || dong || ri || DECODE(building, '', '', ', ' || building) || ')'
|| chr(13) || chr(10) --줄바꿈
|| sido ||' ' 
|| sigungu ||NVL2(sigungu,' ', '')
|| eupmyun ||NVL2(eupmyun,' ', '')
|| dong || ri ||' ' ||  zibun1 || DECODE(zibun2, '0', '',  '-'|| zibun2)    || DECODE(building, '', '', ' (' ||building ||')')
FROM post
WHERE ( doro || ' ' || building1 || DECODE(building2, '0', '', '-'||building2)) = '세종로 2511';
